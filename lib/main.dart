// v1

// import 'package:chat2p/exemplo.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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




final meuTema = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(174, 56, 56, 56),
    
    
    ),
  primaryColor: Color.fromARGB(255, 34, 39, 38), // Cor principal
  hintColor: Colors.amber, // Cor de destaque
  splashColor: Colors.black45,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: 1)
  // Outras configurações de estilo, como fontes, tamanhos, etc.
);

class InitChat extends StatelessWidget {
  final Client client;

  const InitChat({required this.client, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat2P',
      theme: meuTema,
      // theme: ThemeData.dark().copyWith(),

      //  ThemeData(useMaterial3: false,
      // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 2, 204)),
      //   // brightness: Brightness.dark,
      //   primaryColor: Color.fromARGB(255, 123, 2, 204)),

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

class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 80.0,
      fontFamily: 'Horizon',
    );

    // return
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 63, 63, 63),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Chat2P',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                  speed: const Duration(seconds: 2),
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppBarPage(
                              client: client,
                            )));
              },
            ),
          ),
        ),
      ),
    );
  }
}
