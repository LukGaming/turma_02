import 'package:flutter/material.dart';
import 'package:turma_02/mock/products.dart';
import 'package:turma_02/models/product.dart';
import 'package:turma_02/state/state.dart';

class ProductController extends ValueNotifier<BaseState> {
  ProductController() : super(LoadingState());

  final ValueNotifier<BaseState> onAddProduct = ValueNotifier(LoadingState());

  void init() async {
    value = LoadingState();

    await Future.delayed(Duration(seconds: 2));

    value = SuccesState(products: generateProductList());
    // value = ErrorState(
    //     exception: Exception("Ocorreu um erro ao carregar produtos"));
  }

  void addProduct() {
    // final index = value.length + 1;

    // final product = Product(id: index, nome: "Produto $index");

    onAddProduct.value = LoadingState();
    notifyListeners();

    if (value is SuccesState) {
      final state = value as SuccesState;
      // value =
      final index = state.products.length + 1;
      state.products.add(ProductModel(id: index, nome: "Product $index"));
    }

    // value.add(product);

    notifyListeners();
  }

  void removeProduct(ProductModel product) {
    // value.remove(product);
    notifyListeners();
  }
}
