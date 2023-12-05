import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/contents/pages/content_page.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_page.dart';
import 'package:prev_ler/src/modules/home/home_page.dart';
import 'package:prev_ler/src/modules/injuries/pages/injury_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.page});

  final dynamic page;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const InjuryPage(),
    const ExercisePage(),
    const ContentPage(),
  ];

  void _tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  void initState() {
    final searchElement = _pages.indexWhere(
      (page) => page.toString() == widget.page.toString(),
    );
    final index = searchElement >= 0 ? searchElement : 0;

    currentPage = index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 0.1,
      ),
      body: _pages[currentPage],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: _tappedPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services_outlined),
            selectedIcon: Icon(Icons.medical_services),
            label: 'Lesões',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Exercícios',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: 'Conteúdos',
          ),
        ],
      ),
    );
  }
}
