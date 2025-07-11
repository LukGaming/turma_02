import 'package:turma_02/models/product.dart';

List<ProductModel> generateProductList() {
  return List.generate(
    20,
    (index) => ProductModel(id: index, nome: "Produto $index"),
  );
}
