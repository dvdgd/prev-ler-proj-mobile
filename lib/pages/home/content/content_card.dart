import 'package:flutter/material.dart';
import 'package:prev_ler/widgets/custom_button.dart';
import 'package:prev_ler/widgets/custom_card.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: CustomCard(
          backgroundColor: Theme.of(context).colorScheme.background,
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Como previnir a tendinite',
                style: TextStyle(fontSize: 16, height: 1),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 7),
              Text(
                'Não ficar muito tempo na mesma posição é muito importante. Por exemplo, quem trabalha em pé ou sentado deve procurar se movimentar ou mudar de posição a cada 30 minutos.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Enfermidade: Tendinite',
                style: TextStyle(fontSize: 11),
              ),
            ],
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
          'Deseja realmente apagar este conteúdo?',
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
