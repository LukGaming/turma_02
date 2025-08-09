import 'package:flutter/widgets.dart';
import 'package:turma_02/domain/dtos/login_dto.dart';
import 'package:turma_02/domain/models/user.dart';
import 'package:turma_02/utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  User? get user;
  Future<Result<User>> login(LoginDto params);
  Future<Result<User>> isLoggedIn();
  Future<Result<void>> logout();
}
