// import 'dart:html';
import 'dart:async';

import 'package:chat2p/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    final String avatar = client.getAvatarUrl(client.userID.toString()) != null
        ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
        : client.getAvatarUrl(client.userID.toString()).toString();
    // .getThumbnail(
    //   client,
    //   width: 50,
    //   height: 50,
    // )
    // .toString();

    // Future name =  client.getProfileFromUserId(client.userID.toString());
    // Future name =  client.search(Categories(roomEvents: client.r));
    // final nam = client.getAvatarUrl(client.userID.toString());
    //  final String avatar = client.rooms.avatar == null
    //       ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
    //       : client.rooms.avatar!
    //           .getThumbnail(
    //             client,
    //             width: 55,
    //             height: 55,
    //           )
    //           .toString();

    // print('name');

    void _handleImageSelection() async {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: ImageSource.gallery,
      );

      if (result != null) {
        final bytes = await result.readAsBytes();
        client.setAvatar(MatrixFile(bytes: bytes, name: 'name'));
        // final image = await decodeImageFromList(bytes);

        // var _user = null;
        // final message = types.ImageMessage(
        //   author: _user,
        //   createdAt: DateTime.now().millisecondsSinceEpoch,
        //   height: image.height.toDouble(),
        //   id: const Uuid().v4(),
        //   name: result.name,
        //   size: bytes.length,
        //   uri: result.path,
        //   width: image.width.toDouble(),
        // );

        // _image(bytes, 'foto.jpg');

        // _addMessage(message);
        // widget.room.sendFileEvent(
        //     MatrixImageFile(bytes: Uint8List.fromList(List<int> message.size), name: message.name));
      }
    }

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
          Image.network(avatar),
          ElevatedButton(onPressed: _logout, child: Text('Sair da conta')),
          ElevatedButton(
              onPressed: () {
                _handleImageSelection();
              },
              child: Text('Alterar avatar'))
        ]),
      ),
    );
  }
}
