import 'package:flutter/material.dart';
import 'package:menu_lateral/pages/home/home_page.dart';

import 'service/auth_service.dart';
import 'theme/theme_colors.dart';
import 'pages/auths/login_page.dart';

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
    HomePage(),
  ];

  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Future<void> _logoutAndNavigateToLoginPage(BuildContext context) async {
    AuthService().logout();
    _navigateToLoginPage(context);
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
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

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: Container(
        // decoration: const BoxDecoration(color: Colors.red),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Olá, Fulano',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () => _logoutAndNavigateToLoginPage(context),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
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
