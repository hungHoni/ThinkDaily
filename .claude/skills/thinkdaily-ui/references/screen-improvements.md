# Screen-by-Screen Improvement Patterns

Concrete, ready-to-implement improvements for each ThinkDaily screen.

---

## HomeScreen

**File:** `lib/features/home/presentation/screens/home_screen.dart`

### Improvement 1: Haptic on CTA button
```dart
ElevatedButton(
  onPressed: () {
    HapticFeedback.mediumImpact();
    context.push(AppRoutes.problem);
  },
  // ...
)
```
Add `import 'package:flutter/services.dart';` at top.

### Improvement 2: Animate stats row on mount
```dart
// Wrap the stats Row in animate
Row(children: [...])
  .animate(delay: 200.ms)
  .fadeIn(duration: 400.ms)
  .moveY(begin: 6, end: 0, duration: 400.ms, curve: Curves.easeOut)
```

### Improvement 3: Show unit description (if available)
If `Unit` has a subtitle or description field, show it below the unit title in a smaller
`categoryLabel` style to give context to the user before they start.

### Improvement 4: Progress bar as animated fill
Instead of a static color, animate the progress bars to fill on mount:
```dart
// Use AnimatedContainer on each bar segment
AnimatedContainer(
  duration: const Duration(milliseconds: 600),
  curve: Curves.easeOut,
  height: 2,
  color: i < completedUnits ? AppColors.text : AppColors.border,
)
```

---

## ProblemScreen

**File:** `lib/features/problem/presentation/screens/problem_screen.dart`

### Improvement 1: Haptic on option select (HIGH PRIORITY)
In `lib/features/problem/presentation/widgets/choice_options.dart`, in `_OptionTile`:
```dart
class _OptionTile extends StatelessWidget {
  // ... existing fields

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      color: isSelected ? AppColors.invertedBackground : AppColors.background,
      child: InkWell(
        onTap: onTap == null ? null : () {
          HapticFeedback.selectionClick();  // ← ADD THIS
          onTap!();
        },
        // ... rest unchanged
      ),
    );
  }
}
```

### Improvement 2: Scale animation on option select
```dart
AnimatedScale(
  scale: isSelected ? 1.0 : 1.0,  // subtle: use in combination with color
  duration: const Duration(milliseconds: 150),
  // Actually: use a slight left-indent on selected
)
```

A simpler, more editorial approach — add a left accent bar on selected:
```dart
// In _OptionTile build, wrap content:
AnimatedContainer(
  duration: const Duration(milliseconds: 150),
  curve: Curves.easeOut,
  color: isSelected ? AppColors.invertedBackground : AppColors.background,
  child: InkWell(
    onTap: ...,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          // Left accent — visible only when selected
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: isSelected ? 3 : 0,
            height: 20,
            margin: EdgeInsets.only(right: isSelected ? 12 : 0),
            color: AppColors.invertedText,
          ),
          Expanded(
            child: Text(
              label,
              style: isSelected ? AppTextStyles.optionTextInverted : AppTextStyles.optionText,
            ),
          ),
        ],
      ),
    ),
  ),
)
```

---

## FeedbackScreen

**File:** `lib/features/problem/presentation/screens/feedback_screen.dart`

### Improvement 1: Make result label visually stronger
The current "Correct." / "Not quite." in `feedbackResult` (14px mono, gray) is too quiet.
Make it larger and use the font pairing:

```dart
// Replace the result Text with:
Text(
  isCorrect ? 'Correct.' : 'Not quite.',
  style: GoogleFonts.lora(  // Use appTitle scale, not feedbackResult
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.2,
  ),
)
```

