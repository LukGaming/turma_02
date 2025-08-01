import 'package:flutter/material.dart';
import 'package:turma_02/data/repositories/product/product_repository.dart';
import 'package:turma_02/domain/usecases/add_product_usecase.dart';
import 'package:turma_02/mock/products.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/command.dart';
import 'package:turma_02/utils/result.dart';

class ProductsViewModel extends ChangeNotifier {
  final ProductRepository _productRepository;
  final AddProductUsecase _addProductUsecase;
  ProductsViewModel(this._productRepository, this._addProductUsecase) {
    _productRepository.addListener(() {
      notifyListeners();
    });
  }

  List<ProductModel> get products => _productRepository.products;

  late final load = Command0(_load);
  late final addProduct = Command1(_addProductUsecase.create);
  late final removeProduct = Command1(_removeProduct);
  late final filteredProductsCommand = Command0(_filteredProducts);
  late final filterByCategory = Command0(_filterByCategory);

  List<ProductModel> filteredProducts = [];

  Future<Result<List<ProductModel>>> _load() async {
    return await _productRepository.get();
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

  Future<Result<void>> _removeProduct(ProductModel product) async {
    return await _productRepository.delete(product);
  }
}
