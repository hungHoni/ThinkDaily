import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../data/models/user_model.dart';
import '../data/user_repository.dart';

part 'user_provider.g.dart';

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

/// Provides the [UserRepository] implementation via Riverpod DI.
///
/// Widgets and notifiers never instantiate repositories directly — they always
/// read this provider. Swap the implementation here for testing or alternate
/// data sources without touching any widget.
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final dio = ref.read(dioClientProvider);
  return UserRepositoryImpl(UserRemoteSource(dio));
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

/// Manages the async state for the currently authenticated user.
///
/// The [build] method triggers the initial fetch. Callers can trigger a
/// manual refresh via [refresh], which invalidates the provider and
/// re-runs [build].
///
/// All state is [AsyncValue<UserModel>], so the UI always has a typed path
/// for data, loading, and error — no silent failures.
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<UserModel> build() {
    return ref.read(userRepositoryProvider).getUser();
  }

  /// Forces a re-fetch of the user from the remote source.
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
