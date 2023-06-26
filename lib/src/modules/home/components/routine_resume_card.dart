import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';

class RoutineResumeCard extends StatelessWidget {
  const RoutineResumeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          MyCard(
            padding: const EdgeInsets.all(20),
            backgroundColor: Theme.of(context).primaryColor,
            child: _buildCardContent(4, 13),
            onTap: () => Navigator.of(context).pushNamed('/routines'),
          ),
        ]),
      ),
    );
  }

  Widget _buildCardContent(
    int maxActivesRoutinesToday,
    int maxExercicesToDoToday,
  ) {
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
