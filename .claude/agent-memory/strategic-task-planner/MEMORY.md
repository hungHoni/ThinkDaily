# Strategic Task Planner — Memory

## Project Architecture (confirmed 2026-03-09)
- See [architecture.md](./architecture.md) for details

## Key Patterns
- Riverpod: `@riverpod` annotation + code-gen (NOT manual Provider/StateProvider)
- Services: SharedPreferences wrapped in service class, exposed via `@riverpod Future<Service>`
- Models: Freezed for complex models (UserProgress, Problem), plain Dart classes for simple ones (Track, Unit)
- Animations: flutter_animate + `MediaQuery.of(context).disableAnimations` guard on every animated widget
- Theme: AppColors (monochromatic), AppTextStyles (Lora serif + JetBrains Mono), AppSpacing constants
- Widgets: private `_WidgetName` for screen-internal components
- Navigation: go_router with `_fadePage` transition helper

## Current State (as of 2026-03-09)
- Phase 2a-2c complete (curriculum data model, streaks, XP, home screen, stats)
- Phase 2d in progress (Tracks 4-8 content, only 3 tracks coded so far)
- Hardcoded `_trackId` / `_defaultTrackId` in HomeScreen and ProblemScreen — needs to become dynamic
- XP is just a raw integer, no leveling system
- 3 tracks exist: problem-decomposition (4 units), systems-thinking (4 units), mental-models (5 units)
- All persistence: SharedPreferences (no Hive, no SQLite)

## Design Constraints
- Editorial/minimal: no color accents, no shadows, no heavy cards
- Fonts: Lora (serif) for content, JetBrains Mono for labels/data
- Colors: #FFFFFF bg, #111111 text, #555555 secondary, #E0E0E0 border, #F8F8F8 surface
