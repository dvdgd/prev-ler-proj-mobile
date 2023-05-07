import 'package:flutter/material.dart';
import 'package:menu_lateral/service/auth_service.dart';
import 'package:menu_lateral/widgets/custom_alert_dialog.dart';
import 'package:menu_lateral/widgets/custom_async_loading_button.dart';
import 'package:menu_lateral/widgets/custom_date_picker.dart';
import 'package:menu_lateral/widgets/custom_dropdown_button.dart';
import 'package:menu_lateral/entities/user.dart';
import 'package:menu_lateral/widgets/custom_password_field.dart';
import 'package:menu_lateral/widgets/custom_text_field.dart';

class RegisterMedicPage extends StatefulWidget {
  const RegisterMedicPage({super.key});

  @override
  State<RegisterMedicPage> createState() => _RegisterMedicPageState();
}

class _RegisterMedicPageState extends State<RegisterMedicPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _crmNumberController = TextEditingController();
  final _crmStateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();

  User _validateForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final bornDate = _selectedBornDateController.text;
    final crmNumber = _crmNumberController.text;
    final crmState = _crmStateController.text;

    if (email.isEmpty) {
      throw Exception('Email não pode ser vazio');
    }
    if (password.isEmpty) {
      throw Exception('A senha é obrigatória');
    }
    if (name.isEmpty) {
      throw Exception('Por favor, preencha seu nome');
    }
    if (bornDate.isEmpty) {
      throw Exception('Selecione uma data de nascimento');
    }
    if (crmNumber.isEmpty) {
      throw Exception('Email não pode ser vazio');
    }
    if (crmState.isEmpty) {
      throw Exception('Email não pode ser vazio');
    }

    return User(
      email: email,
      password: password,
      medic: Medic(
        name: name,
        bornDate: DateTime.parse(bornDate),
        crmNumber: crmNumber,
        crmState: crmState,
      ),
    );
  }

  Future<void> _handleRegister(context) async {
    final currentContext = context;
    try {
      final user = _validateForm();
      await AuthService().register(user);
      await showDialog(
        context: currentContext,
        builder: (context) => const CustomAlertDialog(message: 'Sucesso!'),
      );
      Navigator.of(currentContext).pop();
    } catch (e) {
      await showDialog(
        context: currentContext,
        builder: (context) => CustomAlertDialog(message: e.toString()),
      );
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
                  "Informe seu CRM e estado de origem para garantir a segurança das informações.",
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
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              CustomPasswordField(
                controller: _passwordController,
                hintText: 'Senha',
              ),
              CustomTextField(
                controller: _nameController,
                hintText: 'Nome',
                prefixIcon: const Icon(Icons.text_fields_outlined),
              ),
              CustomDatePicker(
                context: context,
                controller: _bornDateController,
                selectedDate: _selectedBornDateController,
                hintText: 'Data de Nascimento',
                prefixIcon: const Icon(Icons.date_range_outlined),
              ),
              CustomTextField(
                controller: _crmNumberController,
                hintText: 'Numero CRM',
                textInputType: TextInputType.number,
                prefixIcon: const Icon(Icons.numbers_outlined),
              ),
              CustomDropdownButton(
                  controller: _crmStateController,
                  list: const [
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
              CustomAsyncLoadingButton(
                text: 'Cadastrar-se',
                action: () async {
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
