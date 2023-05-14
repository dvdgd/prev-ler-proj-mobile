import 'package:flutter/material.dart';
import 'package:prev_ler/widgets/custom_date_picker.dart';
import 'package:prev_ler/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/widgets/custom_password_field.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

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
      controller: emailController,
      textInputType: TextInputType.emailAddress,
      hintText: 'Email',
      maxLength: 50,
      prefixIcon: const Icon(Icons.email_outlined),
      enable: !isEditing,
    ),
    CustomPasswordField(
      controller: passwordController,
      maxLength: 25,
      labelText: 'Senha',
    ),
    CustomTextField(
      controller: nameController,
      hintText: 'Nome',
      maxLength: 50,
      prefixIcon: const Icon(Icons.person),
    ),
    CustomDatePicker(
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
      controller: occupationController,
      hintText: 'Ocupação',
      maxLength: 25,
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
      controller: crmNumberController,
      hintText: 'Numero CRM',
      textInputType: TextInputType.number,
      prefixIcon: const Icon(Icons.numbers_outlined),
      enable: !isEditing,
    ),
    CustomDropdownButton(
      enable: !isEditing,
      controller: crmStateController,
      prefixIcon: const Icon(Icons.map),
      list: const [
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
      ],
      hintText: 'Selecione um estado',
    )
  ];
}
