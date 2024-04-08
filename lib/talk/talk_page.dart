// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:chat2p/buscar_page.dart';
import 'package:chat2p/exemplo.dart';
import 'package:chat2p/menu_radial.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _TalkPageState();
}

bool lupa = false;

class _TalkPageState extends State<TalkPage> {
  void _join(Room room) async {
    if (room.membership != Membership.join) {
      await room.join();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RoomPage(room: room),
      ),
    );
  }

  void _leave(Room room) async {
    if (room.membership != Membership.leave) {
      await room.leave();
      Navigator.pop(context);
    }
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (_) => RoomPage(room: room),
    //   ),
  }

  final TextEditingController _addController = TextEditingController();
  List<String> pin = ["\$NcVV2A6894exHh5yc6uDzTb01O382nD20YZHN2Bkn4Y"];
  void _create(Client client) async {
    String iduser = _addController.text.trim();
    // room.addToDirectChat('@weltonmoura:nitro.chat');
    // room.setPinnedEvents(pin);
    List<String> invite = [];
    invite.add(iduser);
    client.createRoom(
      preset: CreateRoomPreset.privateChat,
      invite: invite,
      isDirect: true,
    );
    _addController.clear();
    // client.setRoomAlias(client.getDisplayName(invite[0]).toString(), room.id);

    // print(invite[0]);
    // print(room.id);
    // print(client.queryUserByID(invite[0]));
    // print(client.queryPublicRooms());
    // room.invite('@weltonmoura:nitro.chat');
    // client.createGroupChat(preset: CreateRoomPreset.privateChat,invite: invite);

    // if (room.membership != Membership.leave) {
    //   await room.leave();
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);

    void pesquisa() {
      setState(() {
        lupa = true;
      });
    }

    void texto() {
      setState(() {
        lupa = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 123, 2, 204),
        actions: [
          // Visibility(
          //   visible: lupa,
          // child:
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                _create(client);
              },
              icon: lupa == true ? const Icon(
                Icons.add,
              ): Text(''),),

          // ),
          IconButton(
            onPressed: lupa != true
                ? () {
                    pesquisa();
                  }
                : () {
                    texto();
                  },
            icon: lupa == true
                ? const Icon(
                    Icons.close,
                  )
                : const Icon(Icons.group_add_sharp),
          ),
        ],
        title: lupa == true
            ? TextField(
                decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Id do usuário',
                    hintText: '@usuario:servidor.com'),
                controller: _addController,
              )
            : const Text('Conversas'),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: lupa == true
      //     ? FloatingActionButton(
      //         backgroundColor: Colors.amber,
      //         onPressed: () {
      //           _create(client);
      //           // showBottomSheet(
      //           //     context: context,
      //           //     builder: (BuildContext context) => BuscarPage());
      //         },
      //         child: Icon(
      //           Icons.add,
      //           color: Colors.black,
      //         ),
      //       )
      //     : Text(''),
      body: StreamBuilder(
        stream: client.onSync.stream,
        builder: (context, _) => ListView.builder(
          itemCount: client.rooms.length,
          itemBuilder: (context, i) => client.rooms[i].isSpace == false
              ? Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(153, 123, 2, 204),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                            offset: Offset(
                              0.0,
                              0.3,
                            ))
                      ]),
                  child: ListTile(
                    leading: GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:
                                Text('Sair da ${client.rooms[i].displayname}?'),
                            content: const Text(
                                'Com essa ação você vai sair e apagar o chat.'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'cancel'),
                                  child: const Text('Cancelar')),
                              TextButton(
                                  onPressed: () => _leave(client.rooms[i]),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      Text('Sair e apagar'),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                      child: CircleAvatar(
                        foregroundImage: client.rooms[i].avatar == null
                            ? const NetworkImage(
                                'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                            : NetworkImage(client.rooms[i].avatar!
                                .getThumbnail(
                                  client,
                                  width: 60,
                                  height: 60,
                                )
                                .toString()),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(child: Text(client.rooms[i].displayname)),
                        if (client.rooms[i].notificationCount > 0)
                          Material(
                              elevation: 8,
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.amber,
                              child: SizedBox(
                                width: 35,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Center(
                                      child: Text(
                                    client.rooms[i].notificationCount
                                        .toString(),
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                              ))
                      ],
                    ),
                    subtitle: Text(
                      // client.rooms[i]. ?? 'Sem mensagem',
                      client.rooms[i].typingUsers.toString() != '[]'
                          ? 'Digitando...'
                          :

                          // 'Sem mensagem',
                          client.rooms[i].lastEvent?.body ?? 'Sem mensagem',
                      maxLines: 1,
                    ),
                    onTap: () => _join(client.rooms[i]),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
