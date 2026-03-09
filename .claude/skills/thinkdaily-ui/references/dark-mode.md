# Dark Mode Implementation — ThinkDaily

Dark mode for ThinkDaily should feel like switching from a white notebook page to a dark one —
near-black, not pure black. The editorial feel must be preserved.

---

## Target Color Values (Dark Mode)

```dart
// Suggested AppColors additions — add these constants:
static const backgroundDark     = Color(0xFF1A1A1A)  // Near-black page
static const textDark            = Color(0xFFF0F0F0)  // Off-white primary text
static const textSecondaryDark   = Color(0xFF888888)  // Mid-gray labels
static const borderDark          = Color(0xFF2E2E2E)  // Subtle dark dividers
static const surfaceDark         = Color(0xFF242424)  // Slightly lighter surface
static const invertedBackDark    = Color(0xFFEEEEEE)  // Selected: light on dark
static const invertedTextDark    = Color(0xFF111111)  // Text on inverted dark tile
```

---

## Step 1: Extend AppColors

In `lib/core/theme/app_colors.dart`, add the dark variants above.
Keep the existing light constants untouched. Name them `*Dark` to distinguish.

---

## Step 2: Add AppTheme.dark

In `lib/core/theme/app_theme.dart`:

```dart
static ThemeData get dark => ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.textDark,
    onPrimary: AppColors.backgroundDark,
    secondary: AppColors.textSecondaryDark,
    onSecondary: AppColors.backgroundDark,
    error: Color(0xFFCF6679),
    onError: AppColors.backgroundDark,
    surface: AppColors.backgroundDark,
    onSurface: AppColors.textDark,
    outline: AppColors.borderDark,
  ),
  scaffoldBackgroundColor: AppColors.backgroundDark,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundDark,
    foregroundColor: AppColors.textDark,
    elevation: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: GoogleFonts.lora(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textDark,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.borderDark,
    thickness: 1,
    space: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.textDark,
      foregroundColor: AppColors.backgroundDark,
      elevation: 0,
      minimumSize: const Size(double.infinity, 52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    },
  ),
);
```

---

## Step 3: Theme-Aware AppTextStyles

The current `AppTextStyles` hardcodes `AppColors.text` and `AppColors.textSecondary`.
For dark mode, text styles need to pull from `Theme.of(context).colorScheme` instead.

**Short-term approach** (simpler): Add dark variants of each style:

```dart
// In app_text_styles.dart — add dark variants
static TextStyle categoryLabelDark = GoogleFonts.jetBrainsMono(
  fontSize: 11, fontWeight: FontWeight.w400,
  color: AppColors.textSecondaryDark, letterSpacing: 1.5,
);
// ... etc for each style
```

Then in each widget, use:
```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
Text('label', style: isDark ? AppTextStyles.categoryLabelDark : AppTextStyles.categoryLabel)
```

**Long-term approach** (better): Convert AppTextStyles to use `BuildContext`:
```dart
static TextStyle categoryLabel(BuildContext context) {
  final color = Theme.of(context).colorScheme.onSurface.withOpacity(0.5);
  return GoogleFonts.jetBrainsMono(fontSize: 11, color: color, letterSpacing: 1.5);
}
```
This is a larger refactor — do it when you have time, one style at a time.

---

## Step 4: Theme Provider (Riverpod)

Create `lib/core/theme/theme_provider.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    // Start with system default
    return ThemeMode.system;
  }

  Future<void> toggle() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      await prefs.setString(_key, 'light');
    } else {
      state = ThemeMode.dark;
      await prefs.setString(_key, 'dark');
    }
  }
}
```

---

## Step 5: Wire into app.dart

In `lib/app/app.dart`, switch to watching theme mode:

```dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
```

---

## Step 6: Toggle UI in StatsScreen

Add a theme toggle to the StatsScreen header:

```dart
// In StatsScreen header Row:
IconButton(
  onPressed: () => ref.read(themeModeNotifierProvider.notifier).toggle(),
  icon: Icon(
    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
    color: isDark ? AppColors.textDark : AppColors.textSecondary,
    size: 20,
  ),
  padding: EdgeInsets.zero,
  constraints: const BoxConstraints(),
),
```

---

## Handling AppColors in Widgets (Theme-Aware)

For widgets that use `AppColors` constants directly, you have two approaches:

**Pattern A (immediate):** Add `isDark` check locally:
```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
color: isDark ? AppColors.backgroundDark : AppColors.background,
```

**Pattern B (best):** Use `colorScheme`:
```dart
// colorScheme.surface = background
// colorScheme.onSurface = text
// colorScheme.outline = border
final cs = Theme.of(context).colorScheme;
color: cs.surface,
```
Pattern B requires that `AppTheme.dark` correctly maps these. Once the ThemeData is set up
correctly (step 2 above), Pattern B works automatically across all widgets.
