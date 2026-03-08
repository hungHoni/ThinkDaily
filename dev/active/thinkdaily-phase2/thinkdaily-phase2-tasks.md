# ThinkDaily Phase 2 — Tasks

## Phase 2a: Curriculum Data Model ✓ COMPLETE

### Content
- [x] Design 8-track curriculum structure
- [x] Write full questions for Track 1, Units 1–4 (Problem Decomposition, 12 questions)
- [ ] Write full questions for Track 2 (Systems Thinking, 4 units × 3 Qs)
- [ ] Write full questions for Tracks 3–8 (see curriculum.md status table)

### Data Model Redesign
- [x] Revise `Problem` model — dropped `date`/`category`, added curriculum fields
- [x] Create `Track` + `Unit` models in `lib/features/problem/data/models/track.dart`
- [x] Create `UserProgress` model in `lib/features/problem/data/models/user_progress.dart`
- [x] Create `UserProgressService` in `lib/features/problem/data/sources/user_progress_service.dart`
- [x] Rewrite `problem_local_source.dart` with Track 1 questions (no more dates)
- [x] Update `problem_provider.dart` → `nextQuestionProvider(trackId)`
- [x] Run build_runner + `flutter analyze` → No issues

---

## Phase 2b: Streaks + XP + Home Screen ✓ COMPLETE

- [x] Create `StreakService` — consecutive day tracking, best streak
- [x] Create `XpService` — XP accumulation (+10 correct, +5 wrong)
- [x] Create `HomeScreen` — track/unit progress, streak, XP, CTA or "come back tomorrow"
- [x] Add `/home` route to router
- [x] Update `SplashScreen` → always navigates to `/home`
- [x] Update `DoneScreen` — shows "Nicely done" + streak + XP + Back to Home button
- [x] Update `FeedbackScreen` Done button — records streak + XP, invalidates next question cache
- [x] Run build_runner + `flutter analyze` → No issues

---

## Phase 2c: Stats + Feedback Polish ✓ COMPLETE

- [x] Create `StatsScreen` in `lib/features/history/presentation/screens/stats_screen.dart`
  - Current streak + best streak
  - Total XP
  - Accuracy per unit (correct / attempted)
  - History list: past questions (date, unit name, correct/wrong)
- [x] Add `/stats` route to router
- [x] Add stats icon button on HomeScreen (top right)
- [x] FeedbackScreen: animated "+10 XP" / "+5 XP" label after result reveal
- [x] Create `StatsProvider` in `lib/features/history/presentation/providers/stats_provider.dart`
  - Moved accuracy aggregation out of build() into a Riverpod provider
  - `statsDataProvider` returns `StatsData` (history, unitAccuracy map, problemId→unitTitle map)
- [x] Architecture review fixes: error state guards, ref.read→ref.watch, dead ternary in progress_service.dart
- [x] Run build_runner + `flutter analyze` → No issues

---

## Phase 2d: More Content

- [x] Track 2: Systems Thinking — 4 units × 3 questions
- [x] Track 3: Mental Models — 5 units × 3 questions
- [ ] Track 4: Decision Making — 4 units × 3 questions
- [ ] Track 5: Estimation & Scale — 4 units × 3 questions
- [ ] Track 6: Critical Evaluation — 4 units × 3 questions
- [ ] Track 7: System Design Thinking — 4 units × 3 questions
- [ ] Track 8: Communication Thinking — 3 units × 3 questions

---

## Future (Phase 3)
- [ ] Practice mode — redo past questions, no XP impact
- [ ] Track selection — choose which track to work on
- [ ] Achievements / badges
- [ ] Onboarding flow

---

## Status Legend
- [ ] Not started
- [x] Done
- [~] In progress
