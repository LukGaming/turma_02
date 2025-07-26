import 'package:dio/dio.dart';
import 'package:turma_02/data/services/models/products/create_product_request.dart';
import 'package:turma_02/data/services/models/products/product_api_model.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/result.dart';

class ApiClient {
  final String _apiUrl;
  final Dio _dio;

  const ApiClient(this._apiUrl, this._dio);

  Future<void> _setupHeaders() async {
    _dio.options.baseUrl = _apiUrl;
  }

  Future<Result<List<ProductApiModel>>> get() async {
    try {
      await _setupHeaders();
      final response = await _dio.get("/products");

      if (response.statusCode == 200) {
        final products =
            (response.data as List).map((e) => ProductApiModel.fromJson(e)).toList();
        return Result.ok(products);
      }

      return Result.error(Exception("Invalid status code"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<ProductApiModel>> create(CreateProductRequest product) async {
    try {
      await _setupHeaders();
      final response = await _dio.post("/products", data: product.toJson());

      if (response.statusCode == 201) {
        final product = ProductApiModel.fromJson(response.data);
        return Result.ok(product);
      }
      return Result.error(Exception("Invalid status code"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> delete(ProductModel product) async {
    try {
      await _setupHeaders();
      final response = await _dio.delete("/products/${product.id}");
      if (response.statusCode == 200) {
        return Result.ok(null);
      }
      return Result.error(Exception("Invalid status code"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
