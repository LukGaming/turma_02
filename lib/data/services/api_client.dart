import 'package:dio/dio.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/result.dart';

class ApiClient {
  final String _apiUrl;
  final Dio _dio;

  const ApiClient(this._apiUrl, this._dio);

  Future<Result<List<ProductModel>>> get() async {
    return Result.ok([]);
  }

  Future<Result<ProductModel>> create(String nome) async {}

  Future<Result<void>> delete(ProductModel product) async {}
}
