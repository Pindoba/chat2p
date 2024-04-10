// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// import 'dart:js_util';

import 'package:chat2p/exemplo.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class ListSpacePage extends StatefulWidget {
  const ListSpacePage({super.key});

  @override
  State<ListSpacePage> createState() => _ListSpacePageState();
}

bool lupa = false;

class _ListSpacePageState extends State<ListSpacePage> {
  // void _logout() async {
  //   final client = Provider.of<Client>(context, Listen: false);
  //   await client.logout();
  //   Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (_) => const LoginPage()),
  //     (route) => false,
  //   );
  // }

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

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);

    // final kTabs = <Tab>[
    //   const Tab(text: 'Todos'),
    //   const Tab(text: 'Pessoal'),
    //   const Tab(text: 'Trabalho'),
    // ];

    void pesquisa(client) {
      // print(client.room.spaceChildren);
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
                texto();
              },
              icon: const Icon(Icons.close)),
          // ),
          IconButton(
            onPressed: () {
              pesquisa(client);
            },
            icon: const Icon(Icons.search),
          ),
          // )
        ],
        title: lupa == true ? TextFormField() : const Text('Espaços'),
      ),
      body: StreamBuilder(
        stream: client.onSync.stream,
        builder: (context, _) => ListView.builder(
          itemCount:
              // so_space(client.rooms),
              client.rooms.length,
          itemBuilder: (context, i) => client.rooms[i].isSpace == true
              ? Container(
                  width: 80,
                  // margin: const EdgeInsets.all(8),
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
                        // room.spaceChildren;
                      },
                      child: CircleAvatar(
                        foregroundImage: client.rooms[i].avatar == null
                            ? const NetworkImage(
                                'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                            : NetworkImage(client.rooms[i].avatar!
                                .getThumbnail(
                                  client,
                                  width: 56,
                                  height: 56,
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
                              color: const Color.fromARGB(255, 41, 173, 74),
                              child: SizedBox(
                                width: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Center(
                                      child: Text(client
                                          .rooms[i].notificationCount
                                          .toString())),
                                ),
                              ))
                      ],
                    ),
                    subtitle: Text(
                      client.rooms[i].isSpace.toString() ?? 'Sem mensagem',
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
