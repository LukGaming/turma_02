import 'dart:math';

import 'package:turma_02/domain/models/product_model.dart';

List<ProductModel> generateProductList() {
  return List.generate(
    20,
    (index) => ProductModel(id: index.toString(), name: "Produto $index", price: Random().nextInt(1000).toDouble(), categoryId: Random().nextInt(1000).toString()),
  );
}
