import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/components/select_exercise.dart';
import 'package:prev_ler/src/modules/routines/shared/exercise_cart_controller.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_filled_loading_button.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_hour_picker.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

class RoutineFormPage extends StatelessWidget {
  RoutineFormPage({
    super.key,
    required this.title,
    this.routine,
  });

  final String title;
  final Routine? routine;

  final _formKey = GlobalKey<FormState>();

  List<Widget> get divider => [
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        ),
        const SizedBox(height: 20),
      ];

  @override
  Widget build(BuildContext context) {
    final exercisesController = context.watch<ExerciseCartController>();
    final exercises = exercisesController.value;

    return Scaffold(
      appBar: AppBar(
        title: PageTitle(title: title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Exercícios:',
                  textAlign: TextAlign.left,
                ),
              ),
              if (exercises.isNotEmpty)
                ...exercises
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SelectExercise(exercise: e),
                        ))
                    .toList()
              else
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Selecione no mínimo um exercício.'),
                ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/routines/cart/exercises'),
                child: const Text('Adicionar Exercícios'),
              ),
              ...divider,
              const SizedBox(height: 15),
              const MyTextFormField(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.title),
              ),
              const MyTextFormField(
                labelText: 'Descrição',
                prefixIcon: Icon(Icons.description),
                maxLines: 10,
                maxLength: 300,
              ),
              MyHourPicker(
                controller: TextEditingController(),
                labelText: 'Horario de inicío',
                selectedDate: TextEditingController(),
              ),
              const MyTextFormField(
                labelText: 'Horario de inicío',
                prefixIcon: Icon(Icons.alarm_on),
              ),
              const MyTextFormField(
                labelText: 'Horario de fim',
                prefixIcon: Icon(Icons.alarm_off),
              ),
              const MyTextFormField(
                labelText: 'Intervalo',
                prefixIcon: Icon(Icons.alarm),
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              MyFilledLoadingButton(
                text: 'Salvar',
                action: () async {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
