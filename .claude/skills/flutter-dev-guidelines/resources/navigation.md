# Navigation — GoRouter Patterns

## Setup

```yaml
dependencies:
  go_router: ^14.2.7
```

---

## Router Configuration

```dart
// lib/app/router.dart
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: true,  // remove in production
  redirect: _authGuard,
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    // Auth routes (no shell)
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

    // Main app with bottom nav shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'details/:id',
                  builder: (_, state) => DetailsScreen(
                    id: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
          ],
        ),
      ],
    ),
  ],
);
```

---

## Auth Guard

```dart
// lib/app/router.dart
String? _authGuard(BuildContext context, GoRouterState state) {
  final isAuthenticated = ProviderScope.containerOf(context)
      .read(authNotifierProvider)
      .valueOrNull
      ?.isAuthenticated ?? false;

  final isOnAuthRoute = state.matchedLocation.startsWith('/login') ||
      state.matchedLocation.startsWith('/register');

  if (!isAuthenticated && !isOnAuthRoute) return '/login';
  if (isAuthenticated && isOnAuthRoute) return '/home';
  return null;
}
```

**Trigger redirect after auth state change:**
```dart
// In app.dart
final router = GoRouter(
  refreshListenable: GoRouterRefreshStream(
    ref.watch(authNotifierProvider.stream),
  ),
  redirect: _authGuard,
  // ...
);

// GoRouterRefreshStream utility
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
```

---

## Navigation Methods

```dart
// Replace current screen (no back button)
context.go('/home');

// Push on top (back button available)
context.push('/order/${order.id}');

// Push with result
final result = await context.push<bool>('/confirm');
if (result == true) { /* confirmed */ }

// Pop current screen
context.pop();

// Pop with result
context.pop(true);

// Replace top of stack
context.replace('/success');

// Navigate to named route
context.goNamed('orderDetail', pathParameters: {'id': orderId});

// Check if can pop
if (context.canPop()) context.pop();
```

**Never use `Navigator.push` directly.** Always use `context.go()` or `context.push()`.

---

## Passing Data Between Routes

### Path parameters (preferred for IDs)

```dart
GoRoute(
  path: '/order/:id',
  builder: (_, state) => OrderScreen(orderId: state.pathParameters['id']!),
)

// Navigate
context.push('/order/${order.id}');
```

### Query parameters (for filters/optional data)

```dart
GoRoute(
  path: '/search',
  builder: (_, state) => SearchScreen(
    query: state.uri.queryParameters['q'] ?? '',
  ),
)

// Navigate
context.push('/search?q=flutter');
// or
context.go(Uri(path: '/search', queryParameters: {'q': query}).toString());
```

### Extra (for complex objects, lost on browser refresh)

```dart
GoRoute(
  path: '/preview',
  builder: (_, state) => PreviewScreen(data: state.extra as PreviewData),
)

// Navigate
context.push('/preview', extra: previewData);
```

---

## Bottom Navigation Shell

```dart
// main_shell.dart
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
```

---

## Transitions

```dart
// Slide transition
GoRoute(
  path: '/detail/:id',
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: DetailScreen(id: state.pathParameters['id']!),
    transitionsBuilder: (context, animation, _, child) =>
        SlideTransition(
          position: Tween(begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
  ),
)

// Fade transition
pageBuilder: (context, state) => CustomTransitionPage(
  key: state.pageKey,
  child: MyScreen(),
  transitionsBuilder: (_, animation, __, child) =>
      FadeTransition(opacity: animation, child: child),
)
```

---

## Deep Links

```yaml
# android/app/src/main/AndroidManifest.xml
<intent-filter android:autoVerify="true">
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="https" android:host="yourdomain.com" />
</intent-filter>
```

```dart
// GoRouter handles path matching automatically
// https://yourdomain.com/order/123 → matches /order/:id route
```

---

## Route Constants

Define all route paths as constants to avoid typos:

```dart
// lib/app/routes.dart
abstract class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const profile = '/profile';
  static const settings = '/settings';
  static const orderDetail = '/home/details/:id';

  static String orderDetailPath(String id) => '/home/details/$id';
}

// Usage
context.go(AppRoutes.home);
context.push(AppRoutes.orderDetailPath(order.id));
```

---

## Testing Navigation

```dart
testWidgets('navigates to detail on tap', (tester) async {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/detail/:id', builder: (_, s) => DetailScreen(id: s.pathParameters['id']!)),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      child: MaterialApp.router(routerConfig: router),
    ),
  );

  await tester.tap(find.byKey(const Key('item-card-1')));
  await tester.pumpAndSettle();

  expect(find.byType(DetailScreen), findsOneWidget);
});
```
