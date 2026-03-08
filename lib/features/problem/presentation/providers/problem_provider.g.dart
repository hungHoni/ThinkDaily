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
String _$nextQuestionHash() => r'46b51306bf3c4330202edeaf7c35c87edf340e34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [nextQuestion].
@ProviderFor(nextQuestion)
const nextQuestionProvider = NextQuestionFamily();

/// See also [nextQuestion].
class NextQuestionFamily extends Family<AsyncValue<Problem?>> {
  /// See also [nextQuestion].
  const NextQuestionFamily();

  /// See also [nextQuestion].
  NextQuestionProvider call(String trackId) {
    return NextQuestionProvider(trackId);
  }

  @override
  NextQuestionProvider getProviderOverride(
    covariant NextQuestionProvider provider,
  ) {
    return call(provider.trackId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'nextQuestionProvider';
}

/// See also [nextQuestion].
class NextQuestionProvider extends AutoDisposeFutureProvider<Problem?> {
  /// See also [nextQuestion].
  NextQuestionProvider(String trackId)
    : this._internal(
        (ref) => nextQuestion(ref as NextQuestionRef, trackId),
        from: nextQuestionProvider,
        name: r'nextQuestionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$nextQuestionHash,
        dependencies: NextQuestionFamily._dependencies,
        allTransitiveDependencies:
            NextQuestionFamily._allTransitiveDependencies,
        trackId: trackId,
      );

  NextQuestionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.trackId,
  }) : super.internal();

  final String trackId;

  @override
  Override overrideWith(
    FutureOr<Problem?> Function(NextQuestionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NextQuestionProvider._internal(
        (ref) => create(ref as NextQuestionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        trackId: trackId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Problem?> createElement() {
    return _NextQuestionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NextQuestionProvider && other.trackId == trackId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trackId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NextQuestionRef on AutoDisposeFutureProviderRef<Problem?> {
  /// The parameter `trackId` of this provider.
  String get trackId;
}

class _NextQuestionProviderElement
    extends AutoDisposeFutureProviderElement<Problem?>
    with NextQuestionRef {
  _NextQuestionProviderElement(super.provider);

  @override
  String get trackId => (origin as NextQuestionProvider).trackId;
}

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
