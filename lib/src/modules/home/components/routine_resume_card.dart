import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/routines_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class RoutineResumeCard extends StatefulWidget {
  const RoutineResumeCard({super.key});

  @override
  State<RoutineResumeCard> createState() => _RoutineResumeCardState();
}

class _RoutineResumeCardState extends State<RoutineResumeCard> {
  late final RoutinesController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<RoutinesController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.fetchAll();
    });
    controller.addListener(_handleChangeState);
  }

  @override
  void dispose() {
    controller.removeListener(_handleChangeState);
    super.dispose();
  }

  _handleChangeState() {
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  List<Routine> _filterActiveRoutinesToday(List<Routine> routines) {
    int weekdayIdx = DateTime.now().weekday;
    final dayOfWeek = daysOfWeek.firstWhere((d) => d.idWeekday == weekdayIdx);
    final filtredRoutines = routines
        .where((routine) => routine.weekdays?.contains(dayOfWeek) ?? false)
        .where((routine) => routine.active)
        .toList();

    return filtredRoutines;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutinesController>();
    final routines = _filterActiveRoutinesToday(controller.routines);
    final isSucess = controller.state == StateEnum.success;

    final maxActivesRoutinesToday = routines.length;
    final maxExercicesToDoToday = routines
        .map((r) => r.exercises?.length ?? 0)
        .fold(0, (prev, curr) => prev += curr);

    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          MyCard(
            padding: const EdgeInsets.all(20),
            backgroundColor: Theme.of(context).primaryColor,
            child: Column(
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
                            isSucess
                                ? '$maxActivesRoutinesToday Rotinas'
                                : '-- Rotinas',
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
                          isSucess ? '$maxExercicesToDoToday' : '--',
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
            ),
            onTap: () => Navigator.of(Routes.navigatorKey.currentContext!)
                .pushNamed('/routines'),
          ),
        ]),
      ),
    );
  }
}
