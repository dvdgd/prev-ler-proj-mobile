import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/services/file_converter.dart';
import 'package:prev_ler/src/shared/ui/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/components/my_image_picker.dart';
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
  final _imagePath = TextEditingController();

  @override
  void initState() {
    super.initState();

    converter = context.read<FileConverter>();
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

  Future<Exercise> _getExerciseFromForm() async {
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
      image: await converter.fileToBase64(_imagePath.text),
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
              imagePathController: _imagePath,
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
            CustomTextField(
              labelText: 'Nome*',
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              controller: _nameController,
              prefixIcon: const Icon(Icons.text_format),
            ),
            InjuryDropdownButton(injuryTypeController: _injuryTypeController),
            CustomTextField(
              labelText: 'Instruções*',
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              controller: _instructionsController,
              prefixIcon: const Icon(Icons.integration_instructions),
              maxLength: 200,
            ),
            CustomTextField(
              labelText: 'Descrição*',
              controller: _descriptionController,
              validator: (text) =>
                  text == null || text.isEmpty ? 'Campo obrigatório' : null,
              prefixIcon: const Icon(Icons.description),
              maxLength: 200,
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
            CustomTextField(
              labelText: 'Precauções',
              controller: _precautionsController,
              prefixIcon: const Icon(Icons.warning_rounded),
              maxLength: 200,
            ),
            CustomTextField(
              labelText: 'Observações',
              textInputType: TextInputType.multiline,
              controller: _observationsController,
              prefixIcon: const Icon(Icons.remove_red_eye),
              maxLength: 200,
            ),
            const SizedBox(height: 40),
            CustomAsyncLoadingButton(
              text: 'Salvar',
              action: () async {
                if (_formKey.currentState!.validate()) {
                  await controller.create(
                    await _getExerciseFromForm(),
                  );
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
