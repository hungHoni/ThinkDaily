import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'streak_repository.dart';

part 'streak_provider.g.dart';

// ─── Repository provider ──────────────────────────────────────────────────────

/// Provides the [StreakRepository] singleton.
///
/// Override this provider in tests or feature flags to inject any
/// [StreakRepository] implementation without touching widget or notifier code.
///
/// Example — override in tests:
/// ```dart
/// final container = ProviderContainer(overrides: [
///   streakRepositoryProvider.overrideWithValue(FakeStreakRepository()),
/// ]);
/// ```
@riverpod
StreakRepository streakRepository(Ref ref) => MockStreakRepository();

// ─── Streak notifier ──────────────────────────────────────────────────────────

/// Async notifier that owns [StreakData] state for the entire session.
///
/// - `build()` fetches the initial streak on first watch.
/// - `recordCompletion()` mutates state optimistically and syncs to the repo.
/// - All async paths surface through [AsyncValue]; widgets use `.when()`.
@riverpod
class StreakNotifier extends _$StreakNotifier {
  @override
  Future<StreakData> build() {
    final repo = ref.read(streakRepositoryProvider);
    return repo.getStreakData();
  }

  /// Records today's completion and refreshes the displayed streak.
  ///
  /// Optimistic update: state is set to loading momentarily, then resolved
  /// from the repository after the write completes.
  Future<void> recordCompletion() async {
    final repo = ref.read(streakRepositoryProvider);

    // Keep the previous data visible while the write is in flight.
    final previous = state;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await repo.recordCompletion();
      return repo.getStreakData();
    });

    // If the write failed, restore the last good state so the UI is not stuck
    // on an error for an operation the user didn't directly trigger.
    if (state.hasError && previous.hasValue) {
      state = previous;
    }
  }

  /// Force-refreshes streak data from the repository (e.g. pull-to-refresh).
  Future<void> refresh() async {
    final repo = ref.read(streakRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(repo.getStreakData);
  }
}
