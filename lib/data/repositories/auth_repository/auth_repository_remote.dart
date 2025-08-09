import 'package:flutter/widgets.dart';
import 'package:turma_02/data/repositories/auth_repository/auth_repository.dart';
import 'package:turma_02/data/services/auth_api.dart';
import 'package:turma_02/data/services/models/user/login_response.dart';
import 'package:turma_02/data/services/shared_preferences_service.dart';
import 'package:turma_02/domain/dtos/login_dto.dart';
import 'package:turma_02/domain/models/user.dart';
import 'package:turma_02/utils/result.dart';

class AuthRepositoryRemote extends ChangeNotifier implements AuthRepository {
  final AuthApi _authApi;
  final SharedPreferencesService _preferecesService;

  AuthRepositoryRemote({
    required AuthApi authApi,
    required SharedPreferencesService preferencesService,
  })  : _authApi = authApi,
        _preferecesService = preferencesService;

  @override
  Future<Result<User>> login(LoginDto params) async {
    try {
      final result = await _authApi.login(params);

      switch (result) {
        case Ok<LoginResponse>():
          final loginResponse = result.value;
          final user = User(
            id: loginResponse.id,
            nome: loginResponse.name,
            email: loginResponse.email,
            token: loginResponse.token,
          );
          _user = user;
          await _preferecesService.saveUser(user);
          return Result.ok(user);
        case Error():
          _user = null;
          return Result.error(result.error);
      }
    } on Exception catch (error) {
      _user = null;
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  User? get user => _user;
  User? _user;

  @override
  Future<Result<User>> isLoggedIn() async {
    try {
      final result = await _preferecesService.getUser();

      switch (result) {
        case Ok<User?>():
          if (result.value == null) {
            return Result.error(Exception("Erro ao buscar usuário"));
          }
          _user = result.value;
          return Result.ok(result.value!);
        case Error():
          return Result.error(result.error);
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      _user = null;
      await _preferecesService.clear();
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
