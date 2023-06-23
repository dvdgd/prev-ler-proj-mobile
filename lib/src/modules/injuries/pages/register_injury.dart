import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class RegisterInjury extends StatefulWidget {
  final String title;
  final InjuryType? injury;

  const RegisterInjury({
    super.key,
    this.injury,
    required this.title,
  });

  @override
  State<RegisterInjury> createState() => _RegisterInjuryState();
}

class _RegisterInjuryState extends State<RegisterInjury> {
  final _nameController = TextEditingController();
  final _abbreviationController = TextEditingController();
  final _descriptionController = TextEditingController();

  late final Medic medic;
  late final InjuriesController controller;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = context.read<InjuriesController>();
    controller.addListener(_handleAuthStateChange);

    final medic = context.read<UserController>().user?.medic;
    if (medic == null) {
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      this.medic = medic;
    }

    final injury = widget.injury;
    if (injury != null) serializeControllers(injury);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_handleAuthStateChange);
  }

  void serializeControllers(InjuryType injury) {
    _nameController.text = injury.name;
    _abbreviationController.text = injury.abbreviation;
    _descriptionController.text = injury.description;
  }

  void _handleAuthStateChange() {
    if (controller.state == StateEnum.success) {
      Navigator.of(context).pop();
    }

    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  InjuryType _getInjuryFromForm() {
    final name = _nameController.text;
    final abbreviation = _abbreviationController.text;
    final description = _descriptionController.text;

    return InjuryType(
      idInjuryType: widget.injury?.idInjuryType ?? 0,
      idMedic: medic.idMedic,
      name: name,
      abbreviation: abbreviation,
      description: description,
      createdAt: widget.injury?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: PageTitle(title: widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            CustomTextField(
              validator: (text) => text == null || text.isEmpty
                  ? 'Nome não pode ser vazio'
                  : null,
              controller: _nameController,
              labelText: 'Nome',
              prefixIcon: const Icon(Icons.text_fields),
            ),
            CustomTextField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Sigla não pode ser vazia';
                }
                return null;
              },
              controller: _abbreviationController,
              labelText: 'Sigla',
              prefixIcon: const Icon(Icons.text_fields),
              maxLength: 8,
            ),
            CustomTextField(
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Descrição não pode ser vazia';
                }
                return null;
              },
              controller: _descriptionController,
              labelText: 'Descrição',
              prefixIcon: const Icon(Icons.description),
              maxLines: 5,
              maxLength: 300,
            ),
            const SizedBox(height: 40),
            CustomAsyncLoadingButton(
              text: 'Salvar',
              action: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                if (widget.injury == null) {
                  return controller.create(_getInjuryFromForm());
                }
                return controller.update(_getInjuryFromForm());
              },
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
