// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      trackId: json['trackId'] as String,
      currentUnitIndex: (json['currentUnitIndex'] as num?)?.toInt() ?? 0,
      currentQuestionIndex:
          (json['currentQuestionIndex'] as num?)?.toInt() ?? 0,
      completedIds:
          (json['completedIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastCompletedDate: json['lastCompletedDate'] as String?,
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'trackId': instance.trackId,
      'currentUnitIndex': instance.currentUnitIndex,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'completedIds': instance.completedIds,
      'lastCompletedDate': instance.lastCompletedDate,
    };
