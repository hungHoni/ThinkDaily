// lib/features/user_profile/data/user_stats_repository.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_stats_repository.g.dart';

/// Pure domain entity — no JSON, no external dependencies.
///
/// Represents the statistical snapshot of a user's learning activity.
class UserStats {
  const UserStats({
    required this.displayName,
    required this.totalProblemsSolved,
    required this.currentStreakDays,
    required this.accuracyPercentage,
  });

  final String displayName;
  final int totalProblemsSolved;
  final int currentStreakDays;

  /// Accuracy expressed as a value in [0, 100].
  final double accuracyPercentage;

  @override
  String toString() => 'UserStats('
      'displayName: $displayName, '
      'totalProblemsSolved: $totalProblemsSolved, '
      'currentStreakDays: $currentStreakDays, '
      'accuracyPercentage: $accuracyPercentage)';
}

/// Abstract repository interface.
///
/// Widgets and providers always depend on this abstraction — never on the
/// concrete implementation. Swap out [UserStatsRepositoryImpl] for a real
/// backend implementation without touching any other layer.
abstract class UserStatsRepository {
  /// Returns the current user's stats.
  ///
  /// Throws an [AppException] subtype on failure; never returns null.
  Future<UserStats> getUserStats();
}

// ---------------------------------------------------------------------------
// Hardcoded implementation (no backend yet)
// ---------------------------------------------------------------------------

/// Concrete implementation backed by hardcoded data.
///
/// Replace the body of [getUserStats] with a real Dio / Firestore call once a
/// backend is available. The rest of the codebase does not need to change.
class UserStatsRepositoryImpl implements UserStatsRepository {
  const UserStatsRepositoryImpl();

  @override
  Future<UserStats> getUserStats() async {
    // Simulate a realistic async round-trip (e.g. local DB or network).
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Hardcoded data — swap for real data source when backend is ready.
    return const UserStats(
      displayName: 'Alex Johnson',
      totalProblemsSolved: 142,
      currentStreakDays: 7,
      accuracyPercentage: 84.5,
    );
  }
}

// ---------------------------------------------------------------------------
// Riverpod provider — DI entry point
// ---------------------------------------------------------------------------

/// Provides a [UserStatsRepository] to the rest of the app.
///
/// Override this in tests to inject a mock implementation:
/// ```dart
/// final container = ProviderContainer(
///   overrides: [
///     userStatsRepositoryProvider.overrideWithValue(MockUserStatsRepository()),
///   ],
/// );
/// ```
@riverpod
UserStatsRepository userStatsRepository(Ref ref) =>
    const UserStatsRepositoryImpl();
