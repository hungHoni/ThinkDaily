import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_repository.freezed.dart';

// ─── Domain model ─────────────────────────────────────────────────────────────

/// Immutable snapshot of the user's current streak state.
@freezed
class StreakData with _$StreakData {
  const factory StreakData({
    /// Number of consecutive days the user has completed a problem.
    required int currentStreak,

    /// The all-time best streak count.
    required int bestStreak,

    /// The date of the last recorded completion (YYYY-MM-DD), or null if never.
    required String? lastCompletedDate,
  }) = _StreakData;
}

// ─── Abstract interface ───────────────────────────────────────────────────────

/// Repository contract for all streak-related data access.
///
/// Widgets and providers depend on this abstraction, never on the concrete
/// implementation, making it trivial to swap in a real backend later.
abstract class StreakRepository {
  /// Returns the current streak state for the user.
  Future<StreakData> getStreakData();

  /// Records a completion for today, updating the streak if appropriate.
  ///
  /// Calling this multiple times on the same day is a no-op.
  Future<void> recordCompletion();
}

// ─── Mock implementation ──────────────────────────────────────────────────────

/// Hardcoded mock implementation — suitable for development and testing.
///
/// Replace with a real backend implementation (e.g. [SharedPreferencesStreakRepository])
/// without touching any consumer code.
class MockStreakRepository implements StreakRepository {
  MockStreakRepository({
    int currentStreak = 7,
    int bestStreak = 21,
    String? lastCompletedDate = '2026-03-10',
  })  : _currentStreak = currentStreak,
        _bestStreak = bestStreak,
        _lastCompletedDate = lastCompletedDate;

  int _currentStreak;
  int _bestStreak;
  String? _lastCompletedDate;

  @override
  Future<StreakData> getStreakData() async {
    // Simulate a realistic async round-trip (e.g. reading from storage).
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return StreakData(
      currentStreak: _currentStreak,
      bestStreak: _bestStreak,
      lastCompletedDate: _lastCompletedDate,
    );
  }

  @override
  Future<void> recordCompletion() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final today = _todayString();
    if (_lastCompletedDate == today) return; // Already recorded today.

    final yesterday = _yesterdayString();
    _currentStreak =
        _lastCompletedDate == yesterday ? _currentStreak + 1 : 1;
    _bestStreak =
        _currentStreak > _bestStreak ? _currentStreak : _bestStreak;
    _lastCompletedDate = today;
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${_pad(now.month)}-${_pad(now.day)}';
  }

  String _yesterdayString() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return '${yesterday.year}-${_pad(yesterday.month)}-${_pad(yesterday.day)}';
  }

  String _pad(int n) => n.toString().padLeft(2, '0');
}
