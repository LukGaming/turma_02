import 'package:flutter/material.dart';
import 'package:turma_02/data/repositories/product/product_repository.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/mock/products.dart';
import 'package:turma_02/utils/result.dart';

class ProductRepositoryDev extends ChangeNotifier implements ProductRepository {
  @override
  List<ProductModel> get products => _products;
  List<ProductModel> _products = generateProductList();

  @override
  Future<Result<ProductModel>> create(String nome) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final result = ProductModel(id: _products.length + 1, nome: nome);
      _products.add(result);
      return Result.ok(result);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(ProductModel product) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      _products.remove(product);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<ProductModel>>> get() async {
    await Future.delayed(Duration(seconds: 1));
    return Result.ok(_products);
  }
}
