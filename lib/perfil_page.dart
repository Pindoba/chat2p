// import 'dart:html';
import 'dart:async';

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
    final client = Provider.of<Client>(context, listen: false);

    // Future name =  client.getProfileFromUserId(client.userID.toString());
    // Future name =  client.search(Categories(roomEvents: client.r));
    final  nam = client.getAvatarUrl(client.userID.toString());
    //  final String avatar = client.rooms.avatar == null
    //       ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
    //       : client.rooms.avatar!
    //           .getThumbnail(
    //             client,
    //             width: 55,
    //             height: 55,
    //           )
    //           .toString();
    print('name');

    void _logout() async {
      await client.logout();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Seu Perfil'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          ElevatedButton(onPressed: _logout, child: Text('Sair da conta')),
          Text('name')
        ]),
      ),
    );
  }
}
