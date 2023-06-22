import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_date_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_password_field.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:string_validator/string_validator.dart' as validator;

List<Widget> buildUserForm({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController nameController,
  required TextEditingController selectedBornDateController,
  required TextEditingController bornDateController,
  required bool isEditing,
}) {
  List<Widget> formWidgets = [
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
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      labelText: 'Email',
      prefixIcon: const Icon(Icons.email_outlined),
      enable: !isEditing,
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
      controller: passwordController,
      labelText: 'Senha',
    ),
    CustomTextField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'O nome não pode ficar vazio';
        }
        return null;
      },
      controller: nameController,
      labelText: 'Nome',
      prefixIcon: const Icon(Icons.person),
    ),
    CustomDatePicker(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'A data não pode ficar vazia';
        }
        return null;
      },
      selectedDate: selectedBornDateController,
      context: context,
      controller: bornDateController,
      labelText: 'Data de Nascimento',
      prefixIcon: const Icon(Icons.date_range_outlined),
      enable: !isEditing,
    ),
  ];

  return formWidgets;
}

List<Widget> buildPatientForm({
  required TextEditingController occupationController,
  required bool isEditing,
}) {
  return [
    CustomTextField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Ocupação não pode ser vazia';
        }
        return null;
      },
      controller: occupationController,
      labelText: 'Ocupação',
      prefixIcon: const Icon(Icons.work_history_outlined),
    )
  ];
}

List<Widget> buildMedicForm({
  required TextEditingController crmNumberController,
  required TextEditingController crmStateController,
  required bool isEditing,
}) {
  return [
    CustomTextField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'O CRM não pode ficar vazio';
        }
        return null;
      },
      controller: crmNumberController,
      labelText: 'Numero CRM',
      textInputType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      prefixIcon: const Icon(Icons.numbers_outlined),
      enable: !isEditing,
    ),
    CustomDropdownButton(
      validator: (value) => value == null ? 'Selecione um estado' : null,
      enable: !isEditing,
      controller: crmStateController,
      prefixIcon: const Icon(Icons.map),
      list: [
        for (var item in const [
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
        ])
          DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ),
      ],
      hintText: 'Selecione um estado',
    )
  ];
}
