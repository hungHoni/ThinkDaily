// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProblemImpl _$$ProblemImplFromJson(Map<String, dynamic> json) =>
    _$ProblemImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      type: $enumDecode(_$ProblemTypeEnumMap, json['type']),
      category: $enumDecode(_$ProblemCategoryEnumMap, json['category']),
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
      'date': instance.date,
      'type': _$ProblemTypeEnumMap[instance.type]!,
      'category': _$ProblemCategoryEnumMap[instance.category]!,
      'prompt': instance.prompt,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
      'thinkingPattern': instance.thinkingPattern,
    };

const _$ProblemTypeEnumMap = {
  ProblemType.choice: 'choice',
  ProblemType.ordering: 'ordering',
};

const _$ProblemCategoryEnumMap = {
  ProblemCategory.logic: 'logic',
  ProblemCategory.pattern: 'pattern',
  ProblemCategory.algorithm: 'algorithm',
  ProblemCategory.decomposition: 'decomposition',
  ProblemCategory.edgeCases: 'edgeCases',
  ProblemCategory.estimation: 'estimation',
  ProblemCategory.dataStructure: 'dataStructure',
};
