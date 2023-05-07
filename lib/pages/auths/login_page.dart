import 'package:flutter/material.dart';
import 'package:menu_lateral/pages/auths/register_medic_page.dart';
import 'package:menu_lateral/pages/auths/register_patient_page.dart';
import 'package:menu_lateral/widgets/custom_async_loading_button.dart';
import 'package:menu_lateral/widgets/custom_password_field.dart';

import '../../main.dart';
import '../../service/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleLogin(context) async {
    var email = _emailController.text;
    var password = _passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      throw Exception("Email e senha devem ser preenchidos");
    }

    try {
      await AuthService().login(email, password);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } catch (e) {
      print("Erro " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Column _buildContent(BuildContext context) {
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
            await _handleLogin(context);
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
