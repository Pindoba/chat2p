// import 'dart:html';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat2p/appbar_page.dart';
// import 'package:chat2p/login/create_cont.dart';
import 'package:chat2p/login/splash_page.dart';
// import 'package:chat2p/exemplo.dart';
// import 'package:chat2p/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:url_launcher/url_launcher_string.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _homeserverTextField = TextEditingController(
    text: 'bolha.chat',
  );
  final TextEditingController _usernameTextField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();

  bool _loading = false;

  void _login() async {
    setState(() {
      _loading = true;
    });

    try {
      final client = Provider.of<Client>(context, listen: false);
      await client
          .checkHomeserver(Uri.https(_homeserverTextField.text.trim(), ''));
      await client.login(
        LoginType.mLoginPassword,
        password: _passwordTextField.text,
        identifier: AuthenticationUserIdentifier(user: _usernameTextField.text),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AppBarPage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        _loading = false;
      });
    }
  }
final Uri _url = Uri.parse('https://element.bolha.chat/#/register', );



  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

  @override
  Widget build(BuildContext context) {

    const colorizeColors = [
  Color.fromARGB(255, 86, 0, 136),
  Colors.white,
  Color.fromARGB(255, 140, 0, 255),
  Color.fromARGB(255, 43, 11, 187),
];

const colorizeTextStyle = TextStyle(
  fontSize: 40.0,
  // fontFamily: GoogleFonts,
  fontFamily: 'Horizon',

);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Image.asset('assets/logo.png',fit: BoxFit.scaleDown,)),
              
              
              
              
              Center(
          child: Container(
            // color: const Color.fromARGB(255, 63, 63, 63),
          // width: double.infinity,
          // height: double.infinity,
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
               
            },
              ),
          ),
          ),
          )
              
              
              
              ,
              TextField(
                controller: _homeserverTextField,
                readOnly: _loading,
                autocorrect: false,
                decoration: const InputDecoration(
                  prefixText: 'https://',
                  border: OutlineInputBorder(),
                  labelText: 'Instância',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _usernameTextField,
                readOnly: _loading,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome de usuário',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordTextField,
                readOnly: _loading,
                autocorrect: false,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  child: _loading
                      ? const LinearProgressIndicator()
                      : const Text('Entrar'),
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       // Navigator.push(context,
              //       //     MaterialPageRoute(builder: (context) => CreateCont()));
              //       _launchUrl();
              //     },
              //     child: const Text('Criar uma conta no bolha.chat')),
        
                  Link(
                  uri: Uri.parse('https://element.bolha.chat/#/register'),
                  target: LinkTarget.self,
                  builder: (BuildContext ctx, FollowLink? openLink) {
                    return TextButton.icon(
                      onPressed: openLink,
                      label: const Text('Criar conta no bolha.chat'),
                      icon: const Icon(Icons.app_registration),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
