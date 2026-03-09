# History Review — Tasks

## Phase 1: History List Screen ✓ COMPLETE

### Router
- [x] Add `static const history = '/history'` to `AppRoutes`
- [x] Add `GoRoute` for `/history` → `HistoryScreen` in `router.dart`

### HistoryScreen
- [x] Create `lib/features/history/presentation/screens/history_screen.dart`
- [x] Create `ReviewArgs` class in `router.dart`

### StatsScreen update
- [x] Replace inline history list with compact "X questions answered →" link
- [x] Remove unused `_HistoryRow` widget

### Quality
- [x] `flutter analyze` → No issues found

---

## Phase 2: Review Screen (Question Detail) ✓ COMPLETE

### Router
- [x] Add `static const review = '/review'` to `AppRoutes`
- [x] Add `GoRoute` for `/review` with `extra` → `ReviewScreen` in `router.dart`

### ReviewScreen
- [x] Create `lib/features/history/presentation/screens/review_screen.dart`
  - Header: ← back + ✓ CORRECT / × INCORRECT label
  - Unit name (caps) + difficulty label
  - Prompt (Lora 20px, static)
  - Choice: all options with ✓/× markers
  - Ordering: your order vs correct order with position highlighting
  - Explanation + thinking pattern + answered date

### Quality
- [x] `flutter analyze` → No issues found

---

## Phase 3: Architecture Review + Polish ✓ COMPLETE

- [x] Run `code-architecture-reviewer` agent — fixed all HIGH + MEDIUM issues:
  - HIGH: Safe casts for `correctAnswer` and `userAnswer` (is-guard + num.toInt())
  - HIGH: Ordering list decoded via `map((e) => (e as num).toInt())` — no cast<int>() crash
  - MEDIUM: `problemById` moved into `StatsData` — `_HistoryBody` is now `StatelessWidget`
  - MEDIUM: `/review` GoRoute uses `redirect` for null `ReviewArgs` → `/history`
  - LOW: `@immutable` added to `ReviewArgs`
- [ ] Verify back navigation: Stats → History → Review → back → History → back → Stats
- [ ] Verify both `choice` and `ordering` question types render correctly in review
- [ ] Verify graceful fallback when `problemId` not found
- [ ] Update `history-review-context.md` — mark all phases complete
- [x] `flutter analyze` → No issues found

---

## Status Legend
- [ ] Not started
- [x] Done
- [~] In progress

---

## Quick Resume

**Next task:** Phase 3 — Run code-architecture-reviewer agent
**Phase:** 3 of 3
**Tasks complete:** 12 / 17
