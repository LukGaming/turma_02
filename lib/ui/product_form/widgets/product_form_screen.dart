import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:turma_02/domain/dtos/create_product_dto.dart';
import 'package:turma_02/ui/product_form/viewmodels/product_form_viewmodel.dart';

class ProductFormScreen extends StatefulWidget {
  final ProductFormViewmodel viewModel;
  const ProductFormScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final precoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.addProduct.addListener(_onCreateProduct);
  }

  void _onCreateProduct() {
    final command = widget.viewModel.addProduct;
    if (command.running) {
      showDialog(
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
      context.pop();
      if (command.completed) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("Produto criado com sucesso"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de produto."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: nomeController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Nome do produto"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha o nome do produto";
                  }
                  return null;
                },
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+[,]?\d{0,2}')),
                ],
                keyboardType: TextInputType.number,
                controller: precoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Preço do produto"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha o valor do produto";
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          widget.viewModel.addProduct.execute(
                            CreateProductDto(
                              name: nomeController.text,
                              price: double.parse(
                                precoController.text.replaceAll(",", "."),
                              ),
                              categoryId: "categoryId",
                            ),
                          );
                        }
                      },
                      child: Text("Salvar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    precoController.dispose();
    widget.viewModel.addProduct.removeListener(_onCreateProduct);
    super.dispose();
  }
}
