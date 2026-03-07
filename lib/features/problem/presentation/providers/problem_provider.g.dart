// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$problemLocalSourceHash() =>
    r'6adf897b6a59d896e1ea4ee58c2ad0b28500e45e';

/// See also [problemLocalSource].
@ProviderFor(problemLocalSource)
final problemLocalSourceProvider =
    AutoDisposeProvider<ProblemLocalSource>.internal(
      problemLocalSource,
      name: r'problemLocalSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$problemLocalSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProblemLocalSourceRef = AutoDisposeProviderRef<ProblemLocalSource>;
String _$todayProblemHash() => r'0141b8e4be01bb61166d51ef8786758924eb5abb';

/// See also [todayProblem].
@ProviderFor(todayProblem)
final todayProblemProvider = AutoDisposeProvider<Problem?>.internal(
  todayProblem,
  name: r'todayProblemProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todayProblemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayProblemRef = AutoDisposeProviderRef<Problem?>;
String _$answerNotifierHash() => r'f5d4daff4e1e9e4a01b8fb9f57b1b774c02aeaac';

/// See also [AnswerNotifier].
@ProviderFor(AnswerNotifier)
final answerNotifierProvider =
    AutoDisposeNotifierProvider<AnswerNotifier, AnswerState>.internal(
      AnswerNotifier.new,
      name: r'answerNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$answerNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AnswerNotifier = AutoDisposeNotifier<AnswerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
