import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/auths/login_page.dart';
import 'package:prev_ler/pages/home/routine/routine_page.dart';
import 'package:prev_ler/services/darkmode_notifier.dart';
import 'package:prev_ler/widgets/custom_card.dart';
import 'package:prev_ler/pages/home/profile/profile_page.dart';
import 'package:prev_ler/services/auth_service.dart';
import 'package:prev_ler/widgets/page_title.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

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
        builder: (context) => ProfilePage(),
      ),
    );
  }

  Widget _buildUserHello() {
    return Consumer(builder: (context, ref, child) {
      final data = ref.watch(authDataProvider);

      return data.when(
        data: (user) {
          final userFirstName = user.name.split(' ')[0];
          return PageTitle(
            title: 'Olá, $userFirstName',
          );
        },
        error: (_, __) => const Text('Error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: _buildUserHello(),
        actions: [
          IconButton(
            onPressed: () => _navigateToProfilePage(context),
            icon: const Icon(Icons.person_outline),
          ),
          IconButton(
            onPressed: () {
              throw UnimplementedError(
                'Notifications IconButton is not implemented yet!',
              );
            },
            icon: const Icon(Icons.notifications_none_outlined),
          ),
          IconButton(
            onPressed: () {
              ref.read(darkModeProvider.notifier).toggle();
            },
            icon: darkMode
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.light_mode_outlined),
          ),
          IconButton(
            onPressed: () => _logoutAndNavigateToLoginPage(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  CustomCard(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: _buildCardContent(4, 13),
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
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent(
      int maxActivesRoutinesToday, int maxExercicesToDoToday) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoje',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$maxActivesRoutinesToday Rotinas',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  '$maxExercicesToDoToday',
                  style: const TextStyle(
                    height: 1,
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
                const Text(
                  'Exercícios',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
