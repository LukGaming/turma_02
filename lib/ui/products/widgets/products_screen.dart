import 'package:flutter/material.dart';
import 'package:turma_02/domain/dtos/create_product_dto.dart';
import 'package:turma_02/ui/products/viewmodels/products_viewmodel.dart';

class ProductScreen extends StatefulWidget {
  final ProductsViewModel viewModel;
  const ProductScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.load.execute();
    widget.viewModel.addProduct.addListener(_onCreateProduct);
    widget.viewModel.removeProduct.addListener(_onRemoveProduct);
  }

  void _onCreateProduct() {
    final command = widget.viewModel.addProduct;
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
    final command = widget.viewModel.removeProduct;
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
      body: ListenableBuilder(
        listenable: widget.viewModel.load,
        builder: (context, child) {
          final command = widget.viewModel.load;
          if (command.running) {
            return Center(child: CircularProgressIndicator());
          }
          if (command.error) {
            return Center(
              child: Text("Ocorreu um erro"),
            );
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return ListView.builder(
              itemCount: widget.viewModel.products.length,
              itemBuilder: (context, index) {
                final product = widget.viewModel.products[index];
                return ListTile(
                  leading: Text(product.id.toString()),
                  title: Text(product.name),
                  trailing: IconButton(
                    onPressed: () =>
                        widget.viewModel.removeProduct.execute(product),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.viewModel.addProduct.execute(CreateProductDto(name: "name", price: 10.0, categoryId: "category2"));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    widget.viewModel.addProduct.removeListener(_onCreateProduct);
    widget.viewModel.removeProduct.removeListener(_onRemoveProduct);
    super.dispose();
  }
}

class FilteredProductsWidget extends StatelessWidget {
  const FilteredProductsWidget({
    super.key,
    required this.viewModel,
  });

  final ProductsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (child, context) {
        return ListView.builder(
          itemCount: viewModel.filteredProducts.length,
          itemBuilder: (context, index) {
            final product = viewModel.filteredProducts[index];
            return ListTile(
              leading: Text(product.id.toString()),
              title: Text(product.name),
              trailing: IconButton(
                onPressed: () => viewModel.removeProduct.execute(product),
                icon: Icon(Icons.delete),
              ),
            );
          },
        );
      },
    );
  }
}
