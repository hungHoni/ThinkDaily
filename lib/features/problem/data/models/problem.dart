import 'package:freezed_annotation/freezed_annotation.dart';

part 'problem.freezed.dart';
part 'problem.g.dart';

enum ProblemType { choice, ordering }

enum Difficulty { easy, medium, hard }

extension DifficultyX on Difficulty {
  String get label => switch (this) {
        Difficulty.easy => 'FOUNDATION',
        Difficulty.medium => 'APPLICATION',
        Difficulty.hard => 'CHALLENGE',
      };
}

@freezed
class Problem with _$Problem {
  const factory Problem({
    required String id,
    required String trackId,
    required int unitIndex,
    required int questionIndex,
    required Difficulty difficulty,
    required String unitTitle, // display label shown on ProblemScreen
    required ProblemType type,
    required String prompt,
    required List<String> options,
    required Object correctAnswer, // int for choice, List<int> for ordering
    required String explanation,
    required String thinkingPattern,
  }) = _Problem;

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
}
