# Data Layer — Repositories, Models, Dio, Retrofit

## Freezed Models

All data models use `freezed` + `json_serializable`. Never write `fromJson`/`toJson` manually.

```yaml
dependencies:
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  build_runner: ^2.4.9
```

### Model definition

```dart
// lib/features/orders/data/models/order_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required List<OrderItemModel> items,
    required double total,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'status') @Default('pending') String status,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
```

### Domain entity (pure Dart, no JSON)

```dart
// lib/features/orders/domain/entities/order.dart
@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String userId,
    required List<OrderItem> items,
    required double total,
    required DateTime createdAt,
    required OrderStatus status,
  }) = _Order;
}

enum OrderStatus { pending, processing, shipped, delivered, cancelled }
```

### Model ↔ Entity mapping

```dart
// In OrderModel
extension OrderModelX on OrderModel {
  Order toDomain() => Order(
    id: id,
    userId: userId,
    items: items.map((i) => i.toDomain()).toList(),
    total: total,
    createdAt: createdAt,
    status: OrderStatus.values.byName(status),
  );
}

extension OrderX on Order {
  OrderModel toModel() => OrderModel(
    id: id,
    userId: userId,
    items: items.map((i) => i.toModel()).toList(),
    total: total,
    createdAt: createdAt,
    status: status.name,
  );
}
```

Run generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
# or watch mode during dev
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Dio Client

```dart
// lib/core/network/dio_client.dart
@riverpod
Dio dioClient(DioClientRef ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.addAll([
    ref.read(authInterceptorProvider),
    ref.read(errorInterceptorProvider),
    if (kDebugMode) LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => logger.d(o),
    ),
  ]);

  return dio;
}
```

### Auth interceptor (token injection + refresh)

```dart
// lib/core/network/auth_interceptor.dart
@riverpod
AuthInterceptor authInterceptor(AuthInterceptorRef ref) =>
    AuthInterceptor(ref.read(secureStorageProvider));

class AuthInterceptor extends Interceptor {
  final SecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshed = await _refreshToken();
        if (refreshed) {
          final token = await _storage.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $token';
          final response = await Dio().fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (_) {}
      // Refresh failed → logout
      await _storage.clearAll();
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async { /* ... */ }
}
```

### Error interceptor (maps Dio errors to domain exceptions)

```dart
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: AppException.fromDio(err),
        type: err.type,
        response: err.response,
      ),
    );
  }
}
```

---

## Retrofit API Client

```dart
// lib/features/orders/data/sources/order_remote_source.dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'order_remote_source.g.dart';

@RestApi()
abstract class OrderRemoteSource {
  factory OrderRemoteSource(Dio dio, {String baseUrl}) = _OrderRemoteSource;

  @GET('/orders')
  Future<List<OrderModel>> getOrders({
    @Query('status') String? status,
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('/orders/{id}')
  Future<OrderModel> getOrderById(@Path('id') String id);

  @POST('/orders')
  Future<OrderModel> createOrder(@Body() OrderRequestModel body);

  @PATCH('/orders/{id}')
  Future<OrderModel> updateOrder(
    @Path('id') String id,
    @Body() Map<String, dynamic> updates,
  );

  @DELETE('/orders/{id}')
  Future<void> deleteOrder(@Path('id') String id);
}

@riverpod
OrderRemoteSource orderRemoteSource(OrderRemoteSourceRef ref) =>
    OrderRemoteSource(ref.read(dioClientProvider));
```

---

## Local Storage with Isar

