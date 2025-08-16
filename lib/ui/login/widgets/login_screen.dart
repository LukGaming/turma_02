import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turma_02/domain/dtos/login_dto.dart';
import 'package:turma_02/routing/routes.dart';
import 'package:turma_02/ui/login/viewmodels/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  final LoginViewmodel viewModel;
  const LoginScreen({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.viewModel.login.addListener(_onLogin);
  }

  void _onLogin() {
    final command = widget.viewModel.login;
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
        context.go(Routes.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Ocorreu um erro ao efetuar login")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text("E-mail"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha o email.";
                  }
                  if (!value.contains("@")) {
                    return "Por favor, preencha um email válido.";
                  }
                  return null;
                },
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  label: Text("Senha"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha a senha.";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.push(Routes.register);
                    },
                    child: Text("Cadastrar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        final loginDto =
                            LoginDto(email: email, password: password);
                        widget.viewModel.login.execute(loginDto);
                      }
                    },
                    child: Text("Efetuar login"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.viewModel.login.removeListener(_onLogin);
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
