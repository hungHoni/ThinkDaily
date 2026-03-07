# Architecture Overview — Flutter Feature Architecture

## Core Principle

Every feature is a self-contained vertical slice. Nothing reaches across feature boundaries directly — shared contracts go through `core/` or through Riverpod providers.

```
Feature request → Presentation → Provider → Repository → Data Source → External
                                                        ↘ Local Source → Cache
```

---

## Layer Responsibilities

### Presentation Layer (`features/[feature]/presentation/`)

**What it does:** Displays data, captures user input, triggers state changes.

**What it must NOT do:**
- Call Dio, Firestore, or any network/storage API directly
- Contain `if/else` business rules (e.g., "if user is premium, show X")
- Hold state that outlives the widget (use providers)

```dart
// CORRECT — widget observes, delegates
class OrderScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersNotifierProvider);
    return ordersAsync.when(
      data: (orders) => OrderList(orders: orders),
      loading: () => const LoadingWidget(),
      error: (e, _) => ErrorDisplay(error: e, onRetry: () => ref.invalidate(ordersNotifierProvider)),
    );
  }
}

// WRONG — widget calls API directly
class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    Dio().get('/orders').then((r) => setState(() => orders = r.data)); // ❌
  }
}
```

---

### Provider Layer (`features/[feature]/presentation/providers/`)

**What it does:** Owns all state for a feature. Bridges presentation and data layers.

**Responsibilities:**
- Fetch data from repositories
- Handle loading/error/data states via `AsyncValue`
- Coordinate multi-step operations
- Cache/invalidate data

```dart
@riverpod
class OrdersNotifier extends _$OrdersNotifier {
  @override
  FutureOr<List<Order>> build() {
    // Auto-fetches on first watch
    return ref.read(orderRepositoryProvider).getOrders();
  }

  Future<void> placeOrder(OrderRequest request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(orderRepositoryProvider).placeOrder(request),
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future; // wait for rebuild
  }
}
```

---

### Repository Layer (`features/[feature]/data/`)

**What it does:** Abstracts data sources. Decides whether to fetch from network or cache.

**Interface (in feature/data/):**
```dart
abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> getOrderById(String id);
  Future<Order> placeOrder(OrderRequest request);
  Future<void> cancelOrder(String id);
}
```

**Implementation:**
```dart
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteSource _remote;
  final OrderLocalSource _local;

  const OrderRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Order>> getOrders() async {
    try {
      final orders = await _remote.fetchOrders();
      await _local.cacheOrders(orders);
      return orders;
    } on AppException {
      rethrow;
    } catch (e, st) {
      // Try cache fallback
      final cached = await _local.getOrders();
      if (cached.isNotEmpty) return cached;
      Error.throwWithStackTrace(AppException.fromError(e), st);
    }
  }
}
```

**Provider registration:**
```dart
@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) => OrderRepositoryImpl(
  ref.read(orderRemoteSourceProvider),
  ref.read(orderLocalSourceProvider),
);
```

---

### Data Source Layer

**Remote source** — all Dio/Retrofit calls:
```dart
@RestApi()
abstract class OrderRemoteSource {
  factory OrderRemoteSource(Dio dio) = _OrderRemoteSource;

  @GET('/orders')
  Future<List<OrderModel>> fetchOrders();

  @POST('/orders')
  Future<OrderModel> createOrder(@Body() OrderRequestModel body);
}

@riverpod
OrderRemoteSource orderRemoteSource(OrderRemoteSourceRef ref) =>
    OrderRemoteSource(ref.read(dioClientProvider));
```

**Local source** — Isar/Hive storage:
```dart
class OrderLocalSource {
  final Isar _isar;

  const OrderLocalSource(this._isar);

  Future<void> cacheOrders(List<Order> orders) async {
    final models = orders.map(OrderIsarModel.fromDomain).toList();
    await _isar.writeTxn(() => _isar.orderIsarModels.putAll(models));
  }

  Future<List<Order>> getOrders() async {
    final models = await _isar.orderIsarModels.where().findAll();
    return models.map((m) => m.toDomain()).toList();
  }
}
```

---

## Core Layer (`core/`)

Shared infrastructure. No feature code here.

```
core/
  network/
    dio_client.dart          # Singleton Dio with interceptors
    api_endpoints.dart       # All paths as constants
    auth_interceptor.dart    # Injects auth token
    error_interceptor.dart   # Maps DioException → AppException
  storage/
    secure_storage.dart      # flutter_secure_storage wrapper
    hive_storage.dart        # Simple KV for non-sensitive data
  error/
    app_exception.dart       # Sealed exception class
  theme/
    app_theme.dart
    app_colors.dart
    app_text_styles.dart
  widgets/                   # LoadingWidget, ErrorDisplay, EmptyState
  utils/
    extensions.dart
    validators.dart
```

---

## Feature Communication

Features never import each other's internals. Cross-feature needs:

**Option 1 — Shared provider in `core/`:**
```dart
// core/providers/auth_provider.dart
@riverpod
AuthState auth(AuthRef ref) => ...

// feature A and B both read:
final auth = ref.watch(authProvider);
```

**Option 2 — Shared entity in `core/`:**
```dart
// core/entities/user.dart
@freezed
class User with _$User {
  const factory User({required String id, required String name}) = _User;
}
```

**Option 3 — Navigation only (GoRouter):**
```dart
// Feature A triggers navigation to Feature B by route
context.push('/checkout/${cart.id}');
// Feature B has no import of Feature A
```

---

## Feature Directory Template

Run this when starting any new feature:

```bash
FEATURE=payment
mkdir -p lib/features/$FEATURE/{data/{models,sources},domain/{entities,use_cases},presentation/{providers,screens,widgets}}
```

Files to create immediately:
1. `data/[feature]_repository.dart` — abstract interface
2. `data/[feature]_repository_impl.dart` — implementation
3. `presentation/providers/[feature]_provider.dart` — Riverpod notifier
4. `presentation/screens/[feature]_screen.dart` — main screen

---

## Reference: Good vs. Bad Architecture Decisions

| Decision | Good | Bad |
|----------|------|-----|
| Where does "is user admin?" live? | Provider/repository | `if` in widget |
| Where does cache logic live? | Repository impl | Provider |
| Where does API endpoint live? | `api_endpoints.dart` constant | String literal in Dio call |
| Where does token refresh happen? | Dio interceptor | Repository method |
| Where does form validation live? | `validators.dart` + `reactive_forms` | `build()` method |
| Where does navigation after login happen? | Router redirect guard | `initState` |
