import 'package:chat2p/channel/base_balloon_channel_widget.dart';
import 'package:chat2p/channel/canal_chat_wedget.dart';
import 'package:chat2p/room_page.dart';
// import 'package:chat2p/room_page.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class ProfileListWedget extends StatelessWidget {
  const ProfileListWedget({
    super.key,
    required this.profile,
    this.room,
  });
  final Room? room;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);
    final String name = profile.displayName.toString();
    final String userId = profile.userId;
    final String avatar = profile.avatarUrl == null
        ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
        : profile.avatarUrl!
            .getThumbnail(
              client,
              width: 50,
              height: 50,
            )
            .toString();

    return GestureDetector(
      onTap: () {
        // _join(room, context);
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
                      onTap: profile.avatarUrl != null
                          ? () => _modal(context, avatar)
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
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.check),
                            Expanded(
                              child: Text(
                                userId,
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
                            _option(context, profile);
                          },
                          icon: Icon(
                            Icons.more_vert,
                            size: 20,
                          )),
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

dynamic _option(context, Profile profile) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Opções'),
      children: [
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Conversar'),
          onTap: () {
            final client = Provider.of<Client>(context, listen: false);
            // client.getDirectChatFromUserId(profile.userId);
            List<String> member = [profile.userId];

            createroom() async {
               await client.createRoom(
                isDirect: true,
                invite: member,
                // roomAliasName: profile.userId
              );
            }
            print(createroom());

              Navigator.pop(context);
              Navigator.pop(context);
            // var createRoom = Room(id: idRoom.toString(), client: client);

            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => CanalPageChat(room: createRoom),
            //   ),
            // );
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) => AlertDialog(
            //           title: Text('Apagar conversa?'),
            //           content: Text(''),
            //           actions: [
            //             TextButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                   Navigator.pop(context);
            //                 },
            //                 child: Text('Cancelar')),
            //             TextButton(
            //                 onPressed: () {
            //                   // _leave(room, context);
            //                 },
            //                 child: Text("Apagar"))
            //           ],
            //         ));
          },
        ),
        ListTile(
          leading: profile.userId != ''
              ? const Icon(Icons.block)
              : const Icon(Icons.push_pin),
          title: profile.userId != ''
              ? const Text('Bloquear')
              : Text("Desbloquear"),
          onTap: () {
            // _pin(room, context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('T canal'),
          onTap: () {
            // _transforme_canal(room);
            Navigator.pop(context, 'Add account');
          },
        ),
      ],
    ),
  );
}

void _join(Room room, context) async {
  if (room.membership != Membership.join) {
    await room.join();
  }
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => RoomPage(room: room),
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
