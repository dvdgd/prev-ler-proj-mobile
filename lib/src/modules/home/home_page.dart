import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/home/components/logout_button.dart';
import 'package:prev_ler/src/modules/home/components/routine_resume_card.dart';
import 'package:prev_ler/src/modules/home/components/user_hello.dart';

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
      body: const Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [RoutineResumeCard()],
        ),
      ),
    );
  }
}
