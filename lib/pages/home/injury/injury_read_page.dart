import 'package:flutter/material.dart';
import 'package:prev_ler/entities/injury_type.dart';
import 'package:prev_ler/widgets/page_title.dart';

class InjuryRead extends StatelessWidget {
  const InjuryRead(this.injuryType, {super.key});

  final InjuryType injuryType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Detalhes da lesão'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(injuryType.name),
              subtitle: Text('Sigla: ${injuryType.abbreviation}'),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 10),
              child: Text(
                injuryType.description,
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
    );
  }
}
