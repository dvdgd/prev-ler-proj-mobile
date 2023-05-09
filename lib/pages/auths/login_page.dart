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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: _buildContent(context, ref),
          ),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          'Bem vindo!',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Faça o login ou cadastre-se para continuar...',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _emailController,
          hintText: 'Email',
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        CustomPasswordField(
          controller: _passwordController,
          hintText: 'Senha',
        ),
        const SizedBox(height: 20),
        CustomAsyncLoadingButton(
          text: 'Login',
          action: () async {
            await _handleLogin(context, ref);
          },
        ),
        const SizedBox(height: 20),
        _buildSeparator(),
        const SizedBox(height: 15.0),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterMedicPage(),
            ),
          ),
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.transparent,
            child: const Center(
              child: Text('Cadastrar-se como Médico'),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPatientPage(),
            ),
          ),
          child: Container(
            height: 50,
            width: double.infinity,
            color: Colors.transparent,
            child: const Center(
              child: Text('Cadastrar-se como Paciente'),
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: const [
          Expanded(
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              'Ou',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
