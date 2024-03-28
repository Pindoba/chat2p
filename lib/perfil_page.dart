// import 'dart:html';

import 'package:chat2p/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {


    void _logout() async {
  final client = Provider.of<Client>(context, listen: false);
  await client.logout();
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (route) => false,
  );
}
    return 
    
    Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 123, 2, 204),
      title: Text('Seu Perfil'),),
      
      body: Center(
        child: Column(children: [
          ElevatedButton(onPressed: _logout, child: Text('Sair da conta')),
          Text('perfil')
        ]),
      ),
    )
    
    
    
    ;
  }
}