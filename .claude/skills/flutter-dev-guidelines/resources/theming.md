# Theming — Colors, Typography, Dark Mode

> **ThinkDaily note:** This file contains generic Flutter theming patterns.
> ThinkDaily's actual design system (Lora + JetBrains Mono, monochromatic palette)
> is documented in the `thinkdaily-ui` skill — always check that first for this project.

---

## Setup in app.dart

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'App Title',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
```

---

## Color System Pattern

Define all colors in a single `app_colors.dart` file — never inline `Color(0xFF...)` in widgets.
Group by semantic role, not by shade:

```dart
// lib/core/theme/app_colors.dart
abstract class AppColors {
  // Brand / primary
  static const primary = Color(0xFF...);
  static const primaryLight = Color(0xFF...);

  // Semantic
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);
  static const error = Color(0xFFDC2626);

  // Neutral (light mode)
  static const backgroundLight = Color(0xFF...);
  static const surfaceLight = Color(0xFF...);
  static const borderLight = Color(0xFF...);

  // Neutral (dark mode)
  static const backgroundDark = Color(0xFF...);
  static const surfaceDark = Color(0xFF...);
  static const borderDark = Color(0xFF...);

  // Text
  static const textPrimary = Color(0xFF...);
  static const textSecondary = Color(0xFF...);
  static const textInverse = Color(0xFFFFFFFF);
}
```

Actual color values should match your app's brand — these are placeholders.

---

## Typography Pattern

Define all text styles in `app_text_styles.dart`. Use `const` where possible.
Reference `Theme.of(context).textTheme.*` for system-integrated styles.

```dart
abstract class AppTextStyles {
  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  // ... etc — define styles for your specific app hierarchy
}
```

For Google Fonts, use `GoogleFonts.fontName(textStyle: baseStyle)` to apply the font
while preserving the size/weight/spacing values.

---

## ThemeData — Light and Dark

```dart
abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      surface: AppColors.backgroundLight,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    // ... other component themes
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      surface: AppColors.backgroundDark,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    // ... other component themes
  );
}
```

---

## Theme Mode Toggle (Riverpod)

```dart
// lib/core/theme/theme_provider.dart
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    // Load from storage on init
    return ThemeMode.system;
  }

  Future<void> toggle() async {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    // Persist to SharedPreferences or Hive
  }
}
```

---

## Using Theme in Widgets

Always read colors from `Theme.of(context)` — never hardcode:

```dart
@override
Widget build(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final text = Theme.of(context).textTheme;

  return Container(
    decoration: BoxDecoration(
      color: cs.surface,
      border: Border.all(color: cs.outline),
    ),
    child: Text(
      'Hello',
      style: text.titleMedium?.copyWith(color: cs.primary),
    ),
  );
}
```

---

## Spacing Constants

```dart
// lib/core/theme/app_spacing.dart
abstract class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;

  static const pagePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const cardPadding = EdgeInsets.all(16);
  static const listItemPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
}
```

Always use `AppSpacing.*` in widgets — never raw pixel literals.
