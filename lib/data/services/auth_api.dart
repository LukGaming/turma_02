import 'package:dio/dio.dart';
import 'package:turma_02/data/services/models/user/login_response.dart';
import 'package:turma_02/domain/dtos/login_dto.dart';
import 'package:turma_02/utils/result.dart';

class AuthApi {
  final String _authApiUrl;
  final Dio _dio;

  const AuthApi({required String apiUrl, required Dio dio})
      : _authApiUrl = apiUrl,
        _dio = dio;

  Future<void> setup() async {
    _dio.options.baseUrl = _authApiUrl;
  }

  Future<Result<LoginResponse>> login(LoginDto params) async {
    await setup();

    // try {
    final response = await _dio.post("/auth/login", data: {
      "email": params.email,
      "password": params.password,
    });

    if (response.statusCode == 200) {
      return Result.ok(LoginResponse.fromJson(response.data["user"]));
    }
    return Result.error(Exception("Invalid Status Code"));
    // } on Exception catch (error) {
    //   return Result.error(error);
    // }
  }
}
