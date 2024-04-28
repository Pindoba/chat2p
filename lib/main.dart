
import 'package:chat2p/appbar_page.dart';
import 'package:chat2p/login/login_page.dart';
import 'package:chat2p/style/theme.dart';


import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('inicio do main');
  final client = Client(
    'Chat2P',
    databaseBuilder: (_) async {
      final dir = await getApplicationSupportDirectory();
      final db = HiveCollectionsDatabase('Chat2P', dir.path);
      await db.open();
      return db;
    },
  );
  print('esperando o cliente');

  await client.init();
  print('cliente finalizado');
  print(client.userID);

  runApp(InitChat(client: client));
}


class InitChat extends StatelessWidget {
  final Client client;

  const InitChat({required this.client, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Chat2P',
      theme: meuTema,
      builder: (context, child) => Provider<Client>(
        create: (context) => client,
        child: child,
      ),
      home: client.isLogged()
          ? AppBarPage(
              client: client,
            )
          : const LoginPage(),
    );
  }
}

