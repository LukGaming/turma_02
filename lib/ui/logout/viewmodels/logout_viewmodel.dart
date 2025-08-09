import 'package:turma_02/data/repositories/auth_repository/auth_repository.dart';
import 'package:turma_02/utils/command.dart';
import 'package:turma_02/utils/result.dart';

class LogoutViewmodel {
  final AuthRepository _authRepository;

  LogoutViewmodel(this._authRepository);

  late final logout = Command0(_logout);

  Future<Result<void>> _logout() async {
    return await _authRepository.logout();
  }
}
