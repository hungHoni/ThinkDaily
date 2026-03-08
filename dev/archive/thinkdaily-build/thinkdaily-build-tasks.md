# ThinkDaily Build — Task Checklist
Last Updated: 2026-03-07

## Phase 1 — Project Setup + Models + Theme COMPLETE
- [x] Flutter project created
- [x] pubspec.yaml with all deps, sorted, no lint warnings
- [x] analysis_options.yaml configured
- [x] AppColors, AppTextStyles, AppSpacing, AppTheme
- [x] Problem model (freezed + json_serializable)
- [x] ProblemLocalSource with 7 sample problems (one per category)
- [x] Riverpod providers: todayProblemProvider, AnswerNotifier
- [x] GoRouter with fade transitions, AppRoutes constants, FeedbackArgs
- [x] build_runner generates cleanly
- [x] flutter analyze passes — No issues found

## Phase 2 — Screen Skeletons + Navigation COMPLETE
- [x] SplashScreen — auto-advances to /problem after 1.5s
- [x] ProblemScreen — category label, problem text, answer section
- [x] FeedbackScreen — result, correct answer reveal, explanation, thinking pattern
- [x] DoneScreen — "Come back tomorrow." + tomorrow's category
- [x] ChoiceOptions widget — inversion styling, tap to select/deselect
- [x] OrderingWidget — ReorderableListView drag-to-rank
- [x] SubmitButton — animated opacity, appears when selection made

## Phase 3 — Answer Interaction COMPLETE
- [x] AnswerNotifier: selectChoice, updateOrdering, submit, reset
- [x] Evaluation logic: equality for choice, deep list equals for ordering
- [x] ProblemScreen wires answer widgets to notifier
- [x] Submit navigates to /feedback with FeedbackArgs
- [x] Verify: both problem types evaluate correctly on device/simulator

## Phase 4 — Feedback Screen COMPLETE
- [x] Result label: "Correct." / "Not quite."
- [x] _ChoiceReveal: highlights correct option (inverted)
- [x] _OrderingReveal: shows correct sequence
- [x] Explanation text
- [x] Thinking pattern in mono font
- [x] Done button → reset answer state → /done

## Phase 5 — Local Storage (shared_preferences) COMPLETE
- [x] Create `lib/features/history/data/sources/progress_service.dart`
  - `hasCompletedToday()` → bool
  - `saveResult(problemId, userAnswer, correct)`
  - `getHistory()` → List<Map>
- [x] Wire SplashScreen: check hasCompletedToday() → /done or /problem
- [x] Wire saveResult in FeedbackScreen Done button before context.go

## Phase 6 — Animations COMPLETE
- [x] SplashScreen: app title fade-up on entry (600ms fadeIn + moveY 12px)
- [x] ProblemScreen: category label fade (400ms) + prompt word-by-word reveal (40ms stagger)
- [x] FeedbackScreen: staggered reveal (result → answer → explanation → pattern)
- [x] Screen transitions: already using fade (router.dart) ✅
- [x] ChoiceOptions: AnimatedContainer inversion already wired ✅
- [x] SubmitButton: AnimatedOpacity already wired ✅
- [x] Wrap all in MediaQuery.disableAnimations check (WordReveal + inline guards)

## Phase 7 — Daily Notifications COMPLETE
- [x] Add flutter_local_notifications setup (NotificationService with riverpod provider)
- [x] Request permission on first launch (tracked via shared_preferences key)
- [x] Schedule daily notification at 9am: "Today's problem is ready."
- [x] Notification tap opens app to /problem (via normal app launch → splash → problem flow)
- [x] Android manifest: POST_NOTIFICATIONS, RECEIVE_BOOT_COMPLETED, receivers registered

## Phase 8 — Content + Polish COMPLETE
- [x] Write remaining 83 problems (7 done in Phase 1)
- [x] Typography review on device
- [x] Edge case: no problem for today → "No problem today" screen
- [x] Final flutter analyze --fatal-infos
- [x] Test on iOS + Android

## Quick Resume
**Next task:** All phases complete! 🎉
**Phase:** 8 of 8
**Status:** 8/8 phases complete — all done
