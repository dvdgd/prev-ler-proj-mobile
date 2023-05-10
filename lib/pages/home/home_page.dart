import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/auths/login_page.dart';
import 'package:prev_ler/pages/home/routine/routine_page.dart';
import 'package:prev_ler/widgets/custom_card.dart';
import 'package:prev_ler/pages/home/profile/profile_page.dart';
import 'package:prev_ler/service/auth_service.dart';
import 'package:prev_ler/widgets/page_title.dart';

import '../../theme/theme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logoutAndNavigateToLoginPage(BuildContext context) async {
    AuthService().logout();
    _navigateToLoginPage(context);
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  Widget _buildUserHello() {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(authDataProvider);

      return data.when(
        data: (user) {
          final userFirstName = user.name.split(' ')[0];
          return Expanded(
            child: PageTitle(
              title: 'Olá, $userFirstName',
            ),
          );
        },
        error: (_, __) => const Text('Error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget _buildCardContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hoje',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '3 Rotinas',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: const [
                  Text(
                    '15',
                    style: TextStyle(
                      height: 1,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'Exercícios',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildUserHello(),
                IconButton(
                  onPressed: () => _navigateToProfilePage(context),
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_outlined),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _logoutAndNavigateToLoginPage(context),
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90),
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                CustomCard(
                  backgroundColor: ThemeColors().blue,
                  child: _buildCardContent(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoutinePage(),
                      ),
                    );
                  },
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
