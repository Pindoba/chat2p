// ignore_for_file: deprecated_member_use, use_build_context_synchronously

// import 'package:animated_radial_menu/animated_radial_menu.dart';
// import 'package:chat2p/buscar_page.dart';
import 'package:chat2p/shared/widgets/list_chat_wedget.dart';
// import 'package:chat2p/menu_radial.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
// import 'package:page_transition/page_transition.dart';

class CanalPage extends StatefulWidget {
  const CanalPage({super.key});

  @override
  State<CanalPage> createState() => _CanalPageState();
}

bool lupa = false;

class _CanalPageState extends State<CanalPage> {
  final TextEditingController _addController = TextEditingController();
  // List<String> pin = ["\$NcVV2A6894exHh5yc6uDzTb01O382nD20YZHN2Bkn4Y"];
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
        image: AssetImage('assets/image/f4.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(151, 0, 0, 0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 123, 2, 204),
          actions: [
            IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                _create(client);
              },
              icon: lupa == true
                  ? const Icon(
                      Icons.add,
                    )
                  : const Text(''),
            ),
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
        body: StreamBuilder(
          stream: client.onSync.stream,
          builder: (context, _) => ListView.builder(
            itemCount: client.rooms.length,
            itemBuilder: (context, i) => client.rooms[i].tags.entries.toString().contains('channel') == true
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
    );
  }
}
