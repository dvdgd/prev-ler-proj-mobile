import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_request_model.dart';
import 'package:prev_ler/src/shared/ui/components/dark_mode_button.dart';
import 'package:prev_ler/src/shared/ui/components/password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      Navigator.of(Routes.navigatorKey.currentContext!)
          .pushReplacementNamed('/home');
    } else if (controller.state == AuthState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  Future<void> _makeLogin() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final loginModel = AuthRequestModel(
      _emailController.text,
      _passwordController.text,
    );
    await controller.login(loginModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: const [
          DarkModeButton(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                MyTextFormField(
                  controller: _emailController,
                  validator: (text) =>
                      text == null || text.isEmpty ? "Preencha o email." : null,
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  textInputType: TextInputType.emailAddress,
                ),
                PasswordField(
                  validator: (text) =>
                      text == null || text.isEmpty ? "Digite a senha." : null,
                  controller: _passwordController,
                  labelText: 'Senha',
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MyFilledButton(
                    text: 'Login',
                    onTap: _makeLogin,
                  ),
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextButton('Registrar médico', '/register/medic'),
                      _buildTextButton(
                          'Registrar paciente', '/register/patient'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, String route) {
    return TextButton(
      onPressed: () {
        Navigator.of(Routes.navigatorKey.currentContext!).pushNamed(route);
      },
      child: Center(
        child: Text(text),
      ),
    );
  }
}
