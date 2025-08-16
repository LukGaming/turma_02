import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turma_02/domain/dtos/register_user_dto.dart';
import 'package:turma_02/routing/routes.dart';
import 'package:turma_02/ui/register/viewmodels/register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterViewmodel viewModel;
  const RegisterScreen({super.key, required this.viewModel});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordObscure = true;

  void _changePasswordVisibility() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.viewModel.register.addListener(_onRegister);
  }

  void _onRegister() {
    final command = widget.viewModel.register;

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
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: IntrinsicHeight(
                child: Column(
                  spacing: 16,
                  children: [
                    Icon(Icons.check),
                    Text("Cadastro efetuado com sucesso."),
                    ElevatedButton(
                      onPressed: () {
                        context.go(Routes.login);
                      },
                      child: Text("Continuar para login."),
                    )
                  ],
                ),
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Ocorreu um erro ao efetuar login"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha o nome.";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Nome")),
                controller: _nameController,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, preencha o e-mail.";
                  }
                  String emailRegex =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$';
                  RegExp regExp = RegExp(emailRegex);

                  if (!regExp.hasMatch(value.trim())) {
                    return "Por favor, digite um e-mail válido.";
                  }

                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text("E-mail")),
                controller: _emailController,
              ),
              TextFormField(
                obscureText: _isPasswordObscure,
                decoration: InputDecoration(
                  label: Text("Senha"),
                  suffixIcon: IconButton(
                    onPressed: _changePasswordVisibility,
                    icon: Icon(
                      _isPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return "A senha precisa conter pelo menos 8 caracteres.";
                  }
                  return null;
                },
                controller: _passwordController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    final registerDto = RegisterUserDto(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    widget.viewModel.register.execute(registerDto);
                  }
                },
                child: Text("Efetuar cadastro"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.viewModel.register.removeListener(_onRegister);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
