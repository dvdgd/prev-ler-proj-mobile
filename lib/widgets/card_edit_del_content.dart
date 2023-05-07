import 'package:flutter/material.dart';

void main() {
  runApp(const CardExamplesApp());
}

class CardExamplesApp extends StatelessWidget {
  const CardExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Examples')),
        body: Column(
          children: const <Widget>[
            Spacer(),
            CardEditDeleteContent(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class CardEditDeleteContent extends StatelessWidget {
  const CardEditDeleteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: Card(
          color: const Color.fromARGB(255, 227, 232, 237),
          elevation: 3,
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 158, 173, 186),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Como prevenir a tendinite',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Não ficar muito tempo na mesma posição é muito importante. Por exemplo, quem trabalha em pé ou sentado deve procurar se movimentar ou mudar de posição a cada 30 minutos.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          //função a ser executada quando o ícone for clicado
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //função a ser executada quando o ícone for clicado
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit_note_sharp,
                              color: Color.fromARGB(255, 112, 112, 112),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
