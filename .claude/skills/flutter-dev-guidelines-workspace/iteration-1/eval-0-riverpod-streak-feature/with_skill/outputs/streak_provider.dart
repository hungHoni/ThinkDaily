import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'streak_repository.dart';

part 'streak_provider.g.dart';

// ---------------------------------------------------------------------------
// StreakNotifier — async state + mutations
// ---------------------------------------------------------------------------

/// Owns the async [StreakData] state for the whole app.
///
/// Responsibilities:
/// - Loads streak data from [StreakRepository] on first watch.
/// - Exposes [recordCompletion] so the UI can trigger persistence without
///   touching the repository directly.
/// - Re-fetches data after a successful write to keep state fresh.
///
/// Usage in a widget:
/// ```dart
/// final streakAsync = ref.watch(streakNotifierProvider);
/// streakAsync.when(
///   data:    (data)    => StreakWidget(data: data),
///   loading: ()        => const CircularProgressIndicator(),
///   error:   (e, st)   => ErrorWidget(message: e.toString()),
/// );
/// ```
@riverpod
class StreakNotifier extends _$StreakNotifier {
  @override
  Future<StreakData> build() =>
      ref.read(streakRepositoryProvider).getStreakData();

  /// Records today's completion and refreshes state.
  ///
  /// Sets [AsyncValue.loading] optimistically while the write is in-flight,
  /// then re-fetches so the displayed streak is always up to date.
  Future<void> recordCompletion() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(streakRepositoryProvider).recordCompletion();
      // Re-fetch the source of truth after mutation.
      return ref.read(streakRepositoryProvider).getStreakData();
    });
  }

  /// Force-refreshes streak data from the repository.
  ///
  /// Useful for pull-to-refresh or re-entering the screen.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

// ---------------------------------------------------------------------------
// Derived providers — fine-grained selectors to minimise widget rebuilds
// ---------------------------------------------------------------------------

/// Current streak count only. Widgets that show just the counter subscribe
/// here to avoid rebuilding when [bestStreak] or [lastActivityDate] changes.
@riverpod
int? currentStreak(Ref ref) =>
    ref.watch(streakNotifierProvider).valueOrNull?.currentStreak;

/// Best (all-time) streak count only.
@riverpod
int? bestStreak(Ref ref) =>
    ref.watch(streakNotifierProvider).valueOrNull?.bestStreak;
