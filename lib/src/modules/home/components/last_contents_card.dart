import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/contents/pages/content_datails_page.dart';
import 'package:prev_ler/src/modules/home/shared/lasts_contents_controller.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class LastsContentsCard extends StatefulWidget {
  const LastsContentsCard({super.key});

  @override
  State<LastsContentsCard> createState() => _LastsContentsCardState();
}

class _LastsContentsCardState extends State<LastsContentsCard> {
  @override
  void initState() {
    super.initState();

    final controller = context.read<LastsContentsController>();

    if (controller.state == StateEnum.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.fetchLastsContents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LastsContentsController>();
    final contents = controller.contents;
    final state = controller.state;

    final textColor = Theme.of(context).colorScheme.onTertiaryContainer;

    return MyCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Últimos Conteúdos!',
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            if (state == StateEnum.loading)
              Padding(
                padding: const EdgeInsets.all(90),
                child: Center(
                  child: CircularProgressIndicator(
                    color: textColor,
                  ),
                ),
              ),
            if (state == StateEnum.error)
              SizedBox(
                child: Text(controller.errorMessage),
              ),
            if (contents.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Não existem conteúdos cadastrados.',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            if (contents.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final content = contents[index];
                  return ListTile(
                    iconColor: textColor,
                    textColor: textColor,
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(content.title),
                    subtitle: Text(
                      content.description,
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize:
                            Theme.of(context).textTheme.bodySmall!.fontSize,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_right_sharp),
                      onPressed: () {
                        Navigator.of(Routes.navigatorKey.currentContext!).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ContentDetailsPage(
                              content,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: contents.length,
              ),
          ],
        ),
      ),
    );
  }
}
