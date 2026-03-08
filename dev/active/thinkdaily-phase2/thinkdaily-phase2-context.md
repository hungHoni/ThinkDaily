# ThinkDaily Phase 2 — Context
Last Updated: 2026-03-10

## SESSION PROGRESS

### COMPLETED
- Phase 1: All 8 phases — core app fully working (one question per day, date-based)
- Phase 2 planning: full curriculum designed (8 tracks, AI-era thinking skills)
- Track 1 content: all 4 units × 3 questions written in curriculum.md
- Tracks 2–8: unit structure + question outlines written in curriculum.md
- **Phase 2a: Curriculum data model — DONE** (`flutter analyze` → No issues found)
  - Problem model revised: dropped `date`/`category`, added `trackId`/`unitIndex`/`questionIndex`/`difficulty`/`unitTitle`
  - New: `Track`, `Unit` models (track.dart)
  - New: `UserProgress` model (user_progress.dart, freezed)
  - New: `UserProgressService` (user_progress_service.dart, shared_preferences)
  - Rewrote `problem_local_source.dart` — 12 Track 1 questions, curriculum structure
  - Updated `problem_provider.dart` — `nextQuestionProvider(trackId)` replaces `todayProblemProvider`
  - Updated all screens: ProblemScreen, FeedbackScreen, DoneScreen, SplashScreen

- **Phase 2b: Streaks + XP + Home Screen — DONE** (`flutter analyze` → No issues found)
  - New: `StreakService` — consecutive day tracking + best streak
  - New: `XpService` — XP accumulation (+10 correct, +5 wrong)
  - New: `HomeScreen` — track/unit info, streak, XP, CTA or "come back tomorrow"
  - Updated: router (added `/home`), splash → always goes to `/home`
  - Updated: DoneScreen — "Nicely done" + streak + XP + Back to Home
  - Updated: FeedbackScreen Done button — records streak + XP, invalidates next question cache
  - Flow: Splash → Home → Problem → Feedback → Done → Home

- **Phase 2c: Stats + Feedback Polish — DONE** (`flutter analyze` → No issues found)
  - New: `StatsScreen` — streak (current + best), XP, accuracy by unit, history list (newest first)
  - New: `stats_provider.dart` — `statsDataProvider` computes `StatsData` outside build()
    - `StatsData`: history list, unitAccuracy map (`UnitAccuracy` with correct/total/pct), problemId→unitTitle map
  - Updated: router — added `/stats` route + `AppRoutes.stats` constant
  - Updated: `HomeScreen` — bar chart icon (top right) pushes to `/stats`; `ref.read→ref.watch` for problemLocalSource; error state guard added
  - Updated: `FeedbackScreen` — animated "+10 XP" / "+5 XP" label fades in after thinking pattern
  - Fixed: dead ternary `userAnswer is List ? userAnswer : userAnswer` in `progress_service.dart`

### IN PROGRESS
- Phase 2d: Tracks 4–8 still need questions written + coded

### BLOCKERS
- None

### Next Session — Resume Here
- Start Track 4: Decision Making (4 units × 3 questions)
- Write questions in curriculum.md first, then code into problem_local_source.dart
- Follow tasks.md Phase 2d checklist

## Quick Resume
1. Read this file
2. Read tasks.md Phase 2d section (Tracks 4–8 remaining)
3. Write Track 4 questions in curriculum.md first, then code them into problem_local_source.dart

## App Identity
"Daily training for human thinking in an AI world."
8 tracks: Problem Decomposition, Systems Thinking, Mental Models, Decision Making,
Estimation & Scale, Critical Evaluation, System Design Thinking, Communication Thinking.

## Key Decisions
- Curriculum-based: Track → Unit → Question (not date-based)
- UserProgress tracks position per track (currentUnitIndex, currentQuestionIndex)
- Each day: nextQuestion(trackId) advances through curriculum in order
- XP: +10 correct, +5 wrong/attempted — showing up counts
- Streak: increments on any answer
- HomeScreen replaces Splash as initial route
- shared_preferences for all persistence (same as Phase 1)
- Derived/computed stats live in presentation/providers (not computed in build())
- Always run code-architecture-reviewer agent after completing each phase

## Key Files (all created/updated)
- `lib/features/problem/data/models/problem.dart` — revised (curriculum fields)
- `lib/features/problem/data/models/track.dart` — Track + Unit models
- `lib/features/problem/data/models/user_progress.dart` — freezed
- `lib/features/problem/data/sources/problem_local_source.dart` — 12 Track 1 questions
- `lib/features/problem/data/sources/user_progress_service.dart` — progress + markCompleted
- `lib/features/problem/presentation/providers/problem_provider.dart` — nextQuestionProvider
- `lib/features/history/data/sources/streak_service.dart` — streak tracking
- `lib/features/history/data/sources/xp_service.dart` — XP accumulation
- `lib/features/history/data/sources/progress_service.dart` — history (date, problemId, correct)
- `lib/features/history/presentation/providers/stats_provider.dart` — statsDataProvider
- `lib/features/history/presentation/screens/stats_screen.dart` — Stats UI
- `lib/features/home/presentation/screens/home_screen.dart` — main home base
- `lib/app/router.dart` — all routes incl. /home, /stats

## Content
- Full curriculum: `thinkdaily-phase2-curriculum.md`
- Track 1 (Problem Decomposition): 4 units × 3 questions — FULLY WRITTEN + CODED
- Track 2 (Systems Thinking): 4 units × 3 questions — FULLY WRITTEN + CODED
- Track 3 (Mental Models): 5 units × 3 questions — FULLY WRITTEN + CODED
  - Architecture review passed: answer distribution fixed (no repeated index within unit), raw strings correct
- Tracks 4–8: outlined, questions to be written (Phase 2d continues)
