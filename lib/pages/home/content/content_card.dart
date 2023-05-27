import 'package:flutter/material.dart';
import 'package:prev_ler/entities/content.dart';
import 'package:prev_ler/widgets/custom_card.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({Key? key, required this.content}) : super(key: key);

  final Content content;

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
                  content.title,
                  style: const TextStyle(fontSize: 16, height: 1),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 7),
                Text(
                  content.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Enfermidade: ${content.injuryType?.name ?? 'Não informada'}',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
