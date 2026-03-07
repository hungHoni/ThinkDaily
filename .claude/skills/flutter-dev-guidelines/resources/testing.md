# Testing — Unit, Widget, Integration

## Setup

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mocktail: ^1.0.4
  fake_async: ^1.3.1
```

Run tests:
```bash
flutter test                           # all unit + widget tests
flutter test test/features/orders/    # specific folder
flutter test --coverage               # with coverage report
flutter drive --target=integration_test/app_test.dart  # integration
```

---

## Unit Tests — Repositories

```dart
// test/features/orders/data/order_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOrderRemoteSource extends Mock implements OrderRemoteSource {}
class MockOrderLocalSource extends Mock implements OrderLocalSource {}

void main() {
  late MockOrderRemoteSource mockRemote;
  late MockOrderLocalSource mockLocal;
  late OrderRepositoryImpl sut;

  setUp(() {
    mockRemote = MockOrderRemoteSource();
    mockLocal = MockOrderLocalSource();
    sut = OrderRepositoryImpl(mockRemote, mockLocal);
  });

  group('getOrders', () {
    final fakeOrders = [
      Order(id: '1', userId: 'u1', items: [], total: 50, createdAt: DateTime.now(), status: OrderStatus.pending),
    ];

    test('returns orders from remote and caches them', () async {
      when(() => mockRemote.getOrders()).thenAnswer((_) async =>
          fakeOrders.map(OrderModel.fromDomain).toList());
      when(() => mockLocal.cacheOrders(any())).thenAnswer((_) async {});

      final result = await sut.getOrders();

      expect(result, equals(fakeOrders));
      verify(() => mockLocal.cacheOrders(fakeOrders)).called(1);
    });

    test('falls back to cache on network error', () async {
      when(() => mockRemote.getOrders()).thenThrow(
          DioException(requestOptions: RequestOptions()));
      when(() => mockLocal.getOrders()).thenAnswer((_) async => fakeOrders);

      final result = await sut.getOrders();

      expect(result, equals(fakeOrders));
    });

    test('throws AppException when network fails and cache is empty', () async {
      when(() => mockRemote.getOrders()).thenThrow(
          DioException(requestOptions: RequestOptions()));
      when(() => mockLocal.getOrders()).thenAnswer((_) async => []);

      expect(() => sut.getOrders(), throwsA(isA<AppException>()));
    });
  });
}
```

---

## Unit Tests — Riverpod Providers

```dart
// test/features/orders/presentation/providers/orders_provider_test.dart
void main() {
  late MockOrderRepository mockRepo;

  setUp(() {
    mockRepo = MockOrderRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer(
    overrides: [
      orderRepositoryProvider.overrideWithValue(mockRepo),
    ],
  );

  test('ordersNotifier loads orders on build', () async {
    final fakeOrders = [fakeOrder];
    when(() => mockRepo.getOrders()).thenAnswer((_) async => fakeOrders);

    final container = makeContainer();
    addTearDown(container.dispose);

    final result = await container.read(ordersNotifierProvider.future);
    expect(result, fakeOrders);
  });

  test('placeOrder updates state with new order', () async {
    when(() => mockRepo.getOrders()).thenAnswer((_) async => []);
    when(() => mockRepo.placeOrder(any())).thenAnswer((_) async => fakeOrder);

    final container = makeContainer();
    addTearDown(container.dispose);

    await container.read(ordersNotifierProvider.future); // wait for initial load

    await container
        .read(ordersNotifierProvider.notifier)
        .placeOrder(fakeRequest);

    final state = container.read(ordersNotifierProvider);
    expect(state.value, contains(fakeOrder));
  });

  test('placeOrder sets error state on failure', () async {
    when(() => mockRepo.getOrders()).thenAnswer((_) async => []);
    when(() => mockRepo.placeOrder(any())).thenThrow(const AppException.network('fail'));

    final container = makeContainer();
    addTearDown(container.dispose);

    await container.read(ordersNotifierProvider.future);
    await container.read(ordersNotifierProvider.notifier).placeOrder(fakeRequest);

    final state = container.read(ordersNotifierProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<AppException>());
  });
}
```

---

## Widget Tests

```dart
// test/features/orders/presentation/screens/orders_screen_test.dart
void main() {
  late MockOrderRepository mockRepo;

  setUp(() => mockRepo = MockOrderRepository());

  Widget buildWidget() => ProviderScope(
    overrides: [
      orderRepositoryProvider.overrideWithValue(mockRepo),
    ],
    child: const MaterialApp(
      home: OrdersScreen(),
    ),
  );

  testWidgets('shows loading indicator while fetching', (tester) async {
    when(() => mockRepo.getOrders()).thenAnswer(
      (_) async => await Future.delayed(const Duration(seconds: 1), () => []),
    );

    await tester.pumpWidget(buildWidget());
    // First frame — loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows order list when data loads', (tester) async {
    when(() => mockRepo.getOrders()).thenAnswer((_) async => [fakeOrder]);

    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    expect(find.byType(OrderCard), findsOneWidget);
    expect(find.text(fakeOrder.id), findsOneWidget);
  });

  testWidgets('shows empty state when no orders', (tester) async {
    when(() => mockRepo.getOrders()).thenAnswer((_) async => []);

    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    expect(find.byType(EmptyStateWidget), findsOneWidget);
  });

  testWidgets('shows error and retry button on failure', (tester) async {
    when(() => mockRepo.getOrders()).thenThrow(const AppException.noInternet());

    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    expect(find.text('No internet connection.'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });

  testWidgets('retry calls repository again', (tester) async {
    int callCount = 0;
    when(() => mockRepo.getOrders()).thenAnswer((_) async {
      callCount++;
      if (callCount == 1) throw const AppException.noInternet();
      return [fakeOrder];
    });

    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();

    expect(find.byType(OrderCard), findsOneWidget);
    expect(callCount, 2);
  });
}
```

---

## Widget Test — Navigation

```dart
testWidgets('tapping card navigates to detail screen', (tester) async {
  when(() => mockRepo.getOrders()).thenAnswer((_) async => [fakeOrder]);

  final router = GoRouter(
    initialLocation: '/orders',
    routes: [
      GoRoute(path: '/orders', builder: (_, __) => const OrdersScreen()),
      GoRoute(
        path: '/orders/:id',
        builder: (_, state) => OrderDetailScreen(id: state.pathParameters['id']!),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [orderRepositoryProvider.overrideWithValue(mockRepo)],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();

  await tester.tap(find.byType(OrderCard).first);
  await tester.pumpAndSettle();

  expect(find.byType(OrderDetailScreen), findsOneWidget);
});
```

---

## Testing Forms

```dart
testWidgets('submit button disabled when form invalid', (tester) async {
  await tester.pumpWidget(ProviderScope(child: MaterialApp(home: LoginForm())));

  final button = tester.widget<FilledButton>(find.byType(FilledButton));
  expect(button.onPressed, isNull);  // disabled

  await tester.enterText(find.byKey(const Key('email-field')), 'test@test.com');
  await tester.enterText(find.byKey(const Key('password-field')), 'password123');
  await tester.pump();

  final buttonAfter = tester.widget<FilledButton>(find.byType(FilledButton));
  expect(buttonAfter.onPressed, isNotNull);  // enabled
});
```

---

## Test File Naming Convention

```
test/
  features/
    orders/
      data/
        order_repository_test.dart
        order_remote_source_test.dart
      domain/
        place_order_use_case_test.dart
      presentation/
        providers/
          orders_provider_test.dart
        screens/
          orders_screen_test.dart
        widgets/
          order_card_test.dart
  core/
    network/
      dio_client_test.dart
    error/
      app_exception_test.dart
integration_test/
  app_test.dart
  features/
    auth_flow_test.dart
    order_flow_test.dart
```

---

## Test Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

Minimum targets:
- Repositories: 90%+
- Providers/Notifiers: 85%+
- Use cases: 95%+
- Widgets: 70%+ (cover happy path + error states)
