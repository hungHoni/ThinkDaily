import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'xp_service.g.dart';

@riverpod
Future<XpService> xpService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return XpService(prefs);
}

class XpService {
  XpService(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'xp_total';

  int get total => _prefs.getInt(_key) ?? 0;

  Future<void> addXp(int amount) async {
    await _prefs.setInt(_key, total + amount);
  }
}
