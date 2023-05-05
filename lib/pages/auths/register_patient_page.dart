import 'package:flutter/material.dart';
import 'package:menu_lateral/widgets/custom_password_field.dart';

import '../../main.dart';
import '../../service/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_picker.dart';
import '../../widgets/custom_text_field.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({super.key});

  @override
  State<RegisterPatientPage> createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _ocupacaoController = TextEditingController();

  Future<void> _handleRegister(context) async {
    var email = _emailController.text;
    var password = _passwordController.text;

    if (email.isEmpty && password.isEmpty) {
      throw Exception("Email e senha devem ser preenchidos");
    }

    try {
      await AuthService().register(email, password);

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const Text(
                'Paciente',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Text(
                  "Previna as Lesões por Esforço Repetitivo (LER) com exercícios e gestão de rotinas. Tenha acesso a conteúdos exclusivos desenvolvidos por médicos licenciados para melhorar sua saúde e bem-estar.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                textInputType: TextInputType.emailAddress,
                hintText: 'Email',
                maxLength: 50,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              CustomPasswordField(
                controller: _passwordController,
                maxLength: 25,
                hintText: 'Senha',
              ),
              CustomTextField(
                controller: _nomeController,
                hintText: 'Nome',
                maxLength: 50,
                prefixIcon: const Icon(Icons.text_fields_outlined),
              ),
              CustomDatePicker(
                context: context,
                controller: _dataNascimentoController,
                hintText: 'Data de Nascimento',
                prefixIcon: const Icon(Icons.date_range_outlined),
              ),
              CustomTextField(
                controller: _ocupacaoController,
                hintText: 'Ocupação',
                maxLength: 25,
                prefixIcon: const Icon(Icons.work_history_outlined),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Cadastrar-se',
                onTap: () async {
                  await _handleRegister(context);
                },
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
