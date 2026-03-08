class Track {
  const Track({
    required this.id,
    required this.title,
    required this.description,
    required this.totalUnits,
  });

  final String id;
  final String title;
  final String description;
  final int totalUnits;
}

class Unit {
  const Unit({
    required this.trackId,
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final String trackId;
  final int index;
  final String title;
  final String subtitle;
}
