# Flutter Dev Guidelines

Production-ready Flutter patterns for building scalable, maintainable mobile apps.
Load resource files progressively when deep-diving into specific topics.

---

## Seven Foundational Rules

1. **Widgets are dumb** — no business logic in `build()`, no direct API calls, no repos
2. **State lives in providers** — Riverpod providers own all state; widgets observe
3. **All async has error handling** — every `AsyncValue` shows an error state, never silent failures
4. **Repository pattern for all data** — widgets never touch Dio/Firestore/Hive directly
5. **Routes are centrally defined** — no `Navigator.push` scattered in widgets; all routes in `router.dart`
6. **const everywhere** — use `const` constructors aggressively; Flutter rebuilds only what changes
7. **Theming over hardcoding** — colors, text styles, spacing always from `Theme.of(context)`

---

## Project Structure

```
lib/
  main.dart                    # App entry — initializes providers, Firebase, env
  app/
    app.dart                   # MaterialApp.router — theme, locale, router
    router.dart                # GoRouter config — all routes defined here
  features/
    [feature]/
      data/
        [feature]_repository.dart      # Abstract interface + implementation
        [feature]_remote_source.dart   # Dio/Retrofit API calls
        [feature]_local_source.dart    # Hive/Isar local storage
        models/
          [feature]_model.dart         # fromJson/toJson (freezed)
      domain/
        entities/
          [feature]_entity.dart        # Pure Dart classes (freezed)
        use_cases/                     # Optional: complex business logic
      presentation/
        providers/
          [feature]_provider.dart      # Riverpod providers
        screens/
          [feature]_screen.dart
        widgets/
          [feature]_widget.dart        # Feature-specific widgets
  core/
    theme/
      app_theme.dart            # ThemeData light + dark
      app_colors.dart           # Color constants
      app_text_styles.dart      # TextStyle constants
    network/
      dio_client.dart           # Dio singleton with interceptors
      api_endpoints.dart        # All API paths as constants
    storage/
      hive_storage.dart         # Local key-value storage
    error/
      app_exception.dart        # Domain exception types
      failure.dart              # Failure sealed class
    utils/
      extensions.dart           # Dart extensions (String, DateTime, etc.)
      validators.dart           # Form validators
    widgets/
      loading_widget.dart       # Shared loading indicator
      error_widget.dart         # Shared error display
      empty_state_widget.dart
  config/
    env.dart                    # Env vars via envied
    app_config.dart             # Build-time config
```

---

## Modern Package Stack (2025)

| Category | Package | Why |
|----------|---------|-----|
| State management | `flutter_riverpod` + `riverpod_annotation` | Best-in-class, compile-safe |
| Code generation | `freezed` + `json_serializable` + `build_runner` | Immutable models, union types |
| Navigation | `go_router` | Declarative, deep links, web-ready |
| HTTP | `dio` + `retrofit` | Interceptors, generated API clients |
| Local storage | `isar` | Fast NoSQL, typed, no ORM mapping |
| Simple KV storage | `flutter_secure_storage` | Encrypted key-value |
| Firebase | `firebase_core` + `cloud_firestore` + `firebase_auth` | Auth + realtime DB |
| Crash reporting | `firebase_crashlytics` | Prod error tracking |
| Env/config | `envied` | Compile-time obfuscated env vars |
| Logging | `logger` | Structured logs with levels |
| Images | `cached_network_image` | Cache + placeholder |
| Responsive | `flutter_screenutil` | Adaptive sizing |
| Animations | `flutter_animate` | Declarative animations |
| Forms | `reactive_forms` | Reactive form control |
| Linting | `very_good_analysis` | Strict lint rules |
| Testing mocks | `mocktail` | Null-safe mocking |

Full setup details → `resources/modern-packages.md`

---

## Riverpod State Pattern (Quick Reference)

```dart
// 1. Define provider with annotation (code-gen)
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<User> build() => ref.read(userRepositoryProvider).getUser();

  Future<void> updateName(String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(userRepositoryProvider).updateName(name),
    );
  }
}

// 2. Consume in widget
class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    return userAsync.when(
      data: (user) => UserView(user: user),
      loading: () => const LoadingWidget(),
      error: (e, _) => ErrorDisplay(message: e.toString()),
    );
  }
}
```

Full patterns → `resources/state-management.md`

---

## Repository Pattern (Quick Reference)

