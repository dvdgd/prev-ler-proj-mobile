import 'package:flutter/material.dart';
import 'package:menu_lateral/widgets/custom_dropdown_button.dart';
import 'package:menu_lateral/widgets/custom_text_field.dart';

import '../../theme/theme_colors.dart';

void main() {
  runApp(const ContentPage());
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final _tituloController = TextEditingController();
  final _subtituloController = TextEditingController();
  final _lesaoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _observacoesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Conteúdo',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          spaceBetweenFields(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(controller: _tituloController, hintText: 'Título'),
                  spaceBetweenFields(),
                  CustomTextField(
                    controller: _subtituloController,
                    hintText: 'Subtítulo',
                  ),
                  spaceBetweenFields(),
                  CustomDropdownButton(
                    controller: _lesaoController,
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
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: ThemeColors().grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextField(
                      controller: _descricaoController,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: InputBorder.none,
                      ),
                      maxLines: 5),
                  ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: ThemeColors().grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextField(
                      controller: _observacoesController,
                      decoration: const InputDecoration(
                        hintText: 'Observações',
                        border: InputBorder.none,
                      ),
                      maxLines: 3),
                  ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    color : Colors.amber,
                    decoration: BoxDecoration(
                      border: InputBorder.none,
                    ),
                    child : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors().blue,
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    
                    onPressed: () {},
                    ),
                  ),
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