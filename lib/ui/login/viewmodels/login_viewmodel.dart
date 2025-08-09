import 'package:turma_02/data/repositories/auth_repository/auth_repository.dart';
import 'package:turma_02/domain/dtos/login_dto.dart';
import 'package:turma_02/domain/models/user.dart';
import 'package:turma_02/utils/command.dart';
import 'package:turma_02/utils/result.dart';

class LoginViewmodel {
  final AuthRepository _authRepository;

  late final login = Command1(_login);

  LoginViewmodel(this._authRepository);

  Future<Result<User>> _login(LoginDto params) async {
    return _authRepository.login(params);
  }
}
