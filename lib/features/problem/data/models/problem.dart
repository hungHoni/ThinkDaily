import 'package:freezed_annotation/freezed_annotation.dart';

part 'problem.freezed.dart';
part 'problem.g.dart';

enum ProblemType { choice, ordering }

enum ProblemCategory {
  logic,
  pattern,
  algorithm,
  decomposition,
  edgeCases,
  estimation,
  dataStructure,
}

extension ProblemCategoryX on ProblemCategory {
  String get label => switch (this) {
        ProblemCategory.logic => 'LOGIC & DEDUCTION',
        ProblemCategory.pattern => 'PATTERN RECOGNITION',
        ProblemCategory.algorithm => 'ALGORITHM THINKING',
        ProblemCategory.decomposition => 'SYSTEM DECOMPOSITION',
        ProblemCategory.edgeCases => 'EDGE CASES & DEBUGGING',
        ProblemCategory.estimation => 'ESTIMATION',
        ProblemCategory.dataStructure => 'DATA STRUCTURE INTUITION',
      };

  // 0 = Monday, 6 = Sunday
  static ProblemCategory fromDayOfWeek(int day) => switch (day) {
        0 => ProblemCategory.logic,
        1 => ProblemCategory.pattern,
        2 => ProblemCategory.algorithm,
        3 => ProblemCategory.decomposition,
        4 => ProblemCategory.edgeCases,
        5 => ProblemCategory.estimation,
        6 => ProblemCategory.dataStructure,
        _ => ProblemCategory.logic,
      };
}

@freezed
class Problem with _$Problem {
  const factory Problem({
    required String id,
    required String date, // YYYY-MM-DD
    required ProblemType type,
    required ProblemCategory category,
    required String prompt,
    required List<String> options,
    required Object correctAnswer, // int for choice, List<int> for ordering
    required String explanation,
    required String thinkingPattern,
  }) = _Problem;

  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
}
