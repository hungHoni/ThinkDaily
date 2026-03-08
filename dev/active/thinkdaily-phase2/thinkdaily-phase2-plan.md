# ThinkDaily Phase 2 — AI-Era Thinking Skills App

## Why
Phase 1 delivers one question per day. That's functional but thin — no reason to return, no sense of progress, no structure. Phase 2 transforms the app into a curriculum-driven daily training tool for the skills that matter most in the AI era.

AI writes code. What AI can't replace is **how you think**: framing problems, navigating uncertainty, seeing systems, making decisions. ThinkDaily trains exactly this.

## Goal
Transform ThinkDaily from a random daily quiz into a structured learning curriculum — like a Duolingo for human thinking skills. Users progress through tracks (topics) → units (chapters) → questions, building knowledge systematically from easy to hard.

## App Identity
**"Daily training for human thinking in an AI world."**

## The 8 Tracks
| # | Track | Core Question |
|---|-------|--------------|
| 1 | Problem Decomposition | "Am I solving the right thing?" |
| 2 | Systems Thinking | "What happens next, and then what?" |
| 3 | Mental Models | "What frame should I use here?" |
| 4 | Decision Making | "How do I choose under uncertainty?" |
| 5 | Estimation & Scale | "Is this number reasonable?" |
| 6 | Critical Evaluation | "What could go wrong?" |
| 7 | System Design Thinking | "How do the pieces fit?" |
| 8 | Communication Thinking | "How do I make this understood?" |

Full curriculum content: see `thinkdaily-phase2-curriculum.md`

---

## Architecture Overview

### Data Model Redesign (biggest change)
Current model is flat — `Problem` has a `date` field for lookup.
New model adds curriculum hierarchy: **Track → Unit → Question**.

**New models:**
```dart
Track(id, title, description, totalUnits)
Unit(trackId, index, title, subtitle)
```

**Revised Problem model** (drop `date`, add curriculum fields):
```dart
Problem(
  id, trackId, unitIndex, questionIndex,
  difficulty,  // easy | medium | hard
  type, prompt, options, correctAnswer,
  explanation, thinkingPattern
)
```

**New UserProgress model** (replaces date-based lookup):
```dart
UserProgress(
  trackId: 'problem-decomposition',
  currentUnitIndex: 2,
  currentQuestionIndex: 0,
  completedIds: ['pd-001', 'pd-002', ...]
)
```

Each day → `nextQuestion(trackId)` from user's current position. No date matching.

### New Data (shared_preferences)
- `streak_count` — int, consecutive days answered
- `streak_last_date` — String (YYYY-MM-DD), last day answered
- `xp_total` — int, cumulative XP
- `user_progress_{trackId}` — JSON of UserProgress per track

### New Screens
1. **HomeScreen** — replaces SplashScreen; shows track progress, streak, XP, today's CTA
2. **StatsScreen** — accuracy by unit, streak, XP, history list

### Modified Screens
- **FeedbackScreen** — show XP earned (+10 correct, +5 wrong)
- **DoneScreen** — show streak milestone, unit complete celebration, XP total

### New Providers
- `streakProvider` — reads/writes streak
- `xpProvider` — reads/writes XP
- `userProgressProvider` — reads/writes curriculum position

### New Widgets
- `StreakBadge` — streak count display
- `XpCounter` — total XP display
- `TrackProgressBar` — unit completion progress

---

## Implementation Order

```
Phase 2a — Curriculum Data Model (do first):
  [ ] Write full question content for Track 1 (Problem Decomposition, 4 units × 3 Qs)
  [ ] Revise Problem model: drop `date`, add trackId/unitIndex/questionIndex/difficulty
  [ ] Add Track and Unit models
  [ ] Add UserProgress model + UserProgressService
  [ ] Rewrite problem_local_source.dart with Track 1 questions
  [ ] Update todayProblemProvider → nextQuestionProvider(trackId)
  [ ] Run build_runner

Phase 2b — Streaks + XP + Home Screen:
  [ ] StreakService
  [ ] XpService
  [ ] streakProvider + xpProvider (Riverpod)
  [ ] HomeScreen: track name, unit progress, streak badge, XP, today's CTA
  [ ] Wire HomeScreen as initial route
  [ ] DoneScreen: streak milestone + XP + unit complete celebration
  [ ] Run build_runner

Phase 2c — Stats + Feedback Polish:
  [ ] StatsScreen: streak, XP, accuracy per unit, history list
  [ ] FeedbackScreen: animated "+10 XP" / "+5 XP" reveal
  [ ] Add /stats route

Phase 2d — More Content (ongoing):
  [ ] Write full questions for Tracks 2–8 (see curriculum.md status table)
  [ ] Practice mode (redo past questions, no XP impact)
```

---

## Key Files

### Existing — to modify
- `lib/features/problem/data/models/problem.dart` — revise model (drop date, add curriculum fields)
- `lib/features/problem/data/sources/problem_local_source.dart` — rewrite with Track 1 content
- `lib/features/problem/presentation/providers/problem_provider.dart` — replace todayProblemProvider
- `lib/app/router.dart` — add /home and /stats routes
- `lib/features/problem/presentation/screens/done_screen.dart` — streak/XP/unit complete
- `lib/features/problem/presentation/screens/feedback_screen.dart` — XP reveal

### New Files — Phase 2a
- `lib/features/problem/data/models/track.dart` — Track + Unit models
- `lib/features/problem/data/models/user_progress.dart` — UserProgress model
- `lib/features/problem/data/sources/user_progress_service.dart` — progress persistence

### New Files — Phase 2b
- `lib/features/history/data/sources/streak_service.dart`
- `lib/features/history/data/sources/xp_service.dart`
- `lib/features/history/presentation/providers/streak_provider.dart`
- `lib/features/history/presentation/providers/xp_provider.dart`
- `lib/features/home/presentation/screens/home_screen.dart`
- `lib/core/widgets/streak_badge.dart`
- `lib/core/widgets/xp_counter.dart`

### New Files — Phase 2c
- `lib/features/history/presentation/screens/stats_screen.dart`

---

## Verification
1. `flutter analyze` — no issues
2. Launch app → HomeScreen loads with streak=0, XP=0
3. Answer today's question → streak becomes 1, XP +10 or +5
4. DoneScreen shows updated streak + XP
5. Tap stats icon → StatsScreen shows correct data
6. Answer next day → streak becomes 2
7. Miss a day → streak resets to 0
