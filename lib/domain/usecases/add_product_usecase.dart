import 'package:turma_02/data/repositories/product/product_repository.dart';
import 'package:turma_02/domain/dtos/create_product_dto.dart';
import 'package:turma_02/domain/models/product_model.dart';
import 'package:turma_02/utils/result.dart';

class AddProductUsecase {
  final ProductRepository _productRepository;
  AddProductUsecase(this._productRepository);

  Future<Result<ProductModel>> create(CreateProductDto product) async {
    return await _productRepository.create(product);
  }
}
