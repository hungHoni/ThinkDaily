# History Review — Context
Last Updated: 2026-03-09

## SESSION PROGRESS

### COMPLETED
- Dev docs created
- Phase 1: HistoryScreen, /history route, StatsScreen compact history link
- Phase 2: ReviewScreen, /review route, ReviewArgs, choice + ordering read-only views
- Phase 3: Architecture review — all HIGH + MEDIUM issues fixed, `flutter analyze` clean

### IN PROGRESS
- Nothing — all phases complete

### BLOCKERS
- None

### Next Session — Resume Here
- Feature is complete. Archive this folder: `mv dev/active/history-review dev/archive/`
- Consider Phase 2d content (Tracks 4-8) as the next task

---

## Quick Resume
1. Read this file
2. Read tasks.md Phase 1 checklist
3. Implement `HistoryScreen` → add route → update StatsScreen history section

---

## Key Files

### Existing (read before editing)
- `lib/features/history/data/sources/progress_service.dart` — `getHistory()` returns raw list; each entry: `{date, problemId, userAnswer, correct}`
- `lib/features/history/presentation/providers/stats_provider.dart` — `statsDataProvider` → `StatsData`; has `history`, `unitAccuracy`, `problemMap` (problemId → unitTitle)
- `lib/features/history/presentation/screens/stats_screen.dart` — current Stats UI; has `_HistoryRow` widget (non-tappable); update to show count + "View all" link
- `lib/features/problem/data/sources/problem_local_source.dart` — `getAllProblems()` for problem lookup by id
- `lib/features/problem/data/models/problem.dart` — `Problem` freezed model (prompt, options, correctAnswer, explanation, thinkingPattern, type, difficulty, unitTitle)
- `lib/app/router.dart` — add `AppRoutes.history` + `AppRoutes.review` constants + GoRoute entries

### To Create
- `lib/features/history/presentation/screens/history_screen.dart` — full history list
- `lib/features/history/presentation/screens/review_screen.dart` — single question review detail

---

## Key Decisions

### Data access pattern
- Look up `Problem` from `problemLocalSourceProvider` by `problemId` in the history entry
- If not found (problem removed from curriculum): show graceful "Question no longer available" row
- Do NOT store the full problem in history — source of truth is local source

### Answer display (ReviewScreen)
- `userAnswer` is stored as JSON-decoded `Object`:
  - choice: `int` (but JSON decodes as `int` — safe)
  - ordering: `List<dynamic>` (need `.cast<int>()`)
- Choice: render all options; mark user's pick (✓ if correct, × if wrong); mark correct answer (✓) if different from user's pick
- Ordering: show user's order vs correct order

### Navigation model
- History entry: GoRouter `extra` passes `ReviewArgs` (entry + problem)
- If `extra` is null on `/review`: pop back to `/history`
- Use `context.push` (not `go`) so back stack is preserved

### Entry point
- Phase 1+2: Stats screen only (simpler)
- Phase 3 decision: Stats-only for now, revisit if user requests HomeScreen entry

### No XP, no state mutation
- ReviewScreen is purely read-only — no calls to ProgressService, XpService, StreakService

### Design system
- Follow existing patterns: `AppColors`, `AppTextStyles`, `AppSpacing`
- Prompt text: `AppTextStyles.problemPrompt` (Lora 20px) — static, no WordReveal animation
- Explanation: `AppTextStyles.explanationBody` (Lora 17px)
- Unit name header: `AppTextStyles.sectionLabel` (mono 12px caps)
- Answer options: reuse visual style from `ChoiceOptions` widget but in read-only/review state

---

## Technical Constraints
- No build_runner needed (no new `@riverpod` providers with code-gen)
- `ProgressService` is already code-gen'd — don't add new `@riverpod` unless needed
- Keep `ReviewArgs` as a plain Dart class (not freezed) — it's only used for navigation
- Existing `StatsData.history` list is the source — no new data layer needed
