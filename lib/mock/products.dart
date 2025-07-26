import 'package:turma_02/domain/models/product_model.dart';

List<ProductModel> generateProductList() {
  return List.generate(
    20,
    (index) => ProductModel(id: index, nome: "Produto $index"),
  );
}
