// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:chat2p/buscar_page.dart';
import 'package:chat2p/exemplo.dart';
import 'package:chat2p/menu_radial.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

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
      Navigator.pop(context);
    }
  }

  dynamic _option(context, Room room) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Opções'),
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Apagar'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text('Apagar conversa?'),
                        content: Text(''),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar')),
                          TextButton(
                              onPressed: () {
                                _leave(room);
                              },
                              child: Text("Apagar"))
                        ],
                      ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Reenviar'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Editar'),
            onTap: () => Navigator.pop(context, 'Add account'),
          ),
        ],
      ),
    ).then((returnVal) {
      if (returnVal != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You clicked: $returnVal'),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    });
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
    // print(await client.queryPublicRooms());
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

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/f2.png'),
        
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Color.fromARGB(151, 0, 0, 0),
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
              icon: lupa == true
                  ? const Icon(
                      Icons.add,
                    )
                  : Text(''),
            ),
      
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            // BuscarPage(client: client);
            showBottomSheet(
                context: context,
                builder: (BuildContext context) => BuscarPage(
                      client: client,
                    ));
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      
        body: StreamBuilder(
          stream: client.onSync.stream,
          builder: (context, _) => ListView.builder(
            itemCount: client.rooms.length,
            itemBuilder: (context, i) => client.rooms[i].isSpace == false
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(0),
                        // decoration: BoxDecoration(
                        //     // color: const Color.fromARGB(153, 123, 2, 204),
                        //     borderRadius: BorderRadius.circular(5),
                        //     boxShadow: const <BoxShadow>[
                        //       BoxShadow(
                        //           color: Color.fromARGB(141, 0, 0, 0),
                        //           blurRadius: 3,
                        //           offset: Offset(
                        //             0.0,
                        //             0.3,
                        //           ))
                        //     ]),
                        child: ListTile(
                          subtitleTextStyle: TextStyle(color: client.rooms[i].typingUsers.toString() != '[]' ? Colors.amber : Colors.white),
                          leading: GestureDetector(
                            onTap: client.rooms[i].avatar != null
                                ? () => _modal(
                                    context,
                                    client.rooms[i].avatar!
                                        .getDownloadLink(
                                          client,
                                        )
                                        .toString())
                                : () {
                                    
                                  },
                            child: CircleAvatar(
                              foregroundImage: client.rooms[i].avatar == null
                                  ? const NetworkImage(
                                      'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                                  : NetworkImage(client.rooms[i].avatar!
                                      .getThumbnail(
                                        client,
                                        width: 60,
                                        height: 80,
                                      )
                                      .toString()),
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(child: Text(client.rooms[i].displayname,maxLines: 2,)),
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
                            client.rooms[i].typingUsers.toString() != '[]'
                                ? 'Digitando...'
                                : client.rooms[i].lastEvent?.body ??
                                    'Sem mensagem',
                            maxLines: 1,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _option(context, client.rooms[i]);
                              },
                              icon: const Icon(
                                Icons.more_vert,
                              )),
                          onTap: () => _join(client.rooms[i]),
                        ),
                      ),
                      Divider()
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}

void _modal(BuildContext context, avatar) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => Scaffold(
        appBar: AppBar(
          title: const Text('Avatar'),
        ),
        body: Center(
          child: Image.network(avatar),
        ),
      ),
    ),
  );
}
