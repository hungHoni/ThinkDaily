# Async & Errors

## AppException — Sealed Domain Exceptions

Never let raw `DioException`, `FirebaseException`, or `PlatformException` reach the UI.
Map all external errors to `AppException` at the repository boundary.

```dart
// lib/core/error/app_exception.dart
sealed class AppException implements Exception {
  const AppException();

  String get userMessage;

  factory AppException.network(String message) = NetworkException;
  factory AppException.unauthorized() = UnauthorizedException;
  factory AppException.forbidden() = ForbiddenException;
  factory AppException.notFound(String resource) = NotFoundException;
  factory AppException.validation(Map<String, List<String>> errors) = ValidationException;
  factory AppException.server(int statusCode, String message) = ServerException;
  factory AppException.timeout() = TimeoutException;
  factory AppException.noInternet() = NoInternetException;
  factory AppException.unknown(Object error) = UnknownException;

  static AppException fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException.timeout();
      case DioExceptionType.connectionError:
        return const AppException.noInternet();
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode ?? 0;
        return switch (status) {
          401 => const AppException.unauthorized(),
          403 => const AppException.forbidden(),
          404 => AppException.notFound(e.requestOptions.path),
          422 => AppException.validation(
              _parseValidationErrors(e.response?.data),
            ),
          >= 500 => AppException.server(status, e.message ?? 'Server error'),
          _ => AppException.unknown(e),
        };
      default:
        return AppException.unknown(e);
    }
  }

  static AppException fromFirebase(FirebaseException e) {
    return switch (e.code) {
      'permission-denied' => const AppException.forbidden(),
      'not-found' => AppException.notFound(e.message ?? 'Resource'),
      'unauthenticated' => const AppException.unauthorized(),
      'unavailable' => const AppException.noInternet(),
      _ => AppException.server(0, e.message ?? e.code),
    };
  }

  static Map<String, List<String>> _parseValidationErrors(dynamic data) {
    if (data is Map && data['errors'] is Map) {
      return (data['errors'] as Map).map(
        (k, v) => MapEntry(k.toString(), List<String>.from(v as List)),
      );
    }
    return {};
  }
}

class NetworkException extends AppException {
  const NetworkException(this.message);
  final String message;
  @override
  String get userMessage => message;
}

class UnauthorizedException extends AppException {
  const UnauthorizedException();
  @override
  String get userMessage => 'Session expired. Please sign in again.';
}

class ForbiddenException extends AppException {
  const ForbiddenException();
  @override
  String get userMessage => 'You don\'t have permission to do this.';
}

class NotFoundException extends AppException {
  const NotFoundException(this.resource);
  final String resource;
  @override
  String get userMessage => '$resource not found.';
}

class ValidationException extends AppException {
  const ValidationException(this.errors);
  final Map<String, List<String>> errors;
  @override
  String get userMessage => errors.values.expand((e) => e).first;
}

class ServerException extends AppException {
  const ServerException(this.statusCode, this.message);
  final int statusCode;
  final String message;
  @override
  String get userMessage => 'Server error ($statusCode). Please try again.';
}

class TimeoutException extends AppException {
  const TimeoutException();
  @override
  String get userMessage => 'Request timed out. Check your connection.';
}

class NoInternetException extends AppException {
  const NoInternetException();
  @override
  String get userMessage => 'No internet connection.';
}

class UnknownException extends AppException {
  const UnknownException(this.error);
  final Object error;
  @override
  String get userMessage => 'Something went wrong. Please try again.';
}
```

---

## AsyncValue Pattern

Every async provider response must handle all three states: `data`, `loading`, `error`.

```dart
// Full pattern with retry
ordersAsync.when(
  data: (orders) => orders.isEmpty
      ? const EmptyStateWidget(message: 'No orders yet')
      : OrderList(orders: orders),
  loading: () => const LoadingWidget(),
  error: (error, stackTrace) {
    // Log to Crashlytics in production
    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
    return ErrorDisplay(
      message: error is AppException ? error.userMessage : 'Something went wrong',
      onRetry: () => ref.invalidate(ordersNotifierProvider),
    );
  },
)

// whenOrNull — when you only care about data
final orders = ordersAsync.whenOrNull(data: (o) => o) ?? [];

// maybeWhen — default for unhandled states
ordersAsync.maybeWhen(
  data: (o) => Text('${o.length} orders'),
  orElse: () => const SizedBox.shrink(),
)

// valueOrNull — safe access without requiring loading/error handlers
final count = ref.watch(cartItemCountProvider).valueOrNull ?? 0;
```

---

## AsyncValue.guard — Safe mutation wrapper

Always use `AsyncValue.guard` inside notifier mutation methods:

```dart
Future<void> placeOrder(OrderRequest request) async {
  state = const AsyncValue.loading();
  state = await AsyncValue.guard(
    () => ref.read(orderRepositoryProvider).placeOrder(request),
  );
  // state is now AsyncValue.data(order) or AsyncValue.error(exception)
}

// If you need to do something after success:
Future<void> placeOrder(OrderRequest request) async {
  state = const AsyncValue.loading();
  final result = await AsyncValue.guard(
    () => ref.read(orderRepositoryProvider).placeOrder(request),
  );
  state = result;
  // Don't navigate here — use ref.listen in widget instead
}
```

---

## Error Display Widget

```dart
// lib/core/widgets/error_display.dart
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 12),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

---

## Showing Errors as Snackbars

Use `ref.listen` to react to errors with snackbars — never show snackbars inside `build()`:

```dart
class CheckoutScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for errors and successes
    ref.listen(checkoutNotifierProvider, (previous, next) {
      if (next.hasError && !(previous?.hasError ?? false)) {
        final message = next.error is AppException
            ? (next.error as AppException).userMessage
            : 'Something went wrong';
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      }

      if (previous?.isLoading == true && next.hasValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed!')),
        );
        context.go('/order-success');
      }
    });

    // build continues...
  }
}
```

---

## Crashlytics Integration

```dart
// lib/core/error/crash_reporter.dart
class CrashReporter {
  static Future<void> initialize() async {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void recordError(Object error, StackTrace? stackTrace, {bool fatal = false}) {
    if (kDebugMode) {
      logger.e('Error', error: error, stackTrace: stackTrace);
      return;
    }
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: fatal);
  }

  static void setUserIdentifier(String userId) {
    FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }
}

// Use in ProviderObserver
@override
void providerDidFail(ProviderBase provider, Object error, StackTrace stackTrace, ProviderContainer container) {
  CrashReporter.recordError(error, stackTrace);
}
```

---

## Connectivity Check

```dart
// Provide internet connectivity check before making requests
@riverpod
Stream<ConnectivityResult> connectivity(ConnectivityRef ref) {
  return Connectivity().onConnectivityChanged;
}

// In repository, check before network call
Future<List<Order>> getOrders() async {
  final result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.none) {
    final cached = await _local.getOrders();
    if (cached.isNotEmpty) return cached;
    throw const AppException.noInternet();
  }
  // proceed with network call
}
```

---

## Global Error Boundary

Wrap app in a zone to catch all uncaught async errors:

```dart
// main.dart
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await CrashReporter.initialize();
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) {
    CrashReporter.recordError(error, stackTrace, fatal: true);
  });
}
```
