import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:turma_02/data/repositories/product/product_repository.dart';
import 'package:turma_02/data/repositories/product/product_repository_remote.dart';
import 'package:turma_02/data/services/api_client.dart';
import 'package:turma_02/domain/usecases/add_product_usecase.dart';
import 'package:turma_02/ui/product_form/viewmodels/product_form_viewmodel.dart';
import 'package:turma_02/ui/products/viewmodels/products_viewmodel.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(
      create: (context) => ApiClient("http://192.168.1.106:3000", Dio()),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ProductRepositoryRemote(context.read()) as ProductRepository,
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ProductsViewModel(context.read(), AddProductUsecase(context.read())),
    ),
    ChangeNotifierProvider(
      create: (context) =>
          ProductFormViewmodel(AddProductUsecase(context.read())),
    ),
  ];
}

List<SingleChildWidget> get providersDev {
  return [];
}
