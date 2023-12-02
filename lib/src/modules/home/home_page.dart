import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/home/components/last_contents_card.dart';
import 'package:prev_ler/src/modules/home/components/last_exercises_card.dart';
import 'package:prev_ler/src/modules/home/components/logout_button.dart';
import 'package:prev_ler/src/modules/home/components/routine_resume_card.dart';
import 'package:prev_ler/src/modules/home/components/user_hello.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_contents_controller.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_exercises_controller.dart';
import 'package:provider/provider.dart';

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
            onPressed: () => Navigator.of(Routes.navigatorKey.currentContext!)
                .pushNamed('/profile'),
            icon: const Icon(Icons.person_outline),
          ),
          IconButton(
            onPressed: () => Navigator.of(Routes.navigatorKey.currentContext!)
                .pushNamed('/notifications'),
            icon: const Icon(Icons.notifications_none_outlined),
          ),
          const LogoutButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read<LastsContentsController>().fetchLastsContents(),
            context.read<LastsExercisesController>().fetchLastsExercises()
          ]);
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: const Column(
              children: [
                RoutineResumeCard(),
                SizedBox(height: 8),
                LastsExercisesCard(),
                SizedBox(height: 8),
                LastsContentsCard(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
