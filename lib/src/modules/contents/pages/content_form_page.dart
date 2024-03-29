import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/contents/shared/contents_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/entities/content.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/ui/components/injury_dropdown_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ContentFormPage extends StatefulWidget {
  final String title;
  final Content? content;

  const ContentFormPage({
    super.key,
    required this.title,
    this.content,
  });

  @override
  State<ContentFormPage> createState() => _ContentFormPageState();
}

class _ContentFormPageState extends State<ContentFormPage> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _observationController = TextEditingController();
  final _injuryTypeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late final ContentsController controller;
  late final User user;

  @override
  void initState() {
    super.initState();
    controller = context.read<ContentsController>();
    controller.addListener(_handleAuthStateChange);

    final user = context.read<UserController>().user;
    if (user == null) {
      Navigator.of(Routes.navigatorKey.currentContext!)
          .pushReplacementNamed('/');
    } else {
      this.user = user;
    }

    final content = widget.content;
    if (content != null) {
      _injuryTypeController.text = content.injuryTypeId.toString();
      _titleController.text = content.title;
      _subtitleController.text = content.subtitle;
      _descriptionController.text = content.description;
      _observationController.text = content.observation ?? '';
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
      Navigator.of(Routes.navigatorKey.currentContext!).pop();
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
      contentId: widget.content?.contentId ?? 0,
      companyId: user.company?.cnpj ?? '',
      title: title,
      subtitle: subtitle,
      description: description,
      observation: observation,
      injuryTypeId: int.parse(injuryTypeId),
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
              MyTextFormField(
                validator: (text) => text == null || text.isEmpty
                    ? 'Título não pode ser vazio'
                    : null,
                controller: _titleController,
                labelText: 'Título*',
                prefixIcon: const Icon(Icons.title),
              ),
              MyTextFormField(
                validator: (text) => text == null || text.isEmpty
                    ? 'Subtítulo não pode ser vazio'
                    : null,
                controller: _subtitleController,
                labelText: 'Subtítulo*',
                prefixIcon: const Icon(Icons.subtitles),
              ),
              InjuryDropdownButton(
                injuryTypeController: _injuryTypeController,
                idInjuryType: widget.content?.injuryTypeId,
              ),
              MyTextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Descrição não pode ser vazia';
                  }
                  return null;
                },
                controller: _descriptionController,
                textInputType: TextInputType.multiline,
                labelText: 'Descrição*',
                prefixIcon: const Icon(Icons.description),
                maxLines: 10,
                maxLength: 4000,
              ),
              MyTextFormField(
                controller: _observationController,
                labelText: 'Observações',
                prefixIcon: const Icon(Icons.zoom_in),
                maxLines: 5,
                maxLength: 500,
              ),
              const SizedBox(height: 40),
              MyFilledLoadingButton(
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
