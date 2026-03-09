# History Review — Plan

## Executive Summary

Users who answer a question today have no way to revisit it later. This feature adds
a **read-only review flow** where users can browse every question they've ever answered,
see whether they got it right, re-read the full prompt, their answer vs the correct answer,
and the explanation. No XP is awarded — this is a pure learning/reflection tool.

**Why it matters:** Spaced repetition and reflection are core to habit formation. Showing
users the breadcrumb of their learning journey reinforces engagement and gives the app
lasting value beyond the daily streak.

---

## Current State

### What exists
- `ProgressService.getHistory()` returns `List<Map<String, dynamic>>` — each entry has:
  - `date` (String, yyyy-MM-dd)
  - `problemId` (String)
  - `userAnswer` (Object — int for choice, List<int> for ordering)
  - `correct` (bool)
- `StatsScreen` shows a flat `_HistoryRow` list (date + unit name + ✓/×) — **not tappable**
- `StatsData` in `stats_provider.dart` exposes `history` list + `problemMap` (problemId → unitTitle)
- `ProblemLocalSource.getAllProblems()` can look up any problem by id to get full prompt/options/explanation
- All routes centralised in `router.dart` with `AppRoutes` constants

### What's missing
- No route or screen for browsing the full history list
- No route or screen for reviewing a single answered question in detail
- `_HistoryRow` in StatsScreen has no tap interaction
- StatsScreen's history section shows a compact summary — not the right place to expand into full detail

---

## Implementation Phases

### Phase 1 — History List Screen
**Route:** `/history`
**Entry point:** Stats screen — replace inline history list with a "View history →" row that pushes to `/history`

**New file:** `lib/features/history/presentation/screens/history_screen.dart`

Screen layout:
- Header: "History" (appTitle) + ← back
- Divider
- ListView of `_HistoryRow` entries, newest first
- Each row: unit name, date, ✓/× indicator — **tappable** → pushes to `/review` with extra args
- Empty state: "No questions answered yet."

**Acceptance criteria:**
- [ ] `/history` route renders full history list
- [ ] Each row is tappable and navigates to review
- [ ] Stats screen "HISTORY" section replaced with a single count + "View history" link
- [ ] Empty state shown when no history
- [ ] `flutter analyze` → No issues

---

### Phase 2 — Review Screen (Question Detail)
**Route:** `/review`
**Entry point:** History list row tap

**New file:** `lib/features/history/presentation/screens/review_screen.dart`
**New model:** `ReviewArgs` (passed via GoRouter `extra`)

```
ReviewArgs {
  final Map<String, dynamic> entry;   // history entry (date, userAnswer, correct)
  final Problem problem;              // full problem looked up by id
}
```

Screen layout:
- Header: unit name (sectionLabel/categoryLabel caps) + difficulty badge + ← back
- Problem prompt (static Text, not WordReveal — this is review, not new content)
- Divider
- Answer section:
  - For `choice`: show all options; user's pick highlighted with ✗ or ✓; correct answer always highlighted with ✓ (if different from user's)
  - For `ordering`: show user's order vs correct order, side by side or sequentially
- Divider
- Explanation (Lora, explanationBody style)
- Thinking pattern label (categoryLabel mono, caps)
- No submit button, no XP label

**Acceptance criteria:**
- [ ] `/review` receives `ReviewArgs` via `extra` and renders correctly
- [ ] Choice questions: user answer highlighted (wrong = muted/strikethrough or X marker, correct = ✓ marker)
- [ ] Ordering questions: user's order shown alongside correct order
- [ ] Explanation always visible
- [ ] Graceful fallback if problem not found in local source (problem removed from curriculum)
- [ ] `flutter analyze` → No issues

---

### Phase 3 — Entry Point Polish
- Add "History" entry point to HomeScreen (secondary, below the track list or via a small link in the stats footer)
- OR: Keep entry point purely via Stats (simpler — avoids HomeScreen cluttering)
- **Decision:** Stats-only entry for now. If user requests HomeScreen entry, add in Phase 3.

**Acceptance criteria:**
- [ ] Stats screen "HISTORY" section cleanly shows count + "View all →" tap target
- [ ] Navigation to history and back works with GoRouter push/pop
- [ ] Architecture review passes (no HIGH/MEDIUM issues)

---

## Risk Assessment

| Risk | Likelihood | Mitigation |
|------|-----------|-----------|
| `userAnswer` is `Object` — ordering answers stored as `List<dynamic>` after JSON roundtrip | High | Cast carefully in ReviewScreen; test both problem types |
| Problem deleted from curriculum → `problemId` not found | Medium | Show "Question no longer available" fallback row |
| History can grow large → ScrollView perf | Low | ListView.builder already used; no pagination needed for MVP |
| GoRouter `extra` not type-safe | Low | Null-check and fallback to `/history` if args missing |

---

## Success Metrics
- User can tap any history entry and see the full question + their answer + explanation
- Zero new lint issues
- Architecture review passes
- Ordering and choice question types both render correctly in review
