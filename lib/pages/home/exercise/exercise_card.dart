import 'package:flutter/material.dart';
import 'package:prev_ler/widgets/custom_card.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  final String imageUrl;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomCard(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).cardColor,
        onTap: () {},
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imageUrl),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
