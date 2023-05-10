import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          color: const Color.fromARGB(255, 237, 231, 254),
          elevation: 3,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 158, 173, 186),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Center(child: Text('Atenção!')),
                                content: const Text(
                                  'Deseja realmente apagar este conteúdo?',
                                  textAlign: TextAlign.center,
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancelar'),
                                        child: const Text('Cancelar'),
                                      ),
                                      const SizedBox(width: 50),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Confirmar'),
                                        child: const Text('Confirmar'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            fixedSize: const Size.fromHeight(45),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            // Ação a ser executada quando o botão for pressionado
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            fixedSize: const Size.fromHeight(45),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.edit_note_sharp,
                                color: Colors.grey[700],
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                            ],
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

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
