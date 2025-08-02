import 'package:flutter/material.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/ui/products/viewmodels/products_viewmodel.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductsViewModel viewModel;
  final ProductModel product;
  const ProductCardWidget({
    super.key,
    required this.viewModel,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(product.id.toString()),
        title: Text(product.name),
        trailing: IconButton(
          onPressed: () => viewModel.removeProduct.execute(product),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
