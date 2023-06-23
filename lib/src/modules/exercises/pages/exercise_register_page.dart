import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/ui/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ExerciseRegisterPage extends StatefulWidget {
  const ExerciseRegisterPage({super.key});

  @override
  State<ExerciseRegisterPage> createState() => _ExerciseRegisterPageState();
}

class _ExerciseRegisterPageState extends State<ExerciseRegisterPage> {
  late final ExercisesController controller;
  late final Medic medic;

  @override
  void initState() {
    super.initState();

    controller = context.read<ExercisesController>();
    controller.addListener(_handleControllerChangeState);
    final medic = context.read<UserController>().user?.medic;
    if (medic == null) {
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      this.medic = medic;
    }
  }

  @override
  void dispose() {
    controller.removeListener(_handleControllerChangeState);
    super.dispose();
  }

  _handleControllerChangeState() {
    if (controller.state == StateEnum.success) {
      Navigator.of(context).pop();
    }
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(controller.errorMessage),
          action: SnackBarAction(
            label: 'Fechar',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
    }
  }

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _precautionsController = TextEditingController();
  final _observationsController = TextEditingController();
  final _injuryTypeController = TextEditingController();

  Exercise _getExerciseFromForm() {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final instructions = _instructionsController.text;
    final precautions = _precautionsController.text;
    final observations = _observationsController.text;
    final injuryTypeId = _injuryTypeController.text;

    return Exercise(
      idMedic: medic.idMedic,
      idInjuryType: int.parse(injuryTypeId),
      name: name,
      description: description,
      instructions: instructions,
      image: 'teste',
      precautions: precautions,
      observations: observations,
      createdAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Cadastrar Exercício'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          child: Column(children: [
            const SizedBox(height: 15),
            CustomTextField(
              controller: _nameController,
              labelText: 'Nome',
              prefixIcon: const Icon(Icons.text_format),
            ),
            InjuryDropdownButton(injuryTypeController: _injuryTypeController),
            CustomTextField(
              controller: _descriptionController,
              labelText: 'Descrição',
              prefixIcon: const Icon(Icons.description),
              maxLines: 10,
              maxLength: 200,
            ),
            CustomTextField(
              controller: _instructionsController,
              labelText: 'Instruções',
              prefixIcon: const Icon(Icons.integration_instructions),
              maxLines: 5,
              maxLength: 200,
            ),
            CustomTextField(
              controller: _precautionsController,
              labelText: 'Precauções',
              prefixIcon: const Icon(Icons.warning_rounded),
              maxLines: 5,
              maxLength: 200,
            ),
            CustomTextField(
              textInputType: TextInputType.multiline,
              controller: _observationsController,
              labelText: 'Observações',
              prefixIcon: const Icon(Icons.remove_red_eye),
              maxLines: 5,
              maxLength: 200,
            ),
            const SizedBox(height: 40),
            CustomAsyncLoadingButton(
              text: 'Salvar',
              action: () => controller.create(_getExerciseFromForm()),
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
