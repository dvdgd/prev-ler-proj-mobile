import 'package:flutter/material.dart';
import 'package:prev_ler/pages/home/content/management_content_page.dart';
import 'package:prev_ler/pages/home/home_page.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  final List _pages = const [
    HomePage(),
    HomePage(),
    HomePage(),
    ManagementContentPage(),
  ];

  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 0.1,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _pages[currentPage],
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: _buildCardBottom(context),
          ),
        ],
      ),
    );
  }

  Card _buildCardBottom(BuildContext context) {
    var borderRadius = BorderRadius.circular(20);

    return Card(
      elevation: 8,
      shadowColor: ThemeColors().purpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          height: 65,
          child: _buildBottomNavigationBar(context),
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    final selectedItemColor = Theme.of(context).primaryColor;
    final unselectedItemColor = Colors.grey.shade500;

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      onTap: tappedPage,
      currentIndex: currentPage,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedLabelStyle: TextStyle(color: selectedItemColor),
      unselectedLabelStyle: TextStyle(color: unselectedItemColor),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Lesões',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Exercício',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Conteúdo',
        ),
      ],
    );
  }
}
