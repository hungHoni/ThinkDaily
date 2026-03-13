import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'streak_repository.freezed.dart';
part 'streak_repository.g.dart';

// ---------------------------------------------------------------------------
// Domain entity
// ---------------------------------------------------------------------------

/// Immutable snapshot of a user's streak state.
///
/// [currentStreak] — consecutive days the user has completed a problem.
/// [bestStreak]    — all-time longest streak.
/// [lastActivityDate] — ISO-8601 date (YYYY-MM-DD) of the most recent
///                      completion, or null if the user has never completed a
///                      problem.
@freezed
class StreakData with _$StreakData {
  const factory StreakData({
    required int currentStreak,
    required int bestStreak,
    String? lastActivityDate,
  }) = _StreakData;
}

// ---------------------------------------------------------------------------
// Abstract repository interface
// ---------------------------------------------------------------------------

/// Contract for streak persistence. All widgets and providers depend only on
/// this interface — never on the concrete implementation.
abstract class StreakRepository {
  /// Returns the user's current streak snapshot.
  Future<StreakData> getStreakData();

  /// Records a completion event for today. Idempotent — safe to call multiple
  /// times on the same calendar day.
  Future<void> recordCompletion();
}

// ---------------------------------------------------------------------------
// Mock implementation (hardcoded data — replace with real backend later)
// ---------------------------------------------------------------------------

/// A hardcoded [StreakRepository] that returns static mock data.
///
/// Drop-in replacement for a real implementation once the backend is ready.
/// Simulates a 250 ms network delay to exercise loading states in the UI.
class MockStreakRepository implements StreakRepository {
  const MockStreakRepository();

  static const _mockCurrentStreak = 7;
  static const _mockBestStreak = 21;
  static const _mockLastActivityDate = '2026-03-10';

  @override
  Future<StreakData> getStreakData() async {
    // Simulate async latency (e.g. network or local DB read).
    await Future<void>.delayed(const Duration(milliseconds: 250));

    return const StreakData(
      currentStreak: _mockCurrentStreak,
      bestStreak: _mockBestStreak,
      lastActivityDate: _mockLastActivityDate,
    );
  }

  @override
  Future<void> recordCompletion() async {
    // No-op in mock — real implementation would persist to storage.
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

// ---------------------------------------------------------------------------
// Riverpod provider — dependency injection
// ---------------------------------------------------------------------------

/// Provides the [StreakRepository] singleton to the Riverpod graph.
///
/// Override this in tests via [ProviderContainer] or [ProviderScope] overrides:
/// ```dart
/// streakRepositoryProvider.overrideWithValue(mockRepo)
/// ```
@Riverpod(keepAlive: true)
StreakRepository streakRepository(Ref ref) => const MockStreakRepository();
