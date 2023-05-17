import 'package:flutter/material.dart';
import 'package:prev_ler/service/content_service.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RegisterContentPage extends StatelessWidget {
  final String title;

  RegisterContentPage({
    super.key,
    required this.title,
  });

  final _idmedicoController = TextEditingController();
  final _idlesaoController = TextEditingController();
  final _tituloController = TextEditingController();
  final _subtituloController = TextEditingController();
  final _lesaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Cadastrar Conteúdo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Column(
            children: [
              const SizedBox(height: 15),
              CustomTextField(
                controller: _idmedicoController,
                labelText: 'ID do Médico',
                prefixIcon: const Icon(Icons.title),
              ),
              CustomTextField(
                controller: _idlesaoController,
                labelText: 'ID da Lesão',
                prefixIcon: const Icon(Icons.title),
              ),
              CustomTextField(
                controller: _tituloController,
                labelText: 'Título',
                prefixIcon: const Icon(Icons.title),
              ),
              CustomTextField(
                controller: _subtituloController,
                labelText: 'Subtítulo',
                prefixIcon: const Icon(Icons.subtitles),
              ),
              CustomDropdownButton(
                controller: _lesaoController,
                prefixIcon: const Icon(Icons.healing_outlined),
                hintText: 'Selecionar Lesão',
                list: const [
                  'Tendinite',
                  'Bursite',
                  'Miosites',
                  'Tenossinovite',
                  'Sinovite',
                  'Lumbago'
                ],
              ),
              CustomTextField(
                controller: _descricaoController,
                labelText: 'Descrição',
                prefixIcon: const Icon(Icons.description),
                maxLines: 5,
              ),
              CustomTextField(
                controller: _observacoesController,
                labelText: 'Observações',
                prefixIcon: const Icon(Icons.zoom_in),
                maxLines: 3,
                maxLength: 4,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Expanded(
                  child: CustomButton(
                    text: 'Salvar',
                    onTap: () {
                      createContent(
                          _idmedicoController.text,
                          _idlesaoController.text,
                          _tituloController.text,
                          _subtituloController.text,
                          _descricaoController.text,
                          _observacoesController.text);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
