import 'package:flutter/material.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_card.dart';

class InjuryCard extends StatelessWidget {
  const InjuryCard({Key? key, required this.injury}) : super(key: key);

  final InjuryType injury;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {},
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  injury.name,
                  style: const TextStyle(fontSize: 16, height: 1),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 7),
                Text(
                  injury.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> warningRemoveContent(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(child: Text('Atenção!')),
        content: const Text(
          'Deseja realmente apagar esta lesão?',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomButton(
                    buttonColor: Colors.pink,
                    text: 'Cancelar',
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context, 'Cancelar');
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: CustomButton(
                    text: 'Confirmar',
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context, 'Confirmar');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
