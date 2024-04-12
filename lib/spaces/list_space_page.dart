// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// import 'dart:js_util';

// import 'dart:js_util';

import 'package:chat2p/exemplo.dart';
import 'package:chat2p/shared/widgets/list_chat_wedget.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class ListSpacePage extends StatefulWidget {
  const ListSpacePage({super.key});

  @override
  State<ListSpacePage> createState() => _ListSpacePageState();
}

class _ListSpacePageState extends State<ListSpacePage> {
  void _join(Room room) async {
    // print(room.spaceChildren);
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
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 123, 2, 204),
        title: const Text('Espaços'),
      ),
      body: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: client.onSync.stream,
              builder: (context, _) => ListView.builder(
                itemCount: client.rooms.length,
                itemBuilder: (context, i) => client.rooms[i].isSpace == true
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ListSpace(room: client.rooms[i], client: client),
                      )
                    : Container(),
              ),
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3,
                    offset: Offset(
                      0.0,
                      0.3,
                    ),
                  )
                ],
                color: Color.fromARGB(255, 54, 54, 54),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              width: 300,
              margin: EdgeInsets.only(top: 15, right: 10),
              height: double.infinity,
              child: ListView.builder(
                  itemCount: client.rooms.length,
                  itemBuilder: (context, i) => Column(
                        children: [
                          ListTile(
                            title: GestureDetector(
                              onTap: () {
                                _join(client.rooms[i]);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.group),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    client.rooms[i].displayname,
                                    maxLines: 1,
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      )))
        ],
      ),
    );
  }
}

class ListSpace extends StatelessWidget {
  const ListSpace({super.key, required this.room, required this.client});
  final Room room;
  final Client client;

  @override
  Widget build(BuildContext context) {
    void _filhos(Room room) async {
      var roomfilho = await room.spaceChildren;

      print(roomfilho);
    }
    // room.addTag('tag');
    // room.addToDirectChat(userID)

    final String last_msg = room.lastEvent?.body ?? 'Sem mensagem';
    final String avatar = room.avatar == null
        ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
        : room.avatar!
            .getThumbnail(
              client,
              width: 55,
              height: 55,
            )
            .toString();

    return GestureDetector(
      onTap: () {
        _join(room, context);
      },
      child: Container(
        width: 80,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                width: 55,
                height: 55,
                child: GestureDetector(
                  onTap: () {
                    _filhos(room);
                  },
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(avatar),
                  ),
                )),
            Divider(),
          ],
        ),
      ),
    );
  }
}

void _join(Room room, context) async {
  print(room.spaceChildren);
  if (room.membership != Membership.join) {
    await room.join();
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => RoomPage(room: room),
    ),
  );
}
