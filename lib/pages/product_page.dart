import 'package:flutter/material.dart';
import 'package:turma_02/controllers/product_controller.dart';
import 'package:turma_02/state/state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController controller = ProductController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                if (value is LoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (value is SuccesState) {
                  final productsState = value;
                  return ListView.builder(
                    itemCount: productsState.products.length,
                    itemBuilder: (context, index) {
                      final product = productsState.products[index];
                      return ListTile(
                        leading: Text(product.id.toString()),
                        title: Text(product.nome),
                        trailing: IconButton(
                          onPressed: () => controller.removeProduct(product),
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                }
                if (value is ErrorState) {
                  return Center(
                    child: Text("Ocorreu um erro"),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addProduct,
        child: Icon(Icons.add),
      ),
    );
  }
}
