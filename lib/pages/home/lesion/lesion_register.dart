import 'package:flutter/material.dart';
import 'package:prev_ler/service/lesion_service.dart';
import 'package:prev_ler/theme/theme_colors.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_outline_button.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RegisterLesion extends StatefulWidget {
  final String title;

  const RegisterLesion({
    super.key,
    required this.title,
  });

  @override
  State<RegisterLesion> createState() => _RegisterLesionState();
}

class _RegisterLesionState extends State<RegisterLesion> {
  final _idmedicoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _siglaController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Cadastrar Lesão'),
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
                    controller: _idmedicoController,
                    hintText: 'ID do Médico',
                    prefixIcon: const Icon(Icons.title),
                  ),
                  CustomTextField(
                    controller: _nomeController,
                    hintText: 'Nome',
                    prefixIcon: const Icon(Icons.title),
                  ),
                  spaceBetweenFields(),
                  CustomTextField(
                    controller: _siglaController,
                    hintText: 'Sigla',
                    prefixIcon: const Icon(Icons.subtitles),
                  ),
                  spaceBetweenFields(),
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
                            onTap: () {
                              createLesion(
                                  _idmedicoController.text,
                                  _nomeController.text,
                                  _siglaController.text,
                                  _descricaoController.text);
                            },
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
