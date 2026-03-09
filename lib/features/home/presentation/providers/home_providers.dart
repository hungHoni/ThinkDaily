import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks which track the user is currently working on.
/// Defaults to the first track; persists for the session.
class ActiveTrackNotifier extends Notifier<String> {
  static const _defaultTrackId = 'problem-decomposition';

  @override
  String build() => _defaultTrackId;

  // ignore: use_setters_to_change_properties
  void setTrack(String trackId) => state = trackId;
}

final activeTrackNotifierProvider =
    NotifierProvider<ActiveTrackNotifier, String>(ActiveTrackNotifier.new);
