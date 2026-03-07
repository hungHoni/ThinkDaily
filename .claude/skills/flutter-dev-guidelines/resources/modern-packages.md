# Modern Packages — 2025 Flutter Stack

## Complete pubspec.yaml Reference

```yaml
name: think_daily
description: ThinkDaily Flutter App
version: 1.0.0+1
publish_to: none

environment:
  sdk: '>=3.4.0 <4.0.0'
  flutter: '>=3.22.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  hooks_riverpod: ^2.5.1       # optional: if using flutter_hooks

  # Navigation
  go_router: ^14.2.7

  # Code Generation / Models
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

  # HTTP / API
  dio: ^5.4.3
  retrofit: ^4.1.0

  # Local Storage
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1  # contains Isar native libs
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.3.2   # for simple non-sensitive KV

  # Firebase (use only what you need)
  firebase_core: ^3.4.0
  firebase_auth: ^5.2.1
  cloud_firestore: ^5.4.0
  firebase_storage: ^12.2.1
  firebase_messaging: ^15.1.3
  firebase_crashlytics: ^4.1.2
  firebase_analytics: ^11.3.2

  # Environment / Config
  envied: ^0.5.4+1

  # Logging / Monitoring
  logger: ^2.4.0

  # Images
  cached_network_image: ^3.3.1
  flutter_svg: ^2.0.10+1

  # Responsive / Adaptive UI
  flutter_screenutil: ^5.9.3

  # Animations
  flutter_animate: ^4.5.0
  lottie: ^3.1.2

  # Forms
  reactive_forms: ^17.0.1

  # Utils
  intl: ^0.19.0
  url_launcher: ^6.3.1
  share_plus: ^10.0.2
  image_picker: ^1.1.2
  permission_handler: ^11.3.1
  connectivity_plus: ^6.0.5
  package_info_plus: ^8.1.0
  path_provider: ^2.1.4
  uuid: ^4.5.0

  # Date
  jiffy: ^6.3.1    # friendly date formatting

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter

  # Code Generation
  build_runner: ^2.4.9
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  riverpod_generator: ^2.4.3
  retrofit_generator: ^8.1.0
  isar_generator: ^3.1.0+1
  envied_generator: ^0.5.4+1

  # Mocking / Testing
  mocktail: ^1.0.4
  fake_async: ^1.3.1

  # Linting
  very_good_analysis: ^6.0.0
  custom_lint: ^0.6.7
  riverpod_lint: ^2.3.10

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

---

## Package Decisions — Why Each One

### State: flutter_riverpod + riverpod_annotation
**Why:** Compile-time safe, auto-generated providers, excellent DevTools support, no boilerplate. Preferred over BLoC for most apps.
**Alternative:** BLoC if team is already experienced with it.

### Navigation: go_router
**Why:** Official Flutter team package, declarative, deep links, web support, nested navigation, shell routes. Replaces Navigator 1.0 entirely.
**Alternative:** None worth considering for new projects.

### Models: freezed + json_serializable
**Why:** Immutable value objects, `copyWith`, pattern matching, union types, zero-boilerplate JSON. `fromJson`/`toJson` are generated.
**Alternative:** `dart_mappable` if you want more advanced mapping.

### HTTP: dio + retrofit
**Why:** Dio has interceptors (auth, logging, retry), excellent error handling. Retrofit generates type-safe API clients.
**Alternative:** `http` for very simple needs; `chopper` as Retrofit alternative.

### Local DB: isar
**Why:** Fastest Flutter local database, native Dart objects, no SQL strings, async, reactive streams, supports web.
**Alternative:** `drift` (SQLite with type-safe queries), `hive` (simpler but less powerful).

### Secure Storage: flutter_secure_storage
**Why:** Uses Android Keystore / iOS Keychain. Required for tokens, secrets.
**Never use:** `shared_preferences` for sensitive data.

### Env: envied
**Why:** Compile-time obfuscation of `.env` values — strings are not visible in APK/IPA. Safer than `flutter_dotenv`.
**Setup:**
```dart
// lib/config/env.dart
import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_BASE_URL', obfuscate: true)
  static final String apiBaseUrl = _Env.apiBaseUrl;

  @EnviedField(varName: 'FIREBASE_API_KEY', obfuscate: true)
  static final String firebaseApiKey = _Env.firebaseApiKey;
}
```

### Logging: logger
**Why:** Structured logs with level filtering, pretty printing in debug. Zero overhead in release.
```dart
// lib/core/utils/logger.dart
final logger = Logger(
  printer: PrettyPrinter(methodCount: 2, colors: true, printEmojis: true),
  level: kDebugMode ? Level.debug : Level.warning,
);
```

### Animations: flutter_animate
**Why:** Declarative extension-based animations. Much less boilerplate than `AnimationController`.

### Responsive: flutter_screenutil
**Why:** Single design size → scales everything proportionally. Better than `MediaQuery` math everywhere.

### Forms: reactive_forms
**Why:** Reactive, composable, validator chains, async validators. More powerful than `Form` + `TextEditingController`.

### Linting: very_good_analysis
**Why:** Strict ruleset from VGV. Catches real bugs, enforces consistency.
```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml
linter:
  rules:
    public_member_api_docs: false   # disable for app (not package)
```

---

## Build Runner Commands

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (during development)
flutter pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter pub run build_runner clean
```

What gets generated:
- `*.freezed.dart` — immutable models, unions
- `*.g.dart` — JSON serialization, Riverpod providers, Retrofit clients, Isar schemas, Env

---

## Firebase Setup Checklist

```bash
# 1. Install FlutterFire CLI
dart pub global activate flutterfire_cli

# 2. Configure Firebase project
flutterfire configure

# 3. Initialize in main.dart
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

```dart
// main.dart — full initialization
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
```

---

## Checking Package Health Before Adding

Before adding any package, verify on [pub.dev](https://pub.dev):
1. **Pub points** — should be ≥ 120/160
2. **Popularity** — should be ≥ 80%
3. **Maintenance** — recent commit within 6 months
4. **Null safety** — must be null-safe
5. **Platform support** — check iOS + Android both listed
