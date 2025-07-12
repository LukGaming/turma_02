import 'package:flutter/material.dart';
import 'package:turma_02/mock/products.dart';
import 'package:turma_02/domain/models/product.dart';
import 'package:turma_02/utils/command.dart';
import 'package:turma_02/utils/result.dart';

class ProductsViewModel extends ChangeNotifier {
  ProductsViewModel();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  late final load = Command0(_load);
  late final addProduct = Command1(_addProduct);
  late final removeProduct = Command1(_removeProduct);
  late final filteredProductsCommand = Command0(_filteredProducts);
  late final filterByCategory = Command0(_filterByCategory);

  List<ProductModel> filteredProducts = [];

  Future<Result<List<ProductModel>>> _load() async {
    await Future.delayed(Duration(seconds: 1));
    final result = generateProductList();
    _products = result;
    return Result.ok(result);
  }

  Future<Result<List<ProductModel>>> _filterByCategory() async {
    return Result.ok([]);
  }

  Future<Result<List<ProductModel>>> _filteredProducts() async {
    await Future.delayed(Duration(seconds: 2));
    final result = generateProductList();
    filteredProducts = result;
    return Result.ok(filteredProducts);
  }

  Future<Result<ProductModel>> _addProduct(String nome) async {
    await Future.delayed(Duration(seconds: 3));
    final result = ProductModel(id: _products.length + 1, nome: nome);
    _products.add(result);
    notifyListeners();
    return Result.ok(result);
  }

  Future<Result<void>> _removeProduct(ProductModel product) async {
    await Future.delayed(Duration(seconds: 2));
    _products.remove(product);
    notifyListeners();
    return Result.ok(null);
  }
}
