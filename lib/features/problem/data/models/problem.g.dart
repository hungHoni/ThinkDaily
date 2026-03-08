// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProblemImpl _$$ProblemImplFromJson(Map<String, dynamic> json) =>
    _$ProblemImpl(
      id: json['id'] as String,
      trackId: json['trackId'] as String,
      unitIndex: (json['unitIndex'] as num).toInt(),
      questionIndex: (json['questionIndex'] as num).toInt(),
      difficulty: $enumDecode(_$DifficultyEnumMap, json['difficulty']),
      unitTitle: json['unitTitle'] as String,
      type: $enumDecode(_$ProblemTypeEnumMap, json['type']),
      prompt: json['prompt'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswer: json['correctAnswer'] as Object,
      explanation: json['explanation'] as String,
      thinkingPattern: json['thinkingPattern'] as String,
    );

Map<String, dynamic> _$$ProblemImplToJson(_$ProblemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackId': instance.trackId,
      'unitIndex': instance.unitIndex,
      'questionIndex': instance.questionIndex,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'unitTitle': instance.unitTitle,
      'type': _$ProblemTypeEnumMap[instance.type]!,
      'prompt': instance.prompt,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'thinkingPattern': instance.thinkingPattern,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
};

const _$ProblemTypeEnumMap = {
  ProblemType.choice: 'choice',
  ProblemType.ordering: 'ordering',
};
