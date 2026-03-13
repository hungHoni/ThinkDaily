# ThinkDaily Architecture Reference

## File Structure
```
lib/
  app/
    app.dart                    — MaterialApp + ProviderScope
    router.dart                 — GoRouter config, AppRoutes, _fadePage helper
  core/
    theme/
      app_colors.dart           — Monochromatic palette (white/black/grey)
      app_text_styles.dart      — Lora + JetBrains Mono styles
      app_spacing.dart          — xs/sm/md/lg/xl/xxl + pagePadding
      app_theme.dart            — ThemeData
    widgets/
      word_reveal.dart          — Animated word-by-word text reveal
  features/
    home/
      presentation/screens/
        home_screen.dart        — Main screen (currently hardcoded to one track)
    problem/
      data/
        models/
          problem.dart          — Freezed: id, trackId, unitIndex, questionIndex, etc.
          track.dart            — Plain class: Track (id, title, desc, totalUnits), Unit
          user_progress.dart    — Freezed: trackId, currentUnitIndex, currentQuestionIndex, completedIds
        sources/
          problem_local_source.dart — All tracks/units/problems data + query methods
          user_progress_service.dart — SharedPreferences, getProgress(trackId), markCompleted
      presentation/
        providers/
          problem_provider.dart — problemLocalSource, nextQuestion(trackId), AnswerNotifier
        screens/
          problem_screen.dart   — Question display (hardcoded _defaultTrackId)
          feedback_screen.dart  — Answer feedback + saves progress/streak/XP
          done_screen.dart      — "Nicely done" + streak/XP + back to home
          splash_screen.dart    — App launch -> /home
        widgets/
          choice_options.dart, ordering_widget.dart, submit_button.dart
    history/
      data/sources/
        xp_service.dart         — SharedPreferences, total XP int
        streak_service.dart     — SharedPreferences, count/best/lastDate
        progress_service.dart   — SharedPreferences, history list + completed dates
      presentation/
        providers/stats_provider.dart — StatsData (history, unitAccuracy, problemMap)
        screens/stats_screen.dart    — Streak, XP, accuracy bars, history list
    notifications/
      notification_service.dart — Push notification setup
```

## Data Flow
1. Splash -> Home (always)
2. Home: watches userProgressService, streakService, xpService, problemLocalSource
3. Home CTA -> Problem: uses nextQuestion(trackId)
4. Problem -> submit -> Feedback: passes FeedbackArgs(problem, answerState)
5. Feedback "Done": saves to progressService, advances userProgress, records streak + XP, invalidates nextQuestion cache
6. Feedback -> Done: shows streak + XP
7. Done -> Home: go(AppRoutes.home)

## Provider Pattern
All services follow: `@riverpod Future<ServiceClass> serviceName(Ref ref) async { prefs = await SharedPrefs; return Service(prefs); }`
Consumers: `ref.watch(serviceProvider)` returns AsyncValue, guard with .isLoading/.hasError/.value!

## Content Structure
- 3 tracks coded (problem-decomposition, systems-thinking, mental-models)
- Each track: 4-5 units, each unit: 3 questions (problems)
- Problems: choice (pick 1 of 4) or ordering (arrange steps)
- XP: +10 correct, +5 wrong
