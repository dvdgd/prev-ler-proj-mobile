import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutineCardOld extends StatelessWidget {
  final DateTime currentDate;
  final String title;

  const RoutineCardOld({
    super.key,
    required this.currentDate,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var boxShadow = BoxShadow(
      color: Colors.black.withOpacity(0.7),
      blurStyle: BlurStyle.outer,
      blurRadius: 4,
      offset: const Offset(1, 2), // Shadow position
    );

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [boxShadow],
        borderRadius: BorderRadius.circular(25),
      ),
      height: 170,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(currentDate),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Criado em: 1234',
                  )
                ],
              ),
              Column(
                children: const [
                  Text(
                    '5',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'Exercícios',
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
