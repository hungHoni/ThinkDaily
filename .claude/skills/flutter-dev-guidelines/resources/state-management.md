# State Management — Riverpod Patterns

Using `flutter_riverpod` + `riverpod_annotation` (code generation). All providers use the `@riverpod` annotation pattern.

## Setup

```yaml
# pubspec.yaml
dependencies:
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

dev_dependencies:
  riverpod_generator: ^2.4.3
  build_runner: ^2.4.9
```

```dart
// main.dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

Run code generation:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Provider Types

### 1. AsyncNotifierProvider — async data with mutations

Use for: screens that load data from network/DB and need mutation methods.

```dart
// orders_provider.dart
part 'orders_provider.g.dart';

@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  FutureOr<List<Order>> build() async {
    // Called once on first watch, re-called on invalidate
    return ref.read(orderRepositoryProvider).getOrders();
  }

  Future<void> placeOrder(OrderRequest request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(orderRepositoryProvider).placeOrder(request),
    );
  }

  Future<void> deleteOrder(String id) async {
    // Optimistic update
    final previous = state;
    state = AsyncValue.data(
      state.value!.where((o) => o.id != id).toList(),
    );
    try {
      await ref.read(orderRepositoryProvider).deleteOrder(id);
    } catch (e, st) {
      state = previous; // rollback
      Error.throwWithStackTrace(e, st);
    }
  }
}
```

### 2. NotifierProvider — sync state with mutations

Use for: UI state (filters, tabs, selected items), form state.

```dart
@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  OrderFilter build() => const OrderFilter();

  void setStatus(OrderStatus status) {
    state = state.copyWith(status: status);
  }

  void setDateRange(DateTimeRange range) {
    state = state.copyWith(dateRange: range);
  }

  void reset() => state = const OrderFilter();
}
```

### 3. Provider — derived/computed values (no mutations)

Use for: computed data, dependency injection.

```dart
@riverpod
int cartItemCount(CartItemCountRef ref) {
  final cart = ref.watch(cartNotifierProvider).valueOrNull;
  return cart?.items.length ?? 0;
}

@riverpod
bool isCartEmpty(IsCartEmptyRef ref) {
  return ref.watch(cartItemCountProvider) == 0;
}
```

### 4. StreamProvider — real-time streams (Firestore, websockets)

```dart
@riverpod
Stream<List<Message>> chatMessages(ChatMessagesRef ref, String chatId) {
  return ref.read(chatRepositoryProvider).watchMessages(chatId);
}
```

### 5. FutureProvider — one-shot async reads (no mutations needed)

```dart
@riverpod
Future<UserProfile> userProfile(UserProfileRef ref, String userId) {
  return ref.read(userRepositoryProvider).getProfile(userId);
}
```

---

## Consuming Providers in Widgets

### ConsumerWidget (recommended for most screens/widgets)

```dart
class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersNotifierProvider);

    return Scaffold(
      body: ordersAsync.when(
        data: (orders) => OrderList(orders: orders),
        loading: () => const LoadingWidget(),
        error: (e, _) => ErrorDisplay(
          message: e.toString(),
          onRetry: () => ref.invalidate(ordersNotifierProvider),
        ),
      ),
    );
  }
}
```

### ConsumerStatefulWidget — when local lifecycle is needed

```dart
class AnimatedOrderCard extends ConsumerStatefulWidget {
  const AnimatedOrderCard({super.key, required this.orderId});
  final String orderId;

  @override
  ConsumerState<AnimatedOrderCard> createState() => _AnimatedOrderCardState();
}

class _AnimatedOrderCardState extends ConsumerState<AnimatedOrderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 300.ms);
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(orderByIdProvider(widget.orderId));
    // ...
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Consumer — fine-grained rebuilds inside a larger widget

```dart
class CheckoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const CheckoutForm(),   // no rebuild on cart change
        Consumer(               // only this rebuilds when cart changes
          builder: (context, ref, _) {
            final count = ref.watch(cartItemCountProvider);
            return CartBadge(count: count);
          },
        ),
      ],
    );
  }
}
```

---

## Provider Families (parametrized)

```dart
// Define
@riverpod
Future<Order> orderById(OrderByIdRef ref, String orderId) {
  return ref.read(orderRepositoryProvider).getOrderById(orderId);
}

// Use
final order = ref.watch(orderByIdProvider('order-123'));
```

---

## Provider Lifecycle & Invalidation

```dart
// Manual invalidation (triggers rebuild/refetch)
ref.invalidate(ordersNotifierProvider);

// Invalidate family
ref.invalidate(orderByIdProvider('order-123'));

// Invalidate all family instances
ref.invalidate(orderByIdProvider);

// Self-invalidate inside notifier
ref.invalidateSelf();

// Keep alive (don't dispose when unwatched)
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier { ... }

// Auto-dispose (default) — disposes when all watchers leave
@riverpod  // auto-dispose by default
class SessionNotifier extends _$SessionNotifier { ... }
```

---

## Cross-Provider Dependencies

```dart
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  FutureOr<Cart> build() async {
    // Watch auth — re-builds when user changes
    final user = await ref.watch(authNotifierProvider.future);
    return ref.read(cartRepositoryProvider).getCart(user.id);
  }
}
```

---

## ProviderObserver — Logging & Debugging

```dart
class AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger.d('[Provider] ${provider.name}: $previousValue → $newValue');
  }

  @override
  void providerDidFail(ProviderBase provider, Object error, StackTrace stackTrace, ProviderContainer container) {
    logger.e('[Provider] ${provider.name} failed', error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }
}

// main.dart
runApp(
  ProviderScope(
    observers: [AppProviderObserver()],
    child: const MyApp(),
  ),
);
```

---

## Common Patterns

### Loading button with in-progress state

```dart
class PlaceOrderButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      ordersNotifierProvider.select((s) => s.isLoading),
    );
    return ElevatedButton(
      onPressed: isLoading ? null : () => ref.read(ordersNotifierProvider.notifier).placeOrder(request),
      child: isLoading ? const CircularProgressIndicator.adaptive() : const Text('Place Order'),
    );
  }
}
```

### Listen for side effects (navigation, snackbar)

```dart
class OrderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(ordersNotifierProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
      if (previous?.isLoading == true && next.hasValue) {
        context.go('/order-success');
      }
    });
    // ...
  }
}
```

### select — prevent unnecessary rebuilds

```dart
// Only rebuilds when user.name changes, not on other user field changes
final userName = ref.watch(userNotifierProvider.select((s) => s.valueOrNull?.name));
```

---

## Testing Providers

```dart
void main() {
  test('ordersNotifier loads orders', () async {
    final mockRepo = MockOrderRepository();
    when(() => mockRepo.getOrders()).thenAnswer((_) async => [fakeOrder]);

    final container = ProviderContainer(
      overrides: [
        orderRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
    addTearDown(container.dispose);

    final result = await container.read(ordersNotifierProvider.future);
    expect(result, [fakeOrder]);
  });
}
```
