import 'package:flutter/material.dart';
import 'package:prev_ler/entities/user.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/widgets/custom_date_picker.dart';
import 'package:prev_ler/widgets/custom_password_field.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class RegisterPatientPage extends StatefulWidget {
  const RegisterPatientPage({super.key});

  @override
  State<RegisterPatientPage> createState() => _RegisterPatientPageState();
}

class _RegisterPatientPageState extends State<RegisterPatientPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();
  final _occupationController = TextEditingController();

  User _validateForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final bornDate = _selectedBornDateController.text;
    final occupation = _occupationController.text;

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
    if (occupation.isEmpty) {
      throw Exception('Ocupação não pode ser vazia');
    }

    return User(
      email: email,
      password: password,
      patient: Patient(
        bornDate: DateTime.parse(bornDate),
        name: name,
        occupation: occupation,
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
                controller: _nameController,
                hintText: 'Nome',
                maxLength: 50,
                prefixIcon: const Icon(Icons.text_fields_outlined),
              ),
              CustomDatePicker(
                selectedDate: _selectedBornDateController,
                context: context,
                controller: _bornDateController,
                hintText: 'Data de Nascimento',
                prefixIcon: const Icon(Icons.date_range_outlined),
              ),
              CustomTextField(
                controller: _occupationController,
                hintText: 'Ocupação',
                maxLength: 25,
                prefixIcon: const Icon(Icons.work_history_outlined),
              ),
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
