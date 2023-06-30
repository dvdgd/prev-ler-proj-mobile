import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';

class RoutineFormPage extends StatelessWidget {
  RoutineFormPage({
    super.key,
    required this.title,
    this.routine,
  });

  final String title;
  final Routine? routine;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PageTitle(title: title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: const Column(children: [
            SizedBox(height: 15),
            MyTextFormField(
              labelText: 'Nome',
              prefixIcon: Icon(Icons.title),
            ),
            MyTextFormField(
              labelText: 'Descrição',
              prefixIcon: Icon(Icons.description),
              maxLines: 10,
              maxLength: 300,
            ),
            MyTextFormField(
              labelText: 'Horario de inicío',
              prefixIcon: Icon(Icons.alarm_on),
            ),
            MyTextFormField(
              labelText: 'Horario de fim',
              prefixIcon: Icon(Icons.alarm_off),
            ),
            MyTextFormField(
              labelText: 'Intervalo',
              prefixIcon: Icon(Icons.alarm),
              textInputType: TextInputType.number,
            )
          ]),
        ),
      ),
    );
  }
}
