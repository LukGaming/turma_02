import 'package:flutter/material.dart';
import 'package:turma_02/data/repositories/product/product_repository.dart';
import 'package:turma_02/data/services/api_client.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/result.dart';

class ProductRepositoryRemote extends ChangeNotifier
    implements ProductRepository {
  final ApiClient _apiClient;

  @override
  List<ProductModel> get products => _products;
  List<ProductModel> _products = [];

  ProductRepositoryRemote(this._apiClient);

  @override
  Future<Result<ProductModel>> create(String nome) async {
    try {
      final result = await _apiClient.create(nome);
      switch (result) {
        case Ok<ProductModel>():
          _products.add(result.value);
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(ProductModel product) async {
    try {
      final result = await _apiClient.delete(product);
      switch (result) {
        case Ok<void>():
          _products.remove(product);
          return Result.ok(null);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<ProductModel>>> get() async {
    return await _apiClient.get();
  }
}
