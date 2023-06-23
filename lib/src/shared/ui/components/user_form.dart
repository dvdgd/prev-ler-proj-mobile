import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/entities/patient.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_date_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:prev_ler/src/shared/utils/constants.dart';
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
  final _occupationController = TextEditingController();
  final _crmNumberController = TextEditingController();
  final _crmStateController = TextEditingController();

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
    final crmNumber = _crmNumberController.text;
    final crmState = _crmStateController.text;

    return User(
      name: name,
      bornDate: DateTime.parse(bornDate),
      email: email,
      password: password,
      medic: Medic(crmNumber: crmNumber, crmState: crmState),
      patient: Patient(occupation: 'Médico'),
    );
  }

  void _serializeControllers(User user) {
    _emailController.text = user.email;
    _passwordController.text = user.password ?? '';
    _nameController.text = user.name;
    _bornDateController.text = DateFormat('dd/MM/yyyy').format(user.bornDate);
    _crmNumberController.text = user.medic?.crmNumber ?? '';
    _crmStateController.text = user.medic?.crmState ?? '';
    _selectedBornDateController.text =
        DateFormat('dd/MM/yyyy').format(user.bornDate);
    _occupationController.text = user.patient?.occupation ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isMedic = widget.userType == UserType.medic;
    final buttonText = widget.user == null ? 'Cadastrar-se' : 'Salvar';

    return Form(
      key: _formKey,
      child: Column(children: [
        CustomTextField(
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
          maxLength: 50,
          prefixIcon: const Icon(Icons.email_outlined),
          enable: enableFields,
        ),
        CustomPasswordField(
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
          maxLength: 25,
          labelText: 'Senha',
        ),
        CustomTextField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'O nome não pode ficar vazio';
            }
            return null;
          },
          controller: _nameController,
          labelText: 'Nome',
          maxLength: 50,
          prefixIcon: const Icon(Icons.person),
        ),
        CustomDatePicker(
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
        if (isMedic) ..._medicForms,
        if (!isMedic) ..._patientForms,
        const SizedBox(height: 30),
        CustomAsyncLoadingButton(
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

  List<Widget> get _patientForms => [
        CustomTextField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Ocupação não pode ser vazia';
            }
            return null;
          },
          controller: _occupationController,
          labelText: 'Ocupação',
          maxLength: 25,
          prefixIcon: const Icon(Icons.work_history_outlined),
        )
      ];

  List<Widget> get _medicForms => [
        CustomTextField(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'O CRM não pode ficar vazio';
            }
            return null;
          },
          controller: _crmNumberController,
          labelText: 'Numero CRM',
          textInputType: TextInputType.number,
          prefixIcon: const Icon(Icons.numbers_outlined),
          enable: enableFields,
        ),
        CustomDropdownButton(
          validator: (value) => value == null ? 'Selecione um estado' : null,
          hintText: 'Selecione um estado',
          initValue: widget.user?.medic?.crmState,
          controller: _crmStateController,
          prefixIcon: const Icon(Icons.map),
          enable: enableFields,
          list: statesList
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
        )
      ];
}
