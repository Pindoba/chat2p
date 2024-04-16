import 'package:chat2p/room_page.dart';
import 'package:flutter/cupertino.dart';
// import 'package:chat2p/shared/widgets/list_chat_wedget.dart';
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

  List<Room> roomchildren = [];
  List<String> id_children = [];

  void _leave(Room room) async {
    if (room.membership != Membership.leave) {
      await room.leave();
      Navigator.pop(context);
    }
  }

  void _filhos(Room room, client) async {
    setState(() {
      id_children.clear();

      var roomfilho = room.spaceChildren;
      for (int i = 0; i < roomfilho.length; i++) {
      id_children.add(roomfilho[i].roomId.toString());
    
  }
      print(roomfilho[1].roomId);
      // final sala = Room(
      //   id: roomfilho[0].toString(),
      //   client: client,
      // );

      // roomchildren.add(sala);
      // print(room);
      // print(room.tags.values.contains(''));
      // print(room.spaceChildren.iterator);
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);

    //  (roomchildren);
    print(client.rooms);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Espaços'),
      ),
      body: SafeArea(
        child: Column(
          children: [Divider(height: 1,color: Colors.amber,),
            Expanded(
              child: Row(
                
                children: [
                  Expanded(
                    flex: 2,
                    child: StreamBuilder(
                      stream: client.onSync.stream,
                      builder: (context, _) => ListView.builder(
                        itemCount: client.rooms.length,
                        itemBuilder: (context, i) => client.rooms[i].isSpace == true
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    // _join(room, context);
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(minWidth: 50),//######################################################################################
                                    // width: 10,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            width: 50,
                                            height: 50,
                                            child: GestureDetector(
                                              onTap: () {
                                                _filhos(client.rooms[i], client);
                                              },
                                              child: CircleAvatar(
                                                foregroundImage: NetworkImage(client
                                                            .rooms[i].avatar ==
                                                        null
                                                    ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
                                                    : client.rooms[i].avatar!
                                                        .getThumbnail(
                                                          client,
                                                          width: 50,
                                                          height: 50,
                                                        )
                                                        .toString()),
                                              ),
                                            )),
                                        // Divider(height: 1,),
                                      ],
                                    ),
                                  ),
                                )
              
                                //  ListSpace(room: client.rooms[i], client: client),
              
                                )
                            : Container(),
                      ),
                    ),
                  ),
              
                  //#################### salas referente ao espaço ################################
              
                  Expanded(
                    flex: 8,
                    child: Container(
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
                        width: 150,
                        // constraints: BoxConstraints(maxWidth: 350),
                        margin: EdgeInsets.only(top: 15, right: 10),
                        height: double.infinity,
                        child: ListView.builder(
                            itemCount: client.rooms.length,
                            itemBuilder: (context, i) => 
                    
                            id_children.contains(client.rooms[i].id) == true ?
                            
                            Column(
                                  children: [
                                    ListTile(
                                      title: GestureDetector(
                                        onTap: () {
                                          _join(client.rooms[i]);
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.group),
                                            const SizedBox(
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
                                    const Divider(height: 1,)
                                  ],
                                ) : Container(),
                                
                                )
                                ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//##################### lista espaços ###############################

// class ListSpace extends StatelessWidget {
//   const ListSpace({super.key, required this.room, required this.client});
//   final Room room;
//   final Client client;

//   @override
//   Widget build(BuildContext context) {
// void _filhos(Room room) async {
//   var roomfilho = await room.spaceChildren;
//   // roomfilho.last.toString

//   print(roomfilho[1].roomId);
//  final sala = Room(id: roomfilho[0].toString(), client: client);
//   print(sala);
//   print(room.tags.values.contains(''));
//   print(room.spaceChildren.iterator);
// }
// room.addTag('tag');
// room.addToDirectChat(userID)

// final String avatar = room.avatar == null
//     ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
//     : room.avatar!
//         .getThumbnail(
//           client,
//           width: 55,
//           height: 55,
//         )
//         .toString();

//     return GestureDetector(
//       onTap: () {
//         // _join(room, context);
//       },
//       child: Container(
//         width: 80,
//         alignment: Alignment.centerLeft,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//                 margin: const EdgeInsets.only(left: 15, right: 15),
//                 width: 55,
//                 height: 55,
//                 child: GestureDetector(
//                   onTap: () {
//                     _filhos(room);
//                   },
//                   child: CircleAvatar(
//                     foregroundImage: NetworkImage(avatar),
//                   ),
//                 )),
//             Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _join(Room room, context) async {
//   print(room.spaceChildren);
//   if (room.membership != Membership.join) {
//     await room.join();
//   }
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => RoomPage(room: room),
//     ),
//   );
// }
