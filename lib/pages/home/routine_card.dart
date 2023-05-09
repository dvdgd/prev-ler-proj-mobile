import 'package:flutter/material.dart';

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
        children: const [],
      ),
    );
  }
}
