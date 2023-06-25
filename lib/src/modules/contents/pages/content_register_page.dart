import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/ui/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_async_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
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

  final formKey = GlobalKey<FormState>();

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sucesso!')),
      );
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
        scrolledUnderElevation: 0,
        title: PageTitle(title: widget.title),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              CustomTextField(
                validator: (text) => text == null || text.isEmpty
                    ? 'Título não pode ser vazio'
                    : null,
                controller: _titleController,
                labelText: 'Título',
                prefixIcon: const Icon(Icons.title),
              ),
              CustomTextField(
                validator: (text) => text == null || text.isEmpty
                    ? 'Subtítulo não pode ser vazio'
                    : null,
                controller: _subtitleController,
                labelText: 'Subtítulo',
                prefixIcon: const Icon(Icons.subtitles),
              ),
              InjuryDropdownButton(
                validator: (value) =>
                    value == null ? 'Selecione uma lesão' : null,
                injuryTypeController: _injuryTypeController,
                idInjuryType: widget.content?.injuryType?.idInjuryType,
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
              CustomTextField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Observação não pode ser vazia';
                  }
                  return null;
                },
                controller: _observationController,
                labelText: 'Observações',
                prefixIcon: const Icon(Icons.zoom_in),
                maxLines: 3,
                maxLength: 150,
              ),
              const SizedBox(height: 40),
              CustomAsyncLoadingButton(
                text: 'Salvar',
                action: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  if (widget.content == null) {
                    return controller.create(_getContentFromForm());
                  }
                  return controller.update(_getContentFromForm());
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
