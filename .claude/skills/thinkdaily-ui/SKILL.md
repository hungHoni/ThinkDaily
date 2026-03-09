---
name: thinkdaily-ui
description: >
  ThinkDaily app-specific UI design guidelines and visual improvement patterns.
  ALWAYS load this skill when working on any screen or widget in ThinkDaily — especially
  HomeScreen, ProblemScreen, FeedbackScreen, StatsScreen, DoneScreen, or any widget in
  lib/features/ or lib/core/widgets/. Also trigger when the user mentions: UI improvements,
  dark mode, animations, visual polish, design language, colors, typography, "UI looks plain",
  "UI is disappointing", "make it look better", "redesign", "stats screen", "done screen",
  "feedback screen", or any design-related request. This is the authoritative source of truth
  for ThinkDaily's design system — do not invent colors, fonts, or spacing from scratch.
  Load before flutter-dev-guidelines or in addition to it.
---

# ThinkDaily UI Design System

ThinkDaily's visual language is **editorial and minimal** — like a quality notebook. Every
design decision should feel intentional, calm, and focused. Avoid decoration for its own sake.

---

## Typography (Two-Font System)

| Role | Font | Usage |
|------|------|-------|
| Content / reading | **Lora** (serif) | Problem prompts, explanations, titles, done message |
| UI / labels / data | **JetBrains Mono** (mono) | Category labels, stats, button labels, XP, streaks |

**Defined styles in `lib/core/theme/app_text_styles.dart`:**

| Style | Font | Size | Weight | Use |
|-------|------|------|--------|-----|
| `appTitle` | Lora | 28 | 500 | Screen titles (ThinkDaily, Stats) |
| `problemPrompt` | Lora | 20 | 400 | Question text, lh 1.6 |
| `explanationBody` | Lora | 17 | 400 | Feedback explanation text, lh 1.7 |
| `doneMessage` | Lora | 22 | 400 | Celebratory or "done" text, lh 1.5 |
| `optionText` / `optionTextInverted` | Lora | 16 | 400 | Answer choice text |
| `feedbackResult` | Lora | 14 | 400 | "Correct." / "Not quite." label |
| `categoryLabel` | JetBrains Mono | 11 | 400 | ALL CAPS labels, metadata, ls 1.5 |
| `thinkingPattern` | JetBrains Mono | 13 | 400 | Stats values, thinking pattern name |
| `buttonLabel` | JetBrains Mono | 13 | 500 | Button text, ls 1 |

Never use raw `GoogleFonts.lora(...)` inline in widgets — always reference `AppTextStyles.*`.
Never hardcode font sizes or weights outside of `app_text_styles.dart`.

---

## Color Palette

**File: `lib/core/theme/app_colors.dart`**

```dart
// The full palette — monochromatic, intentionally minimal
background         = Color(0xFFFFFFFF)  // White — page background
text               = Color(0xFF111111)  // Near-black — primary text, button bg
textSecondary      = Color(0xFF555555)  // Medium gray — labels, metadata
border             = Color(0xFFE0E0E0)  // Light gray — dividers, separators
surface            = Color(0xFFF8F8F8)  // Near-white — card/tile backgrounds
invertedBackground = Color(0xFF111111)  // Black — selected option bg, correct answer
invertedText       = Color(0xFFFFFFFF)  // White — text on inverted backgrounds
```

**Rules:**
- Never introduce new colors without adding them to `AppColors`
- Never use `Color(0xFF...)` literals in widget files
- The "inverted" pair (black/white flip) is the primary selection affordance

---

## Spacing

**File: `lib/core/theme/app_spacing.dart`** — always use these constants:

```dart
xs = 4, sm = 8, md = 16, lg = 24, xl = 32, xxl = 48
screenHorizontal = 28  // page left/right padding
pagePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 16)
```

HomeScreen uses `fromLTRB(28, 24, 28, 28)` — the wider 28px feels editorial.

---

## Component Conventions

