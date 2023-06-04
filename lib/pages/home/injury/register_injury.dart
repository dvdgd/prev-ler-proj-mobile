import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/services/injury_service.dart';
import 'package:prev_ler/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RegisterInjury extends ConsumerWidget {
  final String title;
  final int idMedic;

  RegisterInjury({
    super.key,
    required this.title,
    required this.idMedic,
  });

  final _nameController = TextEditingController();
  final _abbreviationController = TextEditingController();
  final _descriptionController = TextEditingController();

  InjuryType _getInjuryFromForm() {
    final name = _nameController.text;
    final abbreviation = _abbreviationController.text;
    final description = _descriptionController.text;

    if (name.isEmpty) {
      throw Exception('Nome não pode ser vazio');
    }
    if (abbreviation.isEmpty) {
      throw Exception('A abreviação é obrigatório');
    }
    if (description.isEmpty) {
      throw Exception('Por favor, preencha o a descrição da lesão');
    }

    return InjuryType(
      idInjuryType: 0,
      idMedic: idMedic,
      name: name,
      abbreviation: abbreviation,
      description: description,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> _saveInjury(BuildContext context, WidgetRef ref) async {
    final currentContext = context;
    try {
      final injury = _getInjuryFromForm();
      final injuryServiceProvider = ref.read(injuryProvider);
      await injuryServiceProvider.register(injury);
      if (context.mounted) {
        await showDialog(
          context: currentContext,
          builder: (context) => const CustomAlertDialog(message: 'Sucesso!'),
        );
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(message: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: PageTitle(title: title),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          CustomTextField(
            controller: _nameController,
            labelText: 'Nome',
            prefixIcon: const Icon(Icons.text_fields),
            // prefixIcon: Icon(Icons.),
          ),
          CustomTextField(
            controller: _abbreviationController,
            labelText: 'Sigla',
            prefixIcon: const Icon(Icons.text_fields),
          ),
          CustomTextField(
            controller: _descriptionController,
            labelText: 'Descrição',
            prefixIcon: const Icon(Icons.description),
            maxLines: 5,
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              text: 'Cadastrar',
              onTap: () => _saveInjury(context, ref),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
