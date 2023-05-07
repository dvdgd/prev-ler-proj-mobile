import 'package:flutter/material.dart';
import 'package:menu_lateral/widgets/custom_dropdown_button.dart';
import 'package:menu_lateral/widgets/custom_text_field.dart';

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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: const Text(
              'Cadastrar Conteúdo',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
            width: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(controller: _tituloController, hintText: 'Título'),
                  const SizedBox(
                    height: 15,
                    width: 15,
                  ),
                  CustomTextField(
                    controller: _subtituloController,
                    hintText: 'Subtítulo',
                  ),
                  const SizedBox(
                    height: 15,
                    width: 15,
                  ),
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
                    width: 15,
                  ),
                  TextField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                        ),
                      ),
                    ),
                    maxLines: 4),
                  const SizedBox(
                    height: 15,
                    width: 15,
                  ),
                  ElevatedButton(
                    child: const Text('Salvar'),
                    onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Lesões',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Conteúdo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exerc.',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}