import 'package:flutter/widgets.dart';
import 'package:turma_02/domain/usecases/add_product_usecase.dart';
import 'package:turma_02/utils/command.dart';

class ProductFormViewmodel extends ChangeNotifier {
  final AddProductUsecase _addProductUsecase;

  ProductFormViewmodel(
    this._addProductUsecase,
  );

  late final addProduct = Command1(_addProductUsecase.create);
}
