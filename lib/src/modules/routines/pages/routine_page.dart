import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/components/routine_card.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/entities/medic.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/my_page_title.dart';

final testRoutine = Routine(
  idRoutine: 1,
  idPatient: 1,
  title: "Morning Routine",
  description: "Daily morning exercises",
  startTime: "8:00 AM",
  endTime: "9:00 AM",
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
      encodedGif: "stretching.gif",
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
      time: "8:00 AM",
      sent: true,
      exercise: Exercise(
        idExercise: 1,
        idMedic: 1,
        idInjuryType: 1,
        name: "Stretching",
        description: "Stretch your muscles",
        instructions: "Follow the stretching routine provided",
        encodedGif: "stretching.gif",
        precautions: "Avoid overstretching",
        observations: "Monitor any discomfort",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ),
  ],
);

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(title: 'Minhas Rotinas'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: RoutineCard(routine: testRoutine),
            );
          },
        ),
      ),
    );
  }
}
