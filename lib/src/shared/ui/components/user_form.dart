import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
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
        MyTextFormField(
          inputFormatters: [maskCpf],
          controller: _cpfController,
          textInputType: TextInputType.number,
          labelText: 'CPF',
          prefixIcon: const Icon(Icons.email_outlined),
          enable: true,
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
          enable: true,
        ),
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
      ]),
    );
  }
}
