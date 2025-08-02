import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:turma_02/data/repositories/product/product_repository_remote.dart';
import 'package:turma_02/data/services/api_client.dart';
import 'package:turma_02/routing/routes.dart';
import 'package:turma_02/ui/product_form/viewmodels/product_form_viewmodel.dart';
import 'package:turma_02/ui/product_form/widgets/product_form_screen.dart';
import 'package:turma_02/ui/products/widgets/products_screen.dart';

GoRouter routerConfig() {
  return GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return ProductScreen(viewModel: context.read());
        },
      ),
      GoRoute(
        path: Routes.productForm,
        builder: (context, state) {
          return ProductFormScreen(
            viewModel: context.read(),
          );
        },
      ),
    ],
  );
}
