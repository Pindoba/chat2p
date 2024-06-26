// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:chat2p/shared/widgets/list_chat_wedget.dart';
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
  final TextEditingController _addController = TextEditingController();
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
        backgroundColor: const Color.fromARGB(151, 0, 0, 0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
           
            
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
                  : const Icon(Icons.search),
            ),
          ],
          title: lupa == true
              ? TextField(
                  decoration: const InputDecoration(
                      labelText: 'Buscar por nome',
                     ),
                  controller: _addController,
                )
              : const Text('Conversas'),
        ),
        body: SafeArea(
          child: Column(
            children: [
               Divider(height: 1,color: Theme.of(context).indicatorColor,),
              SizedBox(height: 13),
              Expanded(
                child: StreamBuilder(
                  stream: client.onSync.stream,
                  builder: (context, _) => ListView.builder(
                    itemCount: client.rooms.length,
                    itemBuilder: (context, i) => 
                    
                    client.rooms[i].isSpace == false 
                    && client.rooms[i].tags.entries.toString().contains('channel') == false
                    && client.rooms[i].spaceParents.isEmpty == true
                    && client.rooms[i].canSendDefaultMessages == true
                    
                    // client.rooms[i].isSpace == false && client.rooms[i].tags.entries.toString().contains('channel') == false || client.rooms[i].spaceParents.isNotEmpty == true && client.rooms[i].isSpace == false
                        ? ListChat(
                            room: client.rooms[i],
                            client: client,
                          )
                
                        //       Container(
                        //         margin: const EdgeInsets.all(0),
                        //         // decoration: BoxDecoration(
                        //         //     // color: const Color.fromARGB(153, 123, 2, 204),
                        //         //     borderRadius: BorderRadius.circular(5),
                        //         //     boxShadow: const <BoxShadow>[
                        //         //       BoxShadow(
                        //         //           color: Color.fromARGB(141, 0, 0, 0),
                        //         //           blurRadius: 3,
                        //         //           offset: Offset(
                        //         //             0.0,
                        //         //             0.3,
                        //         //           ))
                        //         //     ]),
                        //         child: ListTile(
                        //           subtitleTextStyle: TextStyle(color: client.rooms[i].typingUsers.toString() != '[]' ? Colors.amber : Colors.white),
                        //
                        //
                        //           ),
                        //           subtitle: Text(
                        //             client.rooms[i].typingUsers.toString() != '[]'
                        //                 ? 'Digitando...'
                        //                 : client.rooms[i].lastEvent?.body ??
                        //                     'Sem mensagem',
                        //             maxLines: 1,
                        //           ),
                        //           trailing: IconButton(
                        //               onPressed: () {
                        //                 _option(context, client.rooms[i]);
                        //               },
                        //               icon: const Icon(
                        //                 Icons.more_vert,
                        //
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
