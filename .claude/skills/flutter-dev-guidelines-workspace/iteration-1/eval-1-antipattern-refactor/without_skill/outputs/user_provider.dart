import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

enum UserLoadingStatus { idle, loading, success, failure }

class UserState {
  const UserState({
    this.userName,
    this.status = UserLoadingStatus.idle,
    this.errorMessage,
  });

  final String? userName;
  final UserLoadingStatus status;
  final String? errorMessage;

  bool get isLoading => status == UserLoadingStatus.loading;
  bool get hasError => status == UserLoadingStatus.failure;

  UserState copyWith({
    String? userName,
    UserLoadingStatus? status,
    String? errorMessage,
  }) {
    return UserState(
      userName: userName ?? this.userName,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UserProvider extends ChangeNotifier {
  UserProvider({required Dio dio}) : _dio = dio;

  final Dio _dio;

  UserState _state = const UserState();
  UserState get state => _state;

  Future<void> loadUser() async {
    if (_state.isLoading) return;

    _state = _state.copyWith(status: UserLoadingStatus.loading);
    notifyListeners();

    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://api.example.com/user',
      );

      final data = response.data;
      final name = data?['name'] as String?;

      _state = _state.copyWith(
        userName: name,
        status: UserLoadingStatus.success,
        errorMessage: null,
      );
    } on DioException catch (e) {
      _state = _state.copyWith(
        status: UserLoadingStatus.failure,
        errorMessage: e.message ?? 'Failed to load user.',
      );
    } catch (e) {
      _state = _state.copyWith(
        status: UserLoadingStatus.failure,
        errorMessage: 'An unexpected error occurred.',
      );
    } finally {
      notifyListeners();
    }
  }
}
