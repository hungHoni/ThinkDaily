import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

@freezed
class UserProgress with _$UserProgress {
  const factory UserProgress({
    required String trackId,
    @Default(0) int currentUnitIndex,
    @Default(0) int currentQuestionIndex,
    @Default([]) List<String> completedIds,
    String? lastCompletedDate, // YYYY-MM-DD — used for "one per day" gate
  }) = _UserProgress;

  factory UserProgress.fromJson(Map<String, dynamic> json) =>
      _$UserProgressFromJson(json);
}
