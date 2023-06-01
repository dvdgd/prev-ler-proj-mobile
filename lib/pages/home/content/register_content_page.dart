import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/entities/content.dart';
import 'package:prev_ler/pages/home/content/content_page.dart';
import 'package:prev_ler/pages/main_page.dart';
import 'package:prev_ler/services/content_service.dart';
import 'package:prev_ler/services/injury_service.dart';
import 'package:prev_ler/widgets/custom_alert_dialog.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RegisterContentPage extends ConsumerWidget {
  final String title;
  final int idMedic;

  RegisterContentPage({
    super.key,
    required this.title,
    required this.idMedic,
  });

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _injuryTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _observationController = TextEditingController();

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
      idContent: 0,
      idMedic: idMedic,
      idInjuryType: int.parse(injuryTypeId),
      title: title,
      subtitle: subtitle,
      description: description,
      observation: observation,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<void> _saveContent(BuildContext context, WidgetRef ref) async {
    final currentContext = context;
    try {
      final content = _getContentFromForm();
      final contentServiceProvider = ref.read(contentProvider);
      await contentServiceProvider.register(content);
      if (context.mounted) {
        await showDialog(
          context: currentContext,
          builder: (context) => CustomAlertDialog(
            message: 'Sucesso!',
            onTap: () async {
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    page: ContentPage(),
                  ),
                ),
                (route) => false,
              );
            },
          ),
        );
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          message: e.toString(),
          onTap: () => Navigator.of(context).pop(),
        ),
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
      body: LayoutBuilder(builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        return RefreshIndicator(
          onRefresh: () async => await ref.refresh(injuryDataProvider.future),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                Consumer(
                  builder: (context, ref, child) {
                    final data = ref.watch(injuryDataProvider);

                    return data.when(
                      data: (injuries) {
                        return CustomDropdownButton(
                          controller: _injuryTypeController,
                          prefixIcon: const Icon(Icons.healing_outlined),
                          hintText: 'Selecionar Lesão',
                          list: [
                            for (var item in injuries)
                              DropdownMenuItem<int>(
                                value: item.idInjuryType,
                                child: Text(
                                  item.name,
                                ),
                              ),
                          ],
                        );
                      },
                      error: (e, __) {
                        Navigator.of(context).pop();
                        return Text(e.toString());
                      },
                      loading: () => const CustomTextField(
                        prefixIcon: Icon(Icons.healing_outlined),
                        hintText: 'Selecionar Lesão',
                      ),
                    );
                  },
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: 'Salvar',
                    onTap: () => _saveContent(context, ref),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}
