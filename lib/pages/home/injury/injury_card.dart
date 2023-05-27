import 'package:flutter/material.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/widgets/custom_card.dart';

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
          onTap: () {},
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
}
