import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/register_user_controller.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/build_user_form.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:provider/provider.dart';

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
  final formKey = GlobalKey<FormState>();

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

  _handleRegisterStateChange() {
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
    final crmNumber = _crmNumberController.text;
    final crmState = _crmStateController.text;

    return User(
      name: name,
      bornDate: DateTime.parse(bornDate),
      email: email,
      password: password,
      medic: Medic(
        idMedic: 0,
        crmNumber: crmNumber,
        crmState: crmState,
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
                'Médico',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
                child: Text(
                  "Informe seu CRM e estado de origem para garantir a segurança das informações.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    ...buildUserForm(
                      context: context,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      nameController: _nameController,
                      selectedBornDateController: _selectedBornDateController,
                      bornDateController: _bornDateController,
                      isEditing: false,
                    ),
                    ...buildMedicForm(
                      crmNumberController: _crmNumberController,
                      crmStateController: _crmStateController,
                      isEditing: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              CustomAsyncLoadingButton(
                text: 'Cadastrar-se',
                action: () async {
                  formKey.currentState!.validate()
                      ? controller.register(_validateForm())
                      : null;
                },
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
