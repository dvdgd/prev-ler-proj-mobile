import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/register_user/register_user_controller.dart';
import 'package:prev_ler/src/shared/entities/patient.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/build_user_form.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

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

  late final RegisterUserController controller;
  @override
  void initState() {
    super.initState();

    controller = context.read<RegisterUserController>();
    controller.addListener(_handleRegisterStateChange);
  }

  @override
  void dispose() {
    controller.removeListener(_handleRegisterStateChange);
    super.dispose();
  }

  void _handleRegisterStateChange() {
    if (controller.state == RegisterUserState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocorreu um erro inexperado, tente novamente mais tarde.',
          ),
        ),
      );
    } else if (controller.state == RegisterUserState.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            message: 'Sucesso!',
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
        );
      });
    }
  }

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
                action: () => controller.register(_validateForm()),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
