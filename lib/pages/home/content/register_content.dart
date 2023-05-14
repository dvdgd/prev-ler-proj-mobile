import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_dropdown_button.dart';
import 'package:prev_ler/widgets/custom_outline_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RegisterContentPage extends StatefulWidget {
  final String title;

  const RegisterContentPage({
    super.key,
    required this.title,
  });

  @override
  State<RegisterContentPage> createState() => _RegisterContentPageState();
}

class _RegisterContentPageState extends State<RegisterContentPage> {
  final _tituloController = TextEditingController();
  final _subtituloController = TextEditingController();
  final _lesaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Cadastrar Conteúdo'),
      ),
      body: Column(
        children: [
          spaceBetweenFields(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _tituloController,
                    hintText: 'Título',
                    prefixIcon: const Icon(Icons.title),
                  ),
                  spaceBetweenFields(),
                  CustomTextField(
                    controller: _subtituloController,
                    hintText: 'Subtítulo',
                    prefixIcon: const Icon(Icons.subtitles),
                  ),
                  spaceBetweenFields(),
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeColors().grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                          controller: _descricaoController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            labelText: 'Descrição',
                            border: InputBorder.none,
                          ),
                          maxLines: 5),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: ThemeColors().grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: TextField(
                        controller: _observacoesController,
                        decoration: const InputDecoration(
                          labelText: 'Observações',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.zoom_in),
                        ),
                        maxLines: 3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomOutlineButton(
                            text: 'Cancelar',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomButton(
                            text: 'Salvar',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox spaceBetweenFields() {
    return const SizedBox(
      height: 2.0,
      width: 2.0,
    );
  }
}
