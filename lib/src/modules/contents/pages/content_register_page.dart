import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/enums/state_controller.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterContentPage extends StatefulWidget {
  final String title;
  final Content? content;

  const RegisterContentPage({
    super.key,
    required this.title,
    this.content,
  });

  @override
  State<RegisterContentPage> createState() => _RegisterContentPageState();
}

class _RegisterContentPageState extends State<RegisterContentPage> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _injuryTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _observationController = TextEditingController();

  late final ContentsController controller;
  late final Medic medic;

  @override
  void initState() {
    super.initState();
    controller = context.read<ContentsController>();
    controller.addListener(_handleAuthStateChange);

    final medic = context.read<UserController>().user?.medic;
    if (medic == null) {
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      this.medic = medic;
    }

    final content = widget.content;
    if (content != null) {
      _titleController.text = content.title;
      _subtitleController.text = content.subtitle;
      _injuryTypeController.text =
          content.injuryType?.idInjuryType.toString() ?? '';
      _descriptionController.text = content.description;
      _observationController.text = content.observation;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_handleAuthStateChange);
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

  Content _getContentFromForm() {
    final title = _titleController.text;
    final subtitle = _subtitleController.text;
    final description = _descriptionController.text;
    final observation = _observationController.text;
    final injuryTypeId = _injuryTypeController.text;

    if (title.isEmpty) {
      throw Exception('Título não pode ser vazio');
    }
    if (subtitle.isEmpty) {
      throw Exception('O subtítulo é obrigatório');
    }
    if (injuryTypeId.isEmpty) {
      throw Exception('Por favor, preencha o tipo de lesão');
    }
    if (description.isEmpty) {
      throw Exception('Preencha a descrição');
    }
    if (observation.isEmpty) {
      throw Exception('A observação não pode ser vazia');
    }

    return Content(
      idMedic: medic.idMedic,
      idInjuryType: int.parse(injuryTypeId),
      title: title,
      subtitle: subtitle,
      description: description,
      observation: observation,
      createdAt: DateTime.now(),
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
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 15),
              CustomTextField(
                controller: _titleController,
                labelText: 'Título',
                prefixIcon: const Icon(Icons.title),
              ),
              CustomTextField(
                controller: _subtitleController,
                labelText: 'Subtítulo',
                prefixIcon: const Icon(Icons.subtitles),
              ),
              InjuryDropdownButton(
                injuryTypeController: _injuryTypeController,
                idInjuryType: widget.content?.injuryType?.idInjuryType,
              ),
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Descrição',
                prefixIcon: const Icon(Icons.description),
                maxLines: 5,
              ),
              CustomTextField(
                controller: _observationController,
                labelText: 'Observações',
                prefixIcon: const Icon(Icons.zoom_in),
                maxLines: 3,
                maxLength: 4,
              ),
              const SizedBox(height: 40),
              CustomAsyncLoadingButton(
                text: 'Salvar',
                action: () => widget.content == null
                    ? controller.create(_getContentFromForm())
                    : controller.update(_getContentFromForm()),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
