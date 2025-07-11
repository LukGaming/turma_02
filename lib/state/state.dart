import 'package:turma_02/models/product.dart';

abstract class BaseState {}

class LoadingState extends BaseState {}

class SuccesState extends BaseState {
  final List<ProductModel> products;

  SuccesState({required this.products});
}

class ErrorState extends BaseState {
  final Exception exception;

  ErrorState({required this.exception});
}
