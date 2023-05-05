import 'package:flutter/material.dart';
import 'package:menu_lateral/widgets/custom_date_picker.dart';
import 'package:menu_lateral/widgets/custom_dropdown_button.dart';

import '../../main.dart';
import '../../service/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_field_widget.dart';

class RegisterMedicPage extends StatefulWidget {
  const RegisterMedicPage({super.key});

  @override
  State<RegisterMedicPage> createState() => _RegisterMedicPageState();
}

class _RegisterMedicPageState extends State<RegisterMedicPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _numeroCrmController = TextEditingController();
  final _ufCrmController = TextEditingController();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const Text(
                'Médico',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Text(
                  "Cadastre-se como médico em nosso aplicativo para criar conteúdos confiáveis e exercícios sobre Lesão por Esforço Repetitivo (LER). Informe seu CRM e estado de origem para garantir a segurança das informações.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              TextFieldWidget(
                controller: _passwordController,
                hintText: 'Senha',
                prefixIcon: const Icon(Icons.password_outlined),
              ),
              TextFieldWidget(
                controller: _nomeController,
                hintText: 'Nome',
                prefixIcon: const Icon(Icons.abc),
              ),
              CustomDatePicker(
                context: context,
                controller: _dataNascimentoController,
                hintText: 'Data de Nascimento',
                prefixIcon: const Icon(Icons.date_range_outlined),
              ),
              TextFieldWidget(
                controller: _numeroCrmController,
                hintText: 'Numero CRM',
                prefixIcon: const Icon(Icons.numbers_outlined),
              ),
              CustomDropdownButton(controller: _ufCrmController, list: const [
                'AC',
                'AL',
                'AP',
                'AM',
                'BA',
                'CE',
                'DF',
                'ES',
                'GO',
                'MA',
                'MT',
                'MS',
                'MG',
                'PA',
                'PB',
                'PR',
                'PE',
                'PI',
                'RJ',
                'RN',
                'RS',
                'RO',
                'RR',
                'SC',
                'SP',
                'SE',
                'TO',
              ]),
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
