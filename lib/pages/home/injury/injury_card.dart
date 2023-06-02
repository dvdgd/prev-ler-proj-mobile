import 'package:flutter/material.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/widgets/custom_card.dart';

import '../../../widgets/custom_option_button.dart';

class InjuryCard extends StatelessWidget {
  const InjuryCard({Key? key, required this.injury}) : super(key: key);

  final InjuryType injury;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onTap: () {
            _showOptions(context, key);
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(injury.name),
                  subtitle: Text('Sigla: ${injury.abbreviation}'),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Text(
                    injury.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
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

  void _showOptions(BuildContext context, ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OptionButton(
                    title: 'Editar',
                    pressedFunction: () {},
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  OptionButton(
                    title: 'Deletar',
                    pressedFunction: () {},
                    icon: const Icon(Icons.delete_forever_outlined),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
