import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:turma_02/data/repositories/auth_repository/auth_repository.dart';
import 'package:turma_02/routing/routes.dart';
import 'package:turma_02/ui/login/widgets/login_screen.dart';
import 'package:turma_02/ui/product_form/widgets/product_form_screen.dart';
import 'package:turma_02/ui/products/widgets/products_screen.dart';
import 'package:turma_02/ui/register/viewmodels/register_viewmodel.dart';
import 'package:turma_02/ui/register/widgets/register_screen.dart';

GoRouter routerConfig(AuthRepository authRepository) {
  return GoRouter(
    refreshListenable: authRepository,
    redirect: (context, state) async {
      await authRepository.isLoggedIn();
      final isLoggedIn = authRepository.user != null;
      final isLoggingIn = state.matchedLocation == Routes.login;
      final isRegistering = state.matchedLocation == Routes.register;

      if (isRegistering) {
        return Routes.register;
      }

      if (!isLoggedIn) {
        return Routes.login;
      }

      if (isLoggingIn) {
        return Routes.home;
      }

      return null;
    },
    initialLocation: Routes.login,
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
      GoRoute(
        path: Routes.login,
        builder: (context, state) => LoginScreen(
          viewModel: context.read(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) {
          return RegisterScreen(
            viewModel: RegisterViewmodel(context.read()),
          );
        },
      ),
    ],
  );
}
