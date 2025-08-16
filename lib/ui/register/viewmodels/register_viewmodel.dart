import 'package:turma_02/data/repositories/auth_repository/auth_repository.dart';
import 'package:turma_02/domain/dtos/register_user_dto.dart';
import 'package:turma_02/utils/command.dart';
import 'package:turma_02/utils/result.dart';

class RegisterViewmodel {
  final AuthRepository _authRepository;

  RegisterViewmodel(this._authRepository);

  late final register = Command1(_register);

  Future<Result<void>> _register(RegisterUserDto user) async {
    return await _authRepository.register(user);
  }
}
