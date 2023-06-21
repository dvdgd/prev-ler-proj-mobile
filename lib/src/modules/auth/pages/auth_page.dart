import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_request_model.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();

    controller.addListener(_handleAuthStateChange);
  }

  @override
  void dispose() {
    controller.removeListener(_handleAuthStateChange);
    super.dispose();
  }

  void _handleAuthStateChange() {
    if (controller.state == AuthState.loggedIn) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else if (controller.state == AuthState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Bem vindo!',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Faça o login ou cadastre-se para continuar...',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              CustomPasswordField(
                controller: _passwordController,
                labelText: 'Senha',
              ),
              const SizedBox(height: 30),
              CustomAsyncLoadingButton(
                text: 'Login',
                action: () => controller.login(
                  AuthRequestModel(
                    _emailController.text,
                    _passwordController.text,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextButton('Registrar médico', '/register/medic'),
                    _buildTextButton('Registrar paciente', '/register/patient'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, String route) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Center(
        child: Text(text),
      ),
    );
  }
}