```dart
// Abstract interface
abstract class UserRepository {
  Future<User> getUser();
  Future<void> updateUser(User user);
}

// Implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteSource _remote;
  final UserLocalSource _local;

  UserRepositoryImpl(this._remote, this._local);

  @override
  Future<User> getUser() async {
    try {
      final user = await _remote.fetchUser();
      await _local.cacheUser(user);
      return user;
    } catch (e) {
      final cached = await _local.getUser();
      if (cached != null) return cached;
      throw AppException.fromError(e);
    }
  }
}

// Riverpod provider (with Riverpod DI)
@riverpod
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(
      ref.read(userRemoteSourceProvider),
      ref.read(userLocalSourceProvider),
    );
```

Full patterns → `resources/data-layer.md`

---

## GoRouter Navigation (Quick Reference)

```dart
// router.dart — all routes in one place
final router = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) => authGuard(context, state),
  routes: [
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    GoRoute(
      path: '/user/:id',
      builder: (_, state) => UserScreen(id: state.pathParameters['id']!),
    ),
    ShellRoute(
      builder: (_, __, child) => MainShell(child: child),
      routes: [ /* tab routes */ ],
    ),
  ],
);

// Navigate — never Navigator.push in widgets
context.go('/home');
context.push('/user/${user.id}');
context.pop();
```

Full patterns → `resources/navigation.md`

---

## Error Handling Pattern

```dart
// Domain exception
sealed class AppException implements Exception {
  const AppException();
  factory AppException.network(String message) = NetworkException;
  factory AppException.notFound() = NotFoundException;
  factory AppException.unauthorized() = UnauthorizedException;
  factory AppException.unknown(Object error) = UnknownException;

  static AppException fromError(Object e) {
    if (e is DioException) return _fromDio(e);
    return AppException.unknown(e);
  }
}

// Always handle all states in UI
userAsync.when(
  data: (data) => DataWidget(data),
  loading: () => const LoadingWidget(),
  error: (error, _) => ErrorWidget(
    message: error is AppException ? error.message : 'Something went wrong',
    onRetry: () => ref.invalidate(userNotifierProvider),
  ),
);
```

Full patterns → `resources/async-and-errors.md`

---

## Widget Rules Checklist

Before writing any widget:
- [ ] Is this `StatelessWidget` or `ConsumerWidget`? (prefer both over Stateful)
- [ ] Does it have a `const` constructor?
- [ ] Is all business logic outside of `build()`?
- [ ] Are colors/styles from `Theme.of(context)`?
- [ ] Is the widget under ~100 lines? If not, extract sub-widgets
- [ ] Are lists using `ListView.builder` / `SliverList`?
- [ ] Are images using `CachedNetworkImage`?

Widget patterns → `resources/widget-patterns.md`

---

## Anti-Patterns — Never Do These

| Anti-Pattern | Correct Approach |
|-------------|-----------------|
| `setState` in deeply nested widgets | Riverpod provider |
| Business logic in `build()` | Extract to notifier/use case |
| `Navigator.push(context, MaterialPageRoute(...))` | `context.go()` via GoRouter |
| Hardcoded colors: `Color(0xFF123456)` | `AppColors.primary` or `Theme.of(context).colorScheme` |
| `http` package directly in widget | Dio via repository |
| `SharedPreferences` directly in widget | `HiveStorage` or `FlutterSecureStorage` via provider |
| `print()` for logging | `logger.d()` / `logger.e()` |
| `.env` file in assets | `envied` compile-time obfuscation |
| Models with manual `fromJson` | `freezed` + `json_serializable` |

---

## Resources Index

| Topic | File | When to Load |
|-------|------|-------------|
| Architecture overview | `resources/architecture-overview.md` | Starting a new feature or screen |
| State management | `resources/state-management.md` | Writing providers, notifiers, consumers |
| Widget patterns | `resources/widget-patterns.md` | Building UI components |
| Navigation | `resources/navigation.md` | Routing, deep links, auth guards |
| Data layer | `resources/data-layer.md` | Repositories, Dio/Retrofit, models |
| Async & errors | `resources/async-and-errors.md` | Error handling, loading states |
| Theming | `resources/theming.md` | Colors, typography, dark mode |
| Modern packages | `resources/modern-packages.md` | Adding new dependencies |
| Testing | `resources/testing.md` | Unit, widget, integration tests |
| Performance | `resources/performance.md` | Optimization, profiling |
