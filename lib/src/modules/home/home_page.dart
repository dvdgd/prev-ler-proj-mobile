import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/home/components/logout_button.dart';
import 'package:prev_ler/src/modules/home/components/user_hello.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const UserHello(),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/profile'),
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
          const LogoutButton(),
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
                      Navigator.of(context).pushNamed('/routines');
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
