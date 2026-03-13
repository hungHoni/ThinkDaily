// lib/features/user_profile/presentation/providers/user_stats_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user_stats_repository.dart';

part 'user_stats_provider.g.dart';

/// Async notifier that loads and exposes [UserStats] for the profile screen.
///
/// Responsibilities:
/// - Calls the repository on first watch (via [build]).
/// - Exposes a [refresh] method so the UI can trigger a manual reload.
/// - All async states (loading, data, error) are surfaced via [AsyncValue];
///   the widget layer handles each state explicitly.
///
/// Lifecycle: auto-disposed — the provider is torn down whenever no widget is
/// watching it (e.g. user navigates away), keeping memory clean.
@riverpod
class UserStatsNotifier extends _$UserStatsNotifier {
  @override
  Future<UserStats> build() async {
    // Reads (not watches) the repository — we don't need to rebuild the
    // notifier when the repository provider itself changes.
    return ref.read(userStatsRepositoryProvider).getUserStats();
  }

  /// Manually refreshes the user stats from the repository.
  ///
  /// Sets state to loading while the fetch is in progress, then transitions to
  /// either data or error.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(userStatsRepositoryProvider).getUserStats(),
    );
  }
}
