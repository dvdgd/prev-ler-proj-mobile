import 'package:flutter/material.dart';
import '../../../widgets/custom_text_field.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: prefer_final_fields
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Gerenciamento de lesões',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "Buscar lesão",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.filter_alt,
                  color: Colors.deepPurple,
                  size: 40,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.deepPurple,
            unselectedFontSize: 11,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            selectedLabelStyle: const TextStyle(color: Colors.white),
            unselectedLabelStyle: const TextStyle(color: Colors.white),
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Lesões',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                label: 'Conteúdos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Gym',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
