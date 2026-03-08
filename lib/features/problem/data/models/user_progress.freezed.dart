// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProgress _$UserProgressFromJson(Map<String, dynamic> json) {
  return _UserProgress.fromJson(json);
}

/// @nodoc
mixin _$UserProgress {
  String get trackId => throw _privateConstructorUsedError;
  int get currentUnitIndex => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  List<String> get completedIds => throw _privateConstructorUsedError;
  String? get lastCompletedDate => throw _privateConstructorUsedError;

  /// Serializes this UserProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProgressCopyWith<UserProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressCopyWith<$Res> {
  factory $UserProgressCopyWith(
    UserProgress value,
    $Res Function(UserProgress) then,
  ) = _$UserProgressCopyWithImpl<$Res, UserProgress>;
  @useResult
  $Res call({
    String trackId,
    int currentUnitIndex,
    int currentQuestionIndex,
    List<String> completedIds,
    String? lastCompletedDate,
  });
}

/// @nodoc
class _$UserProgressCopyWithImpl<$Res, $Val extends UserProgress>
    implements $UserProgressCopyWith<$Res> {
  _$UserProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackId = null,
    Object? currentUnitIndex = null,
    Object? currentQuestionIndex = null,
    Object? completedIds = null,
    Object? lastCompletedDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            trackId: null == trackId
                ? _value.trackId
                : trackId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentUnitIndex: null == currentUnitIndex
                ? _value.currentUnitIndex
                : currentUnitIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            currentQuestionIndex: null == currentQuestionIndex
                ? _value.currentQuestionIndex
                : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            completedIds: null == completedIds
                ? _value.completedIds
                : completedIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastCompletedDate: freezed == lastCompletedDate
                ? _value.lastCompletedDate
                : lastCompletedDate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProgressImplCopyWith<$Res>
    implements $UserProgressCopyWith<$Res> {
  factory _$$UserProgressImplCopyWith(
    _$UserProgressImpl value,
    $Res Function(_$UserProgressImpl) then,
  ) = __$$UserProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String trackId,
    int currentUnitIndex,
    int currentQuestionIndex,
    List<String> completedIds,
    String? lastCompletedDate,
  });
}

/// @nodoc
class __$$UserProgressImplCopyWithImpl<$Res>
    extends _$UserProgressCopyWithImpl<$Res, _$UserProgressImpl>
    implements _$$UserProgressImplCopyWith<$Res> {
  __$$UserProgressImplCopyWithImpl(
    _$UserProgressImpl _value,
    $Res Function(_$UserProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackId = null,
    Object? currentUnitIndex = null,
    Object? currentQuestionIndex = null,
    Object? completedIds = null,
    Object? lastCompletedDate = freezed,
  }) {
    return _then(
      _$UserProgressImpl(
        trackId: null == trackId
            ? _value.trackId
            : trackId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentUnitIndex: null == currentUnitIndex
            ? _value.currentUnitIndex
            : currentUnitIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        currentQuestionIndex: null == currentQuestionIndex
            ? _value.currentQuestionIndex
            : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        completedIds: null == completedIds
            ? _value._completedIds
            : completedIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastCompletedDate: freezed == lastCompletedDate
            ? _value.lastCompletedDate
            : lastCompletedDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProgressImpl implements _UserProgress {
  const _$UserProgressImpl({
    required this.trackId,
    this.currentUnitIndex = 0,
    this.currentQuestionIndex = 0,
    final List<String> completedIds = const [],
    this.lastCompletedDate,
  }) : _completedIds = completedIds;

  factory _$UserProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressImplFromJson(json);

  @override
  final String trackId;
  @override
  @JsonKey()
  final int currentUnitIndex;
  @override
  @JsonKey()
  final int currentQuestionIndex;
  final List<String> _completedIds;
  @override
  @JsonKey()
  List<String> get completedIds {
    if (_completedIds is EqualUnmodifiableListView) return _completedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedIds);
  }

  @override
  final String? lastCompletedDate;

  @override
  String toString() {
    return 'UserProgress(trackId: $trackId, currentUnitIndex: $currentUnitIndex, currentQuestionIndex: $currentQuestionIndex, completedIds: $completedIds, lastCompletedDate: $lastCompletedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressImpl &&
            (identical(other.trackId, trackId) || other.trackId == trackId) &&
            (identical(other.currentUnitIndex, currentUnitIndex) ||
                other.currentUnitIndex == currentUnitIndex) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            const DeepCollectionEquality().equals(
              other._completedIds,
              _completedIds,
            ) &&
            (identical(other.lastCompletedDate, lastCompletedDate) ||
                other.lastCompletedDate == lastCompletedDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    trackId,
    currentUnitIndex,
    currentQuestionIndex,
    const DeepCollectionEquality().hash(_completedIds),
    lastCompletedDate,
  );

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      __$$UserProgressImplCopyWithImpl<_$UserProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressImplToJson(this);
  }
}

abstract class _UserProgress implements UserProgress {
  const factory _UserProgress({
    required final String trackId,
    final int currentUnitIndex,
    final int currentQuestionIndex,
    final List<String> completedIds,
    final String? lastCompletedDate,
  }) = _$UserProgressImpl;

  factory _UserProgress.fromJson(Map<String, dynamic> json) =
      _$UserProgressImpl.fromJson;

  @override
  String get trackId;
  @override
  int get currentUnitIndex;
  @override
  int get currentQuestionIndex;
  @override
  List<String> get completedIds;
  @override
  String? get lastCompletedDate;

  /// Create a copy of UserProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProgressImplCopyWith<_$UserProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
