import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/register_user_controller.dart';
import 'package:prev_ler/src/shared/enums/user_type.dart';
import 'package:prev_ler/src/shared/ui/components/user_form.dart';
import 'package:provider/provider.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({
    super.key,
    required this.userType,
  });

  final UserType userType;

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastrado com sucesso.')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType = widget.userType;
    final isMedic = userType == UserType.medic;

    final title = isMedic ? "Médico" : "Paciente";
    final description = isMedic
        ? "Informe seu CRM e estado de origem para garantir a segurança das informações."
        : "Tenha acesso a conteúdos exclusivos desenvolvidos por médicos licenciados para melhorar sua saúde e bem-estar.";

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
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 30),
              UserForm(
                userType: userType,
                action: controller.register,
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
