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



class _ListSpacePageState extends State<ListSpacePage> {


  void _join(Room room) async {
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
      body: StreamBuilder(
        stream: client.onSync.stream,
        builder: (context, _) => ListView.builder(
          itemCount:
          
              client.rooms.length,
          itemBuilder: (context, i) => client.rooms[i].isSpace == true
              ? Container(
                  // width: 80,
          
                
                  child: Row(
                    children: [
                      ListTile(
                        leading: GestureDetector(
                          onLongPress: () {
                                   
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
                        title: Text('data'),
                        subtitle: Text(
                          client.rooms[i].isSpace.toString() ,
                          maxLines: 1,
                        ),
                        onTap: () => _join(client.rooms[i]),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
