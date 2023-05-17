import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/widgets/custom_card.dart';
import 'package:prev_ler/widgets/page_title.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Adicionar'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Minhas Rotinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildCustomCard(
                  context: context,
                  title: 'Faculdade',
                  numberExercices: 5,
                  createdAt: DateTime.now(),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  CustomCard _buildCustomCard({
    required BuildContext context,
    required String title,
    required int numberExercices,
    required DateTime createdAt,
  }) {
    return CustomCard(
      backgroundColor: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10, top: 10),
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _buildTitleColunm(title, createdAt),
          ),
          _buildExercicesColumn(numberExercices),
        ],
      ),
    );
  }

  Column _buildTitleColunm(String title, DateTime createdAt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            height: 1,
          ),
        ),
        Text(
          'Criado em: ${DateFormat('dd/MM/yyyy').format(createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
        )
      ],
    );
  }

  Column _buildExercicesColumn(int numberExercices) {
    return Column(
      children: [
        Text(
          numberExercices.toString(),
          style: const TextStyle(
            height: 1,
            fontSize: 40,
          ),
        ),
        const Text(
          'Exercícios',
          style: TextStyle(
            fontSize: 14,
            height: 1,
          ),
        ),
      ],
    );
  }
}
