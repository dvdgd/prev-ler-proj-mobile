import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/services/file_converter.dart';
import 'package:prev_ler/src/shared/ui/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_image_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ExerciseFormPage extends StatefulWidget {
  const ExerciseFormPage({super.key, this.exercise});

  final Exercise? exercise;

  @override
  State<ExerciseFormPage> createState() => _ExerciseFormPageState();
}

class _ExerciseFormPageState extends State<ExerciseFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final ExercisesController controller;
  late final FileConverter converter;
  late final Medic medic;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _precautionsController = TextEditingController();
  final _observationsController = TextEditingController();
  final _injuryTypeController = TextEditingController();
  final _imagePathController = TextEditingController();

  @override
  void initState() {
    super.initState();

    converter = context.read<FileConverter>();
    controller = context.read<ExercisesController>();
    controller.addListener(_handleControllerChangeState);
    _serializeControllers();
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

  void _serializeControllers() {
    final exercise = widget.exercise;
    if (exercise == null) {
      return;
    }

    _nameController.text = exercise.name;
    _descriptionController.text = exercise.description;
    _instructionsController.text = exercise.instructions;
    _precautionsController.text = exercise.precautions ?? '';
    _observationsController.text = exercise.observations ?? '';
    _injuryTypeController.text = exercise.idInjuryType.toString();
    _imagePathController.text = exercise.image;
  }

  Future<Exercise> _getExerciseFromForm() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final instructions = _instructionsController.text;
    final precautions = _precautionsController.text;
    final observations = _observationsController.text;
    final injuryTypeId = _injuryTypeController.text;

    return Exercise(
      idExercise: widget.exercise?.idExercise ?? 0,
      idMedic: medic.idMedic,
      idInjuryType: int.parse(injuryTypeId),
      name: name,
      description: description,
      instructions: instructions,
      image: _imagePathController.text,
      precautions: precautions,
      observations: observations,
      createdAt: DateTime.now(),
    );
  }

  List<Widget> get divider => [
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(height: 20),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Novo Exercício'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Crie um exercício para facilitar um paciente com a sua rotina para previnir as Lesões por Esforço Repetitivo (LER).',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 40),
            MyImagePicker(
              imagePathController: _imagePathController,
              text: const Text(
                'Selecione uma imagem contendo o passo a passo de um exercício.',
                textAlign: TextAlign.center,
              ),
            ),
            ...divider,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Preencha as demais informações acerca do exercício.',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 15),
            MyTextFormField(
              labelText: 'Nome*',
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              controller: _nameController,
              prefixIcon: const Icon(Icons.text_format),
            ),
            InjuryDropdownButton(
              injuryTypeController: _injuryTypeController,
              idInjuryType: widget.exercise?.idInjuryType,
            ),
            MyTextFormField(
              labelText: 'Instruções*',
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              controller: _instructionsController,
              prefixIcon: const Icon(Icons.integration_instructions),
              maxLength: 2000,
              maxLines: 20,
            ),
            MyTextFormField(
              labelText: 'Descrição*',
              controller: _descriptionController,
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              prefixIcon: const Icon(Icons.description),
              maxLength: 2000,
              maxLines: 20,
            ),
            ...divider,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Caso o exercício tenha alguma precaução a ser informada ou alguma observação descreva nos campos abaixo.',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 15),
            MyTextFormField(
              labelText: 'Precauções',
              controller: _precautionsController,
              prefixIcon: const Icon(Icons.warning_rounded),
              maxLength: 500,
              maxLines: 20,
            ),
            MyTextFormField(
              labelText: 'Observações',
              textInputType: TextInputType.multiline,
              controller: _observationsController,
              prefixIcon: const Icon(Icons.remove_red_eye),
              maxLength: 500,
              maxLines: 20,
            ),
            const SizedBox(height: 40),
            MyFilledLoadingButton(
              text: 'Salvar',
              action: () async {
                final validForm = _formKey.currentState?.validate();
                if (validForm == null || !validForm) {
                  return;
                }
                // verificar se o imagepath é vazia, se sim, chamar o validate
                if (_imagePathController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Erro: Selecione uma imagem'),
                    ),
                  );
                  return;
                }

                final exercise = await _getExerciseFromForm();
                if (widget.exercise == null) {
                  await controller.create(exercise);
                } else {
                  await controller.update(exercise);
                }
              },
            ),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
