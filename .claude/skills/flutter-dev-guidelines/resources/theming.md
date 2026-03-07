# Theming — Colors, Typography, Dark Mode

## Setup in app.dart

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'ThinkDaily',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
```

---

## Color System

```dart
// lib/core/theme/app_colors.dart
abstract class AppColors {
  // Brand palette
  static const primary = Color(0xFF4F46E5);      // Indigo 600
  static const primaryLight = Color(0xFF818CF8);  // Indigo 400
  static const primaryDark = Color(0xFF3730A3);   // Indigo 800

  static const secondary = Color(0xFF7C3AED);     // Violet 600
  static const accent = Color(0xFF06B6D4);        // Cyan 500

  // Semantic
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFD97706);
  static const error = Color(0xFFDC2626);
  static const info = Color(0xFF2563EB);

  // Neutral (light)
  static const surfaceLight = Color(0xFFFFFFFF);
  static const backgroundLight = Color(0xFFF8FAFC);
  static const cardLight = Color(0xFFFFFFFF);
  static const borderLight = Color(0xFFE2E8F0);

  // Neutral (dark)
  static const surfaceDark = Color(0xFF1E293B);
  static const backgroundDark = Color(0xFF0F172A);
  static const cardDark = Color(0xFF1E293B);
  static const borderDark = Color(0xFF334155);

  // Text
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const textDisabled = Color(0xFF94A3B8);
  static const textInverse = Color(0xFFFFFFFF);
}
```

---

## Typography

```dart
// lib/core/theme/app_text_styles.dart
abstract class AppTextStyles {
  // Use Google Fonts or custom font
  static const _fontFamily = 'Inter';

  static const displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const headlineLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const headlineMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.29,
  );

  static const titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static const titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const labelLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
}
```

---

## ThemeData — Light and Dark

```dart
// lib/core/theme/app_theme.dart
abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
    ),
    textTheme: _textTheme,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.textPrimary,
      titleTextStyle: AppTextStyles.titleLarge,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight, width: 1),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyles.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.borderLight, thickness: 1),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    ),
    textTheme: _textTheme,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.textInverse,
      titleTextStyle: AppTextStyles.titleLarge,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderDark),
      ),
    ),
  );

  static TextTheme get _textTheme => TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    labelLarge: AppTextStyles.labelLarge,
    bodySmall: AppTextStyles.caption,
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
    final stored = ref.read(hiveStorageProvider).get<String>(_key);
    return switch (stored) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await ref.read(hiveStorageProvider).set(_key, mode.name);
  }

  void toggle() {
    setTheme(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
```

---

## Using Theme in Widgets

```dart
// Always use Theme.of(context) — never hardcode
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;
  final text = theme.textTheme;

  return Container(
    decoration: BoxDecoration(
      color: colors.surface,            // ✅ theme-aware
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colors.outline),
    ),
    child: Text(
      'Hello',
      style: text.titleMedium?.copyWith(color: colors.primary), // ✅
    ),
  );
}

// WRONG
return Container(
  color: const Color(0xFFFFFFFF),       // ❌ hardcoded
  child: Text('Hello', style: TextStyle(fontSize: 16, color: Color(0xFF000000))), // ❌
);
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

// Usage
Padding(
  padding: AppSpacing.pagePadding,
  child: ...,
)
```
