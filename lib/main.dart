// v1

// import 'package:chat2p/exemplo.dart';
import 'package:chat2p/appbar_page.dart';
import 'package:chat2p/login/login_page.dart';
// import 'package:chat2p/login/splash_page.dart';
// import 'package:chat2p/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final client = Client('Chat2P');
  final client = Client(
    'Matrix Example Chat',
    databaseBuilder: (_) async {
      final dir = await getApplicationSupportDirectory();
      final db = HiveCollectionsDatabase('matrix_example_chat', dir.path);
      await db.open();
      return db;
    },
  );
  await client.init();
  runApp(MatrixExampleChat(client: client));
}






class MatrixExampleChat extends StatelessWidget {
  final Client client;
  const MatrixExampleChat({required this.client, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat2P',
      theme: ThemeData.dark().copyWith(
        



      ),
      
      //  ThemeData(useMaterial3: false,
      // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 2, 204)),
      //   // brightness: Brightness.dark,
      //   primaryColor: Color.fromARGB(255, 123, 2, 204)),


      builder: (context, child) => Provider<Client>(
        create: (context) => client,
        child: child,
      ),
      home: client.isLogged() ? const AppBarPage() : const LoginPage(),
    );
  }
}
