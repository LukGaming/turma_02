import 'package:flutter/material.dart';
import 'package:turma_02/domain/dtos/create_product_dto.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/result.dart';

abstract class ProductRepository extends ChangeNotifier {
  List<ProductModel> get products;
  Future<Result<List<ProductModel>>> get();
  Future<Result<ProductModel>> create(CreateProductDto product);
  Future<Result<void>> delete(ProductModel product);
}
