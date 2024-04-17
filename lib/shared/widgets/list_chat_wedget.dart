import 'package:chat2p/channel/canal_chat_wedget.dart';
import 'package:chat2p/room_page.dart';
// import 'package:chat2p/room_page.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';
import 'dart:math' as math;

class ListChat extends StatelessWidget {
  const ListChat({super.key, required this.room, required this.client});
  final Room room;
  final Client client;

  @override
  Widget build(BuildContext context) {
    final String name = room.displayname;
    final String last_msg = room.lastEvent?.body ?? 'Sem mensagem';
    final String avatar = room.avatar == null
        ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
        : room.avatar!
            .getThumbnail(
              client,
              width: 50,
              height: 50,
            )
            .toString();

    return GestureDetector(
      onTap: () {
        _join(room, context);
      },
      child: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: room.avatar != null
                          ? () => _modal(
                              context,
                              room.avatar!
                                  .getDownloadLink(
                                    client,
                                  )
                                  .toString())
                          : () {},
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(avatar),
                      ),
                    )),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                style: TextStyle(fontSize: 16),
                                name,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                textAlign: TextAlign.start,
                                softWrap: false,
                              ),
                            ),
                            if (room.notificationCount > 0)
                              Material(
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.amber,
                                  child: SizedBox(
                                    width: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                          child: Text(
                                        room.notificationCount.toString(),
                                        style: TextStyle(color: Colors.black),
                                      )),
                                    ),
                                  ))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.check),
                            Expanded(
                              child: Text(
                                last_msg,
                                maxLines: 1,
                                style: TextStyle(color: Colors.white54),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      PopupMenuButton<int>(
                        shadowColor: Colors.amber,
                        color: Theme.of(context).primaryColor,
                        elevation: 5,
                        itemBuilder: (context) => [
                          PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                room.isFavourite == true
                                    ? const Icon(Icons.block)
                                    : const Icon(Icons.push_pin),
                                    SizedBox(width: 8,),
                                room.isFavourite == true
                                    ? const Text('Desafixar')
                                    : Text("Fixar"),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.change_circle_rounded),
                                SizedBox(width: 8,),
                                Text('Modo canal')
                                    
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 3,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red
                                ),
                                SizedBox(width: 8),
                                Text('Apagar conversa'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              _pin(room, context);
                              break;
                            case 2:
                              _transforme_canal(room);
                              break;
                            case 3:
                              _confirme( context, room);
                              break;
                          }
                        },
                      ),


                      room.isFavourite
                          ? Transform.rotate(
                              angle: 45 * math.pi / 180,
                              child: const Icon(Icons.push_pin,
                                  size: 20,
                                  color:
                                      Color.fromARGB(255, 141, 141, 141)),
                            )
                          : Text(''),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}

void _transforme_canal(Room room) {
  if (room.tags.entries.toString().contains('channel') == false) {
    room.addTag('channel');
  } else {
    room.removeTag('channel');
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

void _confirme(context,room) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('Apagar conversa?'),
            content: Text(''),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    _leave(room, context);
                    Navigator.pop(context);
                  },
                  child: Text("Apagar"))
            ],
          )
          );
}

void _join(Room room, context) async {
  if (room.membership != Membership.join) {
    await room.join();
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) =>
          // room.tags.entries.toString().contains('channel') == true ?
          // CanalPageChat(room: room)
          // :
          RoomPage(room: room),
    ),
  );
}

void _pin(Room room, context) async {
  if (room.isFavourite == false) {
    await room.setFavourite(true);
  } else {
    await room.setFavourite(false);
  }
}

void _leave(Room room, context) async {
  if (room.membership != Membership.leave) {
    await room.leave();
  }
}
