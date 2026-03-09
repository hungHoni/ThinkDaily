/// Represents a named XP level in the ThinkDaily progression system.
///
/// Levels are defined in [_levels]. Call [XpLevel.forXp] to resolve
/// the current level for any XP total.
class XpLevel {
  const XpLevel({
    required this.number,
    required this.name,
    required this.minXp,
    this.maxXp,
  });

  final int number;
  final String name;
  final int minXp;
  final int? maxXp; // null → final level, no ceiling

  // ── Static level table ────────────────────────────────────────────────────

  static const _levels = <XpLevel>[
    XpLevel(number: 1, name: 'Beginner',   minXp: 0,    maxXp: 50),
    XpLevel(number: 2, name: 'Curious',    minXp: 50,   maxXp: 150),
    XpLevel(number: 3, name: 'Attentive',  minXp: 150,  maxXp: 300),
    XpLevel(number: 4, name: 'Deliberate', minXp: 300,  maxXp: 500),
    XpLevel(number: 5, name: 'Analytical', minXp: 500,  maxXp: 800),
    XpLevel(number: 6, name: 'Systematic', minXp: 800,  maxXp: 1200),
    XpLevel(number: 7, name: 'Principled', minXp: 1200, maxXp: 1700),
    XpLevel(number: 8, name: 'Masterful',  minXp: 1700, maxXp: 2300),
    XpLevel(number: 9, name: 'Polymathic', minXp: 2300),
  ];

  /// Returns the XpLevel that corresponds to [xp].
  static XpLevel forXp(int xp) =>
      _levels.lastWhere((l) => xp >= l.minXp, orElse: () => _levels.first);

  /// The next level, or null if this is the final level.
  XpLevel? get next {
    final idx = _levels.indexWhere((l) => l.number == number);
    if (idx == -1 || idx >= _levels.length - 1) return null;
    return _levels[idx + 1];
  }

  // ── Progress helpers ──────────────────────────────────────────────────────

  bool get isFinalLevel => maxXp == null;

  /// 0.0–1.0 fill for the progress bar within this level.
  double progressFraction(int currentXp) {
    if (isFinalLevel) return 1;
    if (currentXp <= minXp) return 0;
    return ((currentXp - minXp) / (maxXp! - minXp)).clamp(0.0, 1.0);
  }

  /// How many XP remain until this level is complete.
  int xpToNext(int currentXp) {
    if (isFinalLevel) return 0;
    return (maxXp! - currentXp).clamp(0, maxXp! - minXp);
  }
}
