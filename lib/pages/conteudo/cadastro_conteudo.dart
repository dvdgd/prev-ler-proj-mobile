import 'package:flutter/material.dart';

void main() {
  runApp(ContentPage());
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Cadastrar Conteúdo',
              textAlign: TextAlign.left,
            ),
            FieldsConteudo(label: 'Título'),
            const SizedBox(
              height: 20,
            ),
            FieldsConteudo(label: 'Subtítulo'),
            const SizedBox(
              height: 20,
            ),
            FieldsConteudo(label: 'Título'),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
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

class FieldsConteudo extends StatelessWidget {
  final String label;
  const FieldsConteudo({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        isDense: true,
      ),
    );
  }
}
