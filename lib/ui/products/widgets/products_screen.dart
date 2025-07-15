import 'package:flutter/material.dart';
import 'package:turma_02/ui/products/viewmodels/products_viewmodel.dart';
import 'package:turma_02/utils/command_builder.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductsViewModel controller = ProductsViewModel();

  @override
  void initState() {
    super.initState();
    controller.load.execute();
    controller.filteredProductsCommand.execute();
    controller.addProduct.addListener(_onCreateProduct);
    controller.removeProduct.addListener(_onRemoveProduct);
  }

  void _onCreateProduct() {
    final command = controller.addProduct;
    if (command.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: IntrinsicHeight(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      if (command.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Produto criado com sucesso.")),
        );
      }
      if (command.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Ocorreu um erro ao criar produto."),
          ),
        );
      }
    }
  }

  void _onRemoveProduct() {
    final command = controller.removeProduct;
    if (command.running) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: IntrinsicHeight(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).clearSnackBars();
      if (command.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Produto removido com sucesso.")),
        );
      }
      if (command.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Ocorreu um erro ao remover produto."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CommandBuilder(
              command: controller.filteredProductsCommand,
              onRunning: () {
                return Center(child: Text("Carregando..."));
              },
              onError: (error) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              child: (result) {
                return FilteredProductsWidget(
                  controller: controller,
                );
              },
            ),
          ),
          // Expanded(
          //   child: ListenableBuilder(
          //     listenable: controller.filteredProductsCommand,
          //     builder: (context, child) {
          //       final command = controller.filteredProductsCommand;
          //       if (command.running) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       if (command.error) {
          //         return Center(
          //           child: Text("Ocorreu um erro"),
          //         );
          //       }
          //       return child!;
          //     },
          //     child: ListenableBuilder(
          //       listenable: controller,
          //       builder: (context, child) {
          //         return ListView.builder(
          //           itemCount: controller.filteredProducts.length,
          //           itemBuilder: (context, index) {
          //             final product = controller.filteredProducts[index];
          //             return ListTile(
          //               leading: Text(product.id.toString()),
          //               title: Text(product.nome),
          //               trailing: IconButton(
          //                 onPressed: () =>
          //                     controller.removeProduct.execute(product),
          //                 icon: Icon(Icons.delete),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
          // Expanded(
          //   child: ListenableBuilder(
          //     listenable: controller.load,
          //     builder: (context, child) {
          //       final command = controller.load;
          //       if (command.running) {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //       if (command.error) {
          //         return Center(
          //           child: Text("Ocorreu um erro"),
          //         );
          //       }
          //       return child!;
          //     },
          //     child: ListenableBuilder(
          //       listenable: controller,
          //       builder: (context, child) {
          //         return ListView.builder(
          //           itemCount: controller.products.length,
          //           itemBuilder: (context, index) {
          //             final product = controller.products[index];
          //             return ListTile(
          //               leading: Text(product.id.toString()),
          //               title: Text(product.nome),
          //               trailing: IconButton(
          //                 onPressed: () =>
          //                     controller.removeProduct.execute(product),
          //                 icon: Icon(Icons.delete),
          //               ),
          //             );
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addProduct.execute("Novo Produto");
          // controller.addProduct
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    controller.addProduct.removeListener(_onCreateProduct);
    controller.removeProduct.removeListener(_onRemoveProduct);
    super.dispose();
  }
}

class FilteredProductsWidget extends StatelessWidget {
  const FilteredProductsWidget({
    super.key,
    required this.controller,
  });

  final ProductsViewModel controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (child, context) {
        return ListView.builder(
          itemCount: controller.filteredProducts.length,
          itemBuilder: (context, index) {
            final product = controller.filteredProducts[index];
            return ListTile(
              leading: Text(product.id.toString()),
              title: Text(product.nome),
              trailing: IconButton(
                onPressed: () => controller.removeProduct.execute(product),
                icon: Icon(Icons.delete),
              ),
            );
          },
        );
      },
    );
  }
}
