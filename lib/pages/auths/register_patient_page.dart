import 'package:flutter/material.dart';
import 'package:prev_ler/entities/user.dart';
import 'package:prev_ler/pages/auths/build_user_form.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class RegisterPatientPage extends StatelessWidget {
  RegisterPatientPage({super.key});

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
      name: name,
      bornDate: DateTime.parse(bornDate),
      email: email,
      password: password,
      patient: Patient(
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
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              Text(
                'Paciente',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Text(
                  "Tenha acesso a conteúdos exclusivos desenvolvidos por médicos licenciados para melhorar sua saúde e bem-estar.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 20),
              ...buildUserForm(
                context: context,
                emailController: _emailController,
                passwordController: _passwordController,
                nameController: _nameController,
                selectedBornDateController: _selectedBornDateController,
                bornDateController: _bornDateController,
                isEditing: false,
              ),
              CustomTextField(
                controller: _occupationController,
                labelText: 'Ocupação',
                maxLength: 25,
                prefixIcon: const Icon(Icons.work_history_outlined),
              ),
              const SizedBox(height: 30),
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
