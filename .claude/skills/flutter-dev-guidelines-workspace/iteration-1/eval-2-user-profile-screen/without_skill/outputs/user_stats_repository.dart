import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Data model representing a user's profile statistics.
class UserStats {
  const UserStats({
    required this.displayName,
    required this.totalProblemsSolved,
    required this.currentStreak,
    required this.accuracyPercentage,
  });

  /// The user's display name shown in the profile header.
  final String displayName;

  /// Total number of problems the user has solved.
  final int totalProblemsSolved;

  /// Number of consecutive days the user has solved at least one problem.
  final int currentStreak;

  /// Overall accuracy as a value from 0 to 100.
  final double accuracyPercentage;
}

/// Abstract interface for fetching user statistics.
///
/// Decouples the presentation layer from any specific data source so the
/// implementation can be swapped out for a real backend without touching
/// the provider or the screen.
abstract interface class UserStatsRepository {
  /// Returns the [UserStats] for the currently authenticated user.
  ///
  /// Throws an [Exception] on failure so callers can surface an error state.
  Future<UserStats> fetchUserStats();
}

/// Hardcoded implementation of [UserStatsRepository].
///
/// Returns deterministic data so the feature can be built and tested end-to-end
/// without a real backend. Replace with a network or local-storage
/// implementation when the backend is ready.
class HardcodedUserStatsRepository implements UserStatsRepository {
  const HardcodedUserStatsRepository();

  @override
  Future<UserStats> fetchUserStats() async {
    // Simulate a short network round-trip so loading states are exercised.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return const UserStats(
      displayName: 'Alex Thinker',
      totalProblemsSolved: 142,
      currentStreak: 7,
      accuracyPercentage: 73.2,
    );
  }
}

/// Riverpod provider that exposes [UserStatsRepository].
///
/// Override this provider in tests to inject a mock or stub implementation.
final userStatsRepositoryProvider = Provider<UserStatsRepository>(
  (ref) => const HardcodedUserStatsRepository(),
);
