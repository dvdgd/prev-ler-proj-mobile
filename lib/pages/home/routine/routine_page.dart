import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/widgets/custom_card.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: _buildPageTitle(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 90),
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                _buildCustomCard(),
                _buildCustomCard(),
                _buildCustomCard(),
                _buildCustomCard(),
                _buildCustomCard(),
                _buildCustomCard(),
              ]),
            ),
          )
        ]),
      ),
    );
  }

  CustomCard _buildCustomCard() {
    return CustomCard(
      backgroundColor: Colors.white,
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Na Faculdade',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1,
                  ),
                ),
                Text(
                  'Criado em: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                  style: const TextStyle(fontSize: 12),
                ),
                SizedBox(
                  width: 40,
                  height: 26.6,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  '3',
                  style: TextStyle(
                    height: 1,
                    fontSize: 40,
                  ),
                ),
                const Text(
                  'Exercícios',
                  style: TextStyle(fontSize: 12, height: 1),
                ),
                SizedBox(
                  width: 28,
                  height: 28,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageTitle() {
    return const Text(
      'Minhas Rotinas',
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