**Buttons:**
- Always full-width, height 52–56px
- `ElevatedButton` with `AppColors.text` bg (from theme, square-ish radius 4)
- Label uses `AppTextStyles.buttonLabel`

**Dividers:**
- Always `Divider(height: 1, color: AppColors.border)` — thin, minimal
- Used as section separators, not decorative

**Option tiles (ChoiceOptions):**
- Full invert on selection: `invertedBackground` bg + `optionTextInverted` text
- `AnimatedContainer(duration: 150ms, curve: Curves.easeOut)` for transition
- No border/radius — flat with dividers between options

**Progress indicator (HomeScreen):**
- Row of `Expanded` thin bars (height: 2)
- Completed: `AppColors.text`, Current: `AppColors.textSecondary`, Remaining: `AppColors.border`

---

## Animation Patterns

Use `flutter_animate` package for all animations. Preferred pattern:

```dart
// Fade + slide up (standard entry animation)
Widget
  .animate()
  .fadeIn(duration: 400.ms)
  .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut)

// Staggered — each element delays after previous
.animate(delay: 400.ms)  // add delay for sequential reveals

// Always check reduced motion
if (MediaQuery.of(context).disableAnimations) {
  return widget;  // no animation
}
```

Word-by-word reveal is done via `WordReveal` widget (`lib/core/widgets/word_reveal.dart`).
Always use this for question prompts and explanations.

---

## Screens at a Glance

| Screen | File | State | Weakness |
|--------|------|-------|----------|
| HomeScreen | `features/home/presentation/screens/home_screen.dart` | Good | Dead space mid-screen, stats row is flat |
| ProblemScreen | `features/problem/presentation/screens/problem_screen.dart` | Good | No haptic on option select |
| FeedbackScreen | `features/problem/presentation/screens/feedback_screen.dart` | Good | "Correct." result feels underwhelming |
| DoneScreen | `features/problem/presentation/screens/done_screen.dart` | OK | No celebratory moment, stats feel static |
| StatsScreen | `features/history/presentation/screens/stats_screen.dart` | Plain | No visual hierarchy, all text — needs visual bars |
| SplashScreen | `features/problem/presentation/screens/splash_screen.dart` | — | — |

---

## Dark Mode (Not Yet Implemented)

Dark mode is the highest-impact UI improvement. See `references/dark-mode.md` for the
full implementation plan with exact color values.

Key principle: dark mode should be **near-black, not pure black** — `#1A1A1A` background,
`#F0F0F0` primary text. Borders become `#2E2E2E`. This preserves the editorial feel in dark.

---

## UI Quick Wins

These are high-value, low-effort improvements:

1. **Haptic feedback on option select** — `HapticFeedback.selectionClick()` in `_OptionTile.onTap`
2. **Haptic on submit** — `HapticFeedback.mediumImpact()` when CTA tapped
3. **StatsScreen visual bars** — replace text-only accuracy rows with inline progress bars
4. **DoneScreen animation** — animate the stat numbers counting up on entry
5. **FeedbackScreen result** — make "Correct." larger, green-tinted (or the reverse for wrong)
6. **Dark mode toggle** — add to StatsScreen header

See `references/screen-improvements.md` for concrete code patterns for each.

---

## What NOT to Do

- Don't add colorful accents (blue, purple, green UI elements) — this breaks the monochromatic feel
- Don't add Card widgets with shadows — everything is flat
- Don't use `BorderRadius.circular(12+)` for buttons — use radius 4
- Don't add icons to buttons — text-only
- Don't add bottom navigation bars or tabs — single-focus flow
- Don't use `Inter` or other sans-serif fonts for body text — Lora only for content
- Don't hardcode pixel values — use `AppSpacing` constants

---

## References

| Topic | File | When to read |
|-------|------|-------------|
| Dark mode implementation | `references/dark-mode.md` | When adding dark mode |
| Screen-specific improvements | `references/screen-improvements.md` | When improving a specific screen |
