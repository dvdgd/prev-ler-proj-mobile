import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/auths/register_medic_page.dart';
import 'package:prev_ler/pages/main_page.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/pages/auths/register_patient_page.dart';
import 'package:prev_ler/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/widgets/custom_password_field.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    var email = _emailController.text;
    var password = _passwordController.text;

    try {
      if (email.isEmpty && password.isEmpty) {
        throw Exception("Email e senha devem ser preenchidos");
      }

      final authService = ref.read(authProvider);
      await authService.login(email, password);

      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MainPage(),
        ));
      } else {
        throw Exception('Nos desculpe, ocorreu um erro inesperado do sistema');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(message: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: _buildContent(context, ref),
          ),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context, WidgetRef ref) {
    return Column(
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
          action: () async {
            await _handleLogin(context, ref);
          },
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterMedicPage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text('Registrar médico'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPatientPage(),
                    ),
                  );
                },
                child: const Center(
                  child: Text('Registar paciente'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