Or add a category label above it to provide context:
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      isCorrect ? 'CORRECT' : 'NOT QUITE',
      style: AppTextStyles.categoryLabel,  // mono, caps
    ),
    const SizedBox(height: 6),
    Text(
      isCorrect
          ? 'Well reasoned.'
          : 'Here\'s the right answer.',
      style: AppTextStyles.doneMessage,  // Lora 22
    ),
  ],
)
```

### Improvement 2: Haptic on done button
```dart
ElevatedButton(
  onPressed: () async {
    HapticFeedback.mediumImpact();
    // ... existing logic
  },
)
```

### Improvement 3: Subtle background tint for result state
A very subtle tint communicates correct/incorrect without breaking the palette:
```dart
// Add a 2px top border in the Scaffold
// OR: a thin colored strip at top of content area
// Keep it very subtle — just a 2px line at page top, not a full color change
Container(
  height: 2,
  color: isCorrect ? AppColors.text : AppColors.textSecondary,
)
```

---

## DoneScreen

**File:** `lib/features/problem/presentation/screens/done_screen.dart`

### Improvement 1: Animate stats on entry
Make the streak/XP numbers count up to their values:

```dart
// Use flutter_animate's custom effect or TweenAnimationBuilder
TweenAnimationBuilder<int>(
  tween: IntTween(begin: 0, end: streak),
  duration: const Duration(milliseconds: 800),
  curve: Curves.easeOut,
  builder: (context, value, _) {
    return Text('$value', style: AppTextStyles.appTitle);
  },
)
```

Wrap in a check for `MediaQuery.of(context).disableAnimations`.

### Improvement 2: Stagger the stats rows
```dart
// Wrap "Nicely done." text:
Text('Nicely done.', style: AppTextStyles.doneMessage)
  .animate()
  .fadeIn(duration: 500.ms)
  .moveY(begin: 12, end: 0, duration: 500.ms, curve: Curves.easeOut),

// Wrap first stat row:
_StatRow(label: 'DAY STREAK', value: '$streak')
  .animate(delay: 300.ms)
  .fadeIn(duration: 400.ms)
  .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut),

// Wrap second stat row:
_StatRow(label: 'XP TOTAL', value: '$xp')
  .animate(delay: 500.ms)
  .fadeIn(duration: 400.ms)
  .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut),
```

### Improvement 3: Add a streak milestone note
If streak is a milestone (7, 14, 30, etc.), show a brief note:
```dart
if (streak > 0 && streak % 7 == 0)
  Padding(
    padding: const EdgeInsets.only(top: AppSpacing.sm),
    child: Text(
      '${streak} day milestone.',
      style: AppTextStyles.categoryLabel,
    ),
  ),
```

---

## StatsScreen

**File:** `lib/features/history/presentation/screens/stats_screen.dart`

### Improvement 1: Visual accuracy bars (HIGH PRIORITY)
Replace the text-only `_UnitAccuracyRow` with an inline progress bar:

```dart
class _UnitAccuracyRow extends StatelessWidget {
  const _UnitAccuracyRow({required this.unitName, required this.accuracy});

  final String unitName;
  final UnitAccuracy accuracy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(unitName, style: AppTextStyles.thinkingPattern)),
            Text(
              '${accuracy.pct}%',
              style: AppTextStyles.categoryLabel,
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Progress bar
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 2,
                  width: constraints.maxWidth,
                  color: AppColors.border,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  height: 2,
                  width: constraints.maxWidth * (accuracy.pct / 100),
                  color: AppColors.text,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          '${accuracy.correct} of ${accuracy.total} correct',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}
```

### Improvement 2: Animate bars on mount
Use `flutter_animate` to trigger the bar animation on entry. Since `AnimatedContainer`
fires on mount, this works automatically — but add a stagger if there are multiple bars:
```dart
_UnitAccuracyRow(unitName: entry.key, accuracy: entry.value)
  .animate(delay: Duration(milliseconds: 100 * index))
  .fadeIn(duration: 300.ms)
```
Use `entries.toList().asMap().entries` to get the index.

### Improvement 3: Streak visualization — a simple dot grid
Show a 7-column grid of dots representing the last N days (filled = active):

```dart
// Simple dot grid for streak — no extra packages
class _StreakGrid extends StatelessWidget {
  const _StreakGrid({required this.activeDays, required this.totalDays});

  final Set<String> activeDays;  // 'YYYY-MM-DD' format
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: List.generate(totalDays, (i) {
        final date = DateTime.now().subtract(Duration(days: totalDays - 1 - i));
        final key = '${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
        final active = activeDays.contains(key);
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? AppColors.text : AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
```

---

## General: SystemChrome for Status Bar

Ensure status bar matches the screen background on all screens:
```dart
// In AppTheme.light:
systemOverlayStyle: SystemUiOverlayStyle.dark  // dark icons on white bg

// In AppTheme.dark (when added):
systemOverlayStyle: SystemUiOverlayStyle.light  // light icons on dark bg
```
