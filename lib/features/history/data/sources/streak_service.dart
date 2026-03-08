import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'streak_service.g.dart';

@riverpod
Future<StreakService> streakService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return StreakService(prefs);
}

class StreakService {
  StreakService(this._prefs);

  final SharedPreferences _prefs;

  static const _countKey = 'streak_count';
  static const _lastDateKey = 'streak_last_date';
  static const _bestKey = 'streak_best';

  String get _today =>
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get _yesterday => DateFormat('yyyy-MM-dd').format(
        DateTime.now().subtract(const Duration(days: 1)),
      );

  int get count => _prefs.getInt(_countKey) ?? 0;
  int get best => _prefs.getInt(_bestKey) ?? 0;
  String? get lastDate => _prefs.getString(_lastDateKey);

  /// Call once when the user completes their daily question.
  Future<void> recordToday() async {
    final last = lastDate;
    if (last == _today) return; // Already recorded today

    final newCount = last == _yesterday ? count + 1 : 1;
    final newBest = newCount > best ? newCount : best;

    await _prefs.setInt(_countKey, newCount);
    await _prefs.setInt(_bestKey, newBest);
    await _prefs.setString(_lastDateKey, _today);
  }
}