```dart
// lib/features/orders/data/models/order_isar_model.dart
import 'package:isar/isar.dart';

part 'order_isar_model.g.dart';

@collection
class OrderIsarModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  late String userId;
  late double total;
  late DateTime createdAt;
  late String status;

  // Convert from domain
  static OrderIsarModel fromDomain(Order order) => OrderIsarModel()
    ..id = order.id
    ..userId = order.userId
    ..total = order.total
    ..createdAt = order.createdAt
    ..status = order.status.name;

  // Convert to domain
  Order toDomain() => Order(
    id: id,
    userId: userId,
    total: total,
    createdAt: createdAt,
    status: OrderStatus.values.byName(status),
    items: [],  // load separately if needed
  );
}

// Isar initialization
@riverpod
Future<Isar> isar(IsarRef ref) async {
  return await Isar.open([OrderIsarModelSchema, /* other schemas */]);
}

// Local source
class OrderLocalSource {
  final Isar _isar;
  const OrderLocalSource(this._isar);

  Future<void> cacheOrders(List<Order> orders) async {
    final models = orders.map(OrderIsarModel.fromDomain).toList();
    await _isar.writeTxn(() => _isar.orderIsarModels.putAllByIndex('id', models));
  }

  Future<List<Order>> getOrders() async {
    final models = await _isar.orderIsarModels
        .where()
        .sortByCreatedAtDesc()
        .findAll();
    return models.map((m) => m.toDomain()).toList();
  }

  Future<void> clearOrders() async {
    await _isar.writeTxn(() => _isar.orderIsarModels.clear());
  }

  Stream<List<Order>> watchOrders() {
    return _isar.orderIsarModels
        .where()
        .watch(fireImmediately: true)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }
}
```

---

## Secure Storage (tokens, sensitive data)

```dart
// lib/core/storage/secure_storage.dart
@riverpod
SecureStorage secureStorage(SecureStorageRef ref) =>
    SecureStorage(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ));

class SecureStorage {
  final FlutterSecureStorage _storage;
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  const SecureStorage(this._storage);

  Future<void> saveTokens({required String access, required String refresh}) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: access),
      _storage.write(key: _refreshTokenKey, value: refresh),
    ]);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> clearAll() => _storage.deleteAll();
}
```

---

## Repository Implementation Pattern

```dart
// lib/features/orders/data/order_repository_impl.dart
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteSource _remote;
  final OrderLocalSource _local;

  const OrderRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Order>> getOrders() async {
    try {
      final models = await _remote.getOrders();
      final orders = models.map((m) => m.toDomain()).toList();
      await _local.cacheOrders(orders);
      return orders;
    } on DioException catch (e) {
      // Network failure — try cache
      final cached = await _local.getOrders();
      if (cached.isNotEmpty) return cached;
      throw AppException.fromDio(e);
    } catch (e, st) {
      Error.throwWithStackTrace(AppException.unknown(e), st);
    }
  }

  @override
  Future<Order> placeOrder(OrderRequest request) async {
    try {
      final model = await _remote.createOrder(request.toModel());
      return model.toDomain();
    } on DioException catch (e) {
      throw AppException.fromDio(e);
    }
  }
}

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) => OrderRepositoryImpl(
  ref.read(orderRemoteSourceProvider),
  ref.read(orderLocalSourceProvider),
);
```

---

## Firestore (alternative to REST)

```dart
// lib/features/orders/data/sources/order_firestore_source.dart
class OrderFirestoreSource {
  final FirebaseFirestore _firestore;

  const OrderFirestoreSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('orders');

  Future<List<OrderModel>> getOrders(String userId) async {
    final snapshot = await _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => OrderModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Stream<List<OrderModel>> watchOrders(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => OrderModel.fromJson({...doc.data(), 'id': doc.id}))
            .toList());
  }

  Future<OrderModel> createOrder(OrderModel model) async {
    final doc = await _collection.add(model.toJson());
    return model.copyWith(id: doc.id);
  }
}
```

---

## Pagination

```dart
@freezed
class PaginatedResult<T> with _$PaginatedResult<T> {
  const factory PaginatedResult({
    required List<T> items,
    required bool hasMore,
    String? nextCursor,
  }) = _PaginatedResult;
}

@riverpod
class OrdersPaginatedNotifier extends _$OrdersPaginatedNotifier {
  static const _pageSize = 20;

  @override
  FutureOr<PaginatedResult<Order>> build() async {
    return _fetchPage(cursor: null);
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore) return;

    final more = await _fetchPage(cursor: current.nextCursor);
    state = AsyncValue.data(
      more.copyWith(items: [...current.items, ...more.items]),
    );
  }

  Future<PaginatedResult<Order>> _fetchPage({String? cursor}) async {
    return ref.read(orderRepositoryProvider).getOrdersPaginated(
      limit: _pageSize,
      cursor: cursor,
    );
  }
}
```
