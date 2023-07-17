import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/routines/components/routine_card.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_controller.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/sliver_center_text.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_silver_page_app_bar.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

final testRoutine = Routine(
  idRoutine: 1,
  idPatient: 1,
  title: "Morning Routine",
  description: "Daily morning exercises",
  startTime: const TimeOfDay(hour: 12, minute: 30),
  endTime: const TimeOfDay(hour: 17, minute: 30),
  active: true,
  createdAt: DateTime.now(),
  duration: const Duration(hours: 2),
  exercises: [
    Exercise(
      idExercise: 1,
      idMedic: 1,
      idInjuryType: 1,
      name: "Stretching",
      description: "Stretch your muscles",
      instructions: "Follow the stretching routine provided",
      image: "stretching.gif",
      precautions: "Avoid overstretching",
      observations: "Monitor any discomfort",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      medic: Medic(
        idMedic: 1,
        crmNumber: "123456",
        crmState: 'RJ',
        crmStatus: 'ativo',
      ),
      injuryType: InjuryType(
        idInjuryType: 1,
        idMedic: 1,
        name: "Muscle Strain",
        abbreviation: "MS",
        description: "Injury to the muscle or tendon",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        medic: Medic(
          idMedic: 1,
          crmNumber: "123456",
          crmStatus: "Active",
          crmState: '',
        ),
      ),
    ),
  ],
  weekdays: [
    DayOfWeek(
      idWeekday: 1,
      name: "Segunda",
    ),
    DayOfWeek(
      idWeekday: 2,
      name: "Terça",
    ),
    DayOfWeek(
      idWeekday: 3,
      name: "Quarta",
    ),
    DayOfWeek(
      idWeekday: 4,
      name: "Quinta",
    ),
    DayOfWeek(
      idWeekday: 3,
      name: "Sexta",
    ),
    DayOfWeek(
      idWeekday: 5,
      name: "Sabado",
    ),
    DayOfWeek(
      idWeekday: 6,
      name: "Domingo",
    ),
  ],
  notifications: [
    NotificationData(
      idNotification: 1,
      idRoutine: 1,
      idExercise: 1,
      title: "Morning Routine Reminder",
      message: "Don't forget to do your morning exercises",
      time: DateTime.now(),
      sent: true,
      exercise: Exercise(
        idExercise: 1,
        idMedic: 1,
        idInjuryType: 1,
        name: "Stretching",
        description: "Stretch your muscles",
        instructions: "Follow the stretching routine provided",
        image: "stretching.gif",
        precautions: "Avoid overstretching",
        observations: "Monitor any discomfort",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ),
  ],
);

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({super.key});

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  late final RoutinesController controller;

  @override
  void initState() {
    controller = context.read<RoutinesController>();
    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchAll();
      });
    }
    controller.addListener(_handleChangeState);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_handleChangeState);
    super.dispose();
  }

  _handleChangeState() {
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RoutinesController>();
    final routines = controller.routines;
    final state = controller.state;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchAll(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _appBar,
            if (routines.isEmpty)
              const SliverCenterText(
                message: 'Não existem rotinas para serem exibidas.',
              ),
            if (routines.isNotEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Outros: ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  ListView.builder(
                    itemCount: routines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: RoutineCard(routine: routines[index]),
                      );
                    },
                  )
                ]),
              )
          ],
        ),
      ),
      bottomNavigationBar:
          state == StateEnum.loading ? const LinearProgressIndicator() : null,
    );
  }

  SliverPageSearchAppBar get _appBar => SliverPageSearchAppBar(
        title: const PageTitle(title: 'Rotinas'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(Routes.navigatorKey.currentContext!).pushNamed(
              '/routines/register',
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      );
}
