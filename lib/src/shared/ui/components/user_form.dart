import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart' as validator;

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
    required this.action,
  });

  final Future<void> Function(UserSignUp) action;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cpfController = TextEditingController();

  final _nameController = TextEditingController();
  final _occupationController = TextEditingController();
  late User? user;

  @override
  void initState() {
    user = context.read<UserController>().user;
    if (user != null) {
      _serializeControllers(user!);
    }
    super.initState();
  }

  void _serializeControllers(User user) {
    _emailController.text = user.email;
    _cpfController.text = user.cpf;
    _passwordController.text = user.password ?? '';
    _nameController.text = '${user.firstName} ${user.lastName}';
    _occupationController.text = user.jobRole;
  }

  Future<void> handleRegister() async {
    final isFormValid = _formKey.currentState!.validate();
    if (!isFormValid) {
      return;
    }

    return widget.action(UserSignUp(
      email: _emailController.text,
      password: _passwordConfirmationController.text,
      passwordConfirmation: _passwordController.text,
      cpf: _cpfController.text,
    ));
  }

  final maskCpf = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    const buttonText = 'Cadastrar-se';

    return Form(
      key: _formKey,
      child: Column(children: [
        if (user != null)
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
            child: Text(
              'Para editar os seus dados, contate o representante da sua empresa.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        const SizedBox(height: 30),
        MyTextFormField(
          inputFormatters: [maskCpf],
          controller: _cpfController,
          textInputType: TextInputType.number,
          labelText: 'CPF',
          prefixIcon: const Icon(Icons.email_outlined),
          enable: user == null,
          validator: (text) {
            if (text?.length != 14) {
              return 'CPF inválidos.';
            }
            if (!CPFValidator.isValid(text)) {
              return 'CPF inválido.';
            }
            return null;
          },
        ),
        MyTextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'O email não pode ser vazio';
            }
            if (text.length < 6) {
              return 'Informe pelo menos 6 caracteres';
            }
            if (!validator.isEmail(text)) {
              return 'Insira um email válido';
            }
            return null;
          },
          controller: _emailController,
          textInputType: TextInputType.emailAddress,
          labelText: 'Email Corporativo',
          prefixIcon: const Icon(Icons.email_outlined),
          enable: user == null,
        ),
        if (user != null) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Divider(),
          ),
          MyTextFormField(
            controller: _nameController,
            textInputType: TextInputType.emailAddress,
            labelText: 'Nome completo',
            prefixIcon: const Icon(Icons.email_outlined),
            enable: user == null,
          ),
          MyTextFormField(
            controller: _occupationController,
            textInputType: TextInputType.emailAddress,
            labelText: 'Cargo/Ocupação',
            prefixIcon: const Icon(Icons.email_outlined),
            enable: user == null,
          ),
        ],
        if (user == null) ...[
          PasswordField(
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'A senha não pode ser vazia';
              }
              if (text.length < 8) {
                return 'Informe pelo menos 8 caracteres';
              }
              if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(text)) {
                return 'Informe ao menos um caractere especial ';
              }
              return null;
            },
            controller: _passwordController,
            labelText: 'Senha',
          ),
          PasswordField(
            validator: (text) {
              if (text != _passwordController.text) {
                return 'As senhas não coincidem.';
              }
              return null;
            },
            controller: _passwordConfirmationController,
            labelText: 'Confirmação de senha',
          ),
          const SizedBox(height: 30),
          MyFilledLoadingButton(
            text: buttonText,
            action: handleRegister,
          )
        ]
      ]),
    );
  }
}
