// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'problem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Problem _$ProblemFromJson(Map<String, dynamic> json) {
  return _Problem.fromJson(json);
}

/// @nodoc
mixin _$Problem {
  String get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // YYYY-MM-DD
  ProblemType get type => throw _privateConstructorUsedError;
  ProblemCategory get category => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  Object get correctAnswer =>
      throw _privateConstructorUsedError; // int for choice, List<int> for ordering
  String get explanation => throw _privateConstructorUsedError;
  String get thinkingPattern => throw _privateConstructorUsedError;

  /// Serializes this Problem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProblemCopyWith<Problem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProblemCopyWith<$Res> {
  factory $ProblemCopyWith(Problem value, $Res Function(Problem) then) =
      _$ProblemCopyWithImpl<$Res, Problem>;
  @useResult
  $Res call({
    String id,
    String date,
    ProblemType type,
    ProblemCategory category,
    String prompt,
    List<String> options,
    Object correctAnswer,
    String explanation,
    String thinkingPattern,
  });
}

/// @nodoc
class _$ProblemCopyWithImpl<$Res, $Val extends Problem>
    implements $ProblemCopyWith<$Res> {
  _$ProblemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
    Object? category = null,
    Object? prompt = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? thinkingPattern = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ProblemType,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ProblemCategory,
            prompt: null == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            thinkingPattern: null == thinkingPattern
                ? _value.thinkingPattern
                : thinkingPattern // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProblemImplCopyWith<$Res> implements $ProblemCopyWith<$Res> {
  factory _$$ProblemImplCopyWith(
    _$ProblemImpl value,
    $Res Function(_$ProblemImpl) then,
  ) = __$$ProblemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String date,
    ProblemType type,
    ProblemCategory category,
    String prompt,
    List<String> options,
    Object correctAnswer,
    String explanation,
    String thinkingPattern,
  });
}

/// @nodoc
class __$$ProblemImplCopyWithImpl<$Res>
    extends _$ProblemCopyWithImpl<$Res, _$ProblemImpl>
    implements _$$ProblemImplCopyWith<$Res> {
  __$$ProblemImplCopyWithImpl(
    _$ProblemImpl _value,
    $Res Function(_$ProblemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
    Object? category = null,
    Object? prompt = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? explanation = null,
    Object? thinkingPattern = null,
  }) {
    return _then(
      _$ProblemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ProblemType,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ProblemCategory,
        prompt: null == prompt
            ? _value.prompt
            : prompt // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        thinkingPattern: null == thinkingPattern
            ? _value.thinkingPattern
            : thinkingPattern // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProblemImpl implements _Problem {
  const _$ProblemImpl({
    required this.id,
    required this.date,
    required this.type,
    required this.category,
    required this.prompt,
    required final List<String> options,
    required this.correctAnswer,
    required this.explanation,
    required this.thinkingPattern,
  }) : _options = options;

  factory _$ProblemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProblemImplFromJson(json);

  @override
  final String id;
  @override
  final String date;
  // YYYY-MM-DD
  @override
  final ProblemType type;
  @override
  final ProblemCategory category;
  @override
  final String prompt;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final Object correctAnswer;
  // int for choice, List<int> for ordering
  @override
  final String explanation;
  @override
  final String thinkingPattern;

  @override
  String toString() {
    return 'Problem(id: $id, date: $date, type: $type, category: $category, prompt: $prompt, options: $options, correctAnswer: $correctAnswer, explanation: $explanation, thinkingPattern: $thinkingPattern)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProblemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(
              other.correctAnswer,
              correctAnswer,
            ) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.thinkingPattern, thinkingPattern) ||
                other.thinkingPattern == thinkingPattern));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    type,
    category,
    prompt,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(correctAnswer),
    explanation,
    thinkingPattern,
  );

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProblemImplCopyWith<_$ProblemImpl> get copyWith =>
      __$$ProblemImplCopyWithImpl<_$ProblemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProblemImplToJson(this);
  }
}

abstract class _Problem implements Problem {
  const factory _Problem({
    required final String id,
    required final String date,
    required final ProblemType type,
    required final ProblemCategory category,
    required final String prompt,
    required final List<String> options,
    required final Object correctAnswer,
    required final String explanation,
    required final String thinkingPattern,
  }) = _$ProblemImpl;

  factory _Problem.fromJson(Map<String, dynamic> json) = _$ProblemImpl.fromJson;

  @override
  String get id;
  @override
  String get date; // YYYY-MM-DD
  @override
  ProblemType get type;
  @override
  ProblemCategory get category;
  @override
  String get prompt;
  @override
  List<String> get options;
  @override
  Object get correctAnswer; // int for choice, List<int> for ordering
  @override
  String get explanation;
  @override
  String get thinkingPattern;

  /// Create a copy of Problem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProblemImplCopyWith<_$ProblemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
