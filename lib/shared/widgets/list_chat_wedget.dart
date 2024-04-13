import 'package:chat2p/channel/canal_chat_wedget.dart';
import 'package:chat2p/room_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';

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
              width: 55,
              height: 55,
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
                    width: 55,
                    height: 55,
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
                                style: TextStyle(fontSize: 18),
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
                      IconButton(
                          onPressed: () {
                            _option(context, room);
                          },
                          icon: Icon(Icons.more_vert)),
                      room.isFavourite
                          ? Icon(Icons.push_pin,
                              color: const Color.fromARGB(255, 141, 141, 141))
                          : Text(''),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

void _transforme_canal(Room room) {
  room.addTag('channel');
  // print('funcao canal executado');
  // room.removeTag('canal');
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
                              _leave(room, context);
                            },
                            child: Text("Apagar"))
                      ],
                    ));
          },
        ),
        ListTile(
          leading: room.isFavourite == true
              ? const Icon(Icons.block)
              : const Icon(Icons.push_pin),
          title: room.isFavourite == true
              ? const Text('Desafixar')
              : Text("Fixar"),
          onTap: () {
            _pin(room, context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('T canal'),
          onTap: () {
            _transforme_canal(room);
            Navigator.pop(context, 'Add account');
            // print(room.tags.isEmpty);
          },
        ),
      ],
    ),
  );
}

void _join(Room room, context) async {
  // print(room.spaceChildren);
  if (room.membership != Membership.join) {
    await room.join();
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CanalPageChat(room: room),
    ),
  );
}

void _pin(Room room, context) async {
  if (room.isFavourite == false) {
    await room.setFavourite(true);
  } else {
    await room.setFavourite(false);
  }
  Navigator.pop(context);
}

void _leave(Room room, context) async {
  if (room.membership != Membership.leave) {
    await room.leave();
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
