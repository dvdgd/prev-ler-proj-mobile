import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_date_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:string_validator/string_validator.dart' as validator;

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
    required this.userType,
    required this.action,
    this.user,
  });

  final UserType userType;
  final User? user;
  final Future<void> Function(User) action;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _selectedBornDateController = TextEditingController();

  late final bool enableFields;

  @override
  void initState() {
    final user = widget.user;
    enableFields = user == null ? true : false;
    if (user != null) {
      _serializeControllers(user);
    }
    super.initState();
  }

  User _getUserFromForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;
    final bornDate = _selectedBornDateController.text;

    final isMedic = widget.userType == UserType.healthProfessional;

    return User(
      idUser: widget.user?.idUser ?? 0,
      firstName: name,
      bornDate: DateTime.parse(bornDate),
      email: email,
      password: password,
      cpf: '',
      lastName: '',
      type: isMedic ? UserType.employee : UserType.healthProfessional,
    );
  }

  void _serializeControllers(User user) {
    _emailController.text = user.email;
    _passwordController.text = user.password ?? '';
    _nameController.text = user.firstName;

    if (user.bornDate != null) {
      _bornDateController.text = user.bornDate != null
          ? DateFormat('yyyy-MM-dd').format(user.bornDate!)
          : '';
      _selectedBornDateController.text =
          DateFormat('yyyy-MM-dd').format(user.bornDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonText = widget.user == null ? 'Cadastrar-se' : 'Salvar';

    return Form(
      key: _formKey,
      child: Column(children: [
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
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email_outlined),
          enable: enableFields,
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
        MyTextFormField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'O nome não pode ficar vazio';
            }
            return null;
          },
          controller: _nameController,
          labelText: 'Nome',
          prefixIcon: const Icon(Icons.person),
        ),
        MyDatePicker(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'A data não pode ficar vazia';
            }
            return null;
          },
          selectedDate: _selectedBornDateController,
          context: context,
          controller: _bornDateController,
          labelText: 'Data de Nascimento',
          prefixIcon: const Icon(Icons.date_range_outlined),
          enable: enableFields,
        ),
        const SizedBox(height: 30),
        MyFilledLoadingButton(
          text: buttonText,
          action: () async {
            final isFormValid = _formKey.currentState!.validate();
            if (!isFormValid) {
              return;
            }
            return widget.action(_getUserFromForm());
          },
        )
      ]),
    );
  }
}
