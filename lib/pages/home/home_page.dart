import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/pages/home/routine_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 75),
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
                RoutineCardOld(currentDate: DateTime.now(), title: 'title'),
                const SizedBox(height: 15),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
