// import 'dart:html';

import 'package:chat2p/exemplo.dart';
import 'package:chat2p/login/login_page.dart';
// import 'package:chat2p/shared/contact_component.dart';
// import 'package:chat2p/shared/list_room_component.dart';
// import 'package:chat2p/talk/chat_page.dart';
// import 'package:chat2p/talk/talk_all_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/widgets.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _TalkPageState();
}

bool lupa = false;

class _TalkPageState extends State<TalkPage> {

  void _logout() async {
    final client = Provider.of<Client>(context, listen: false);
    await client.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

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
void teste(){
  2-1;
}


  @override
  Widget build(BuildContext context) {
     final client = Provider.of<Client>(context, listen: false);


    final _kTabs = <Tab>[
      const Tab(text: 'Todos'),
      const Tab(text: 'Pessoal'),
      const Tab(text: 'Trabalho'),
    ];

    void _pesquisa() {
      setState(() {
        lupa = true;
      });
  
    }
    void _texto() {
      setState(() {
        lupa = false;
      });
 
    }





    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 123, 2, 204),
            actions: [ 
              // Visibility(
              //   visible: lupa,
                // child: 
                IconButton(alignment: Alignment.centerRight,
                            onPressed: () {
                            _texto();
                            },
                            icon: const Icon(Icons.close)),
              // ),
              IconButton(
                onPressed: () {
                  _pesquisa();
                },
                icon:  const Icon(Icons.search),
              ),
            ],
            title: lupa == true ? TextFormField(): Text('Convesas'),
            // backgroundColor: Colors.cyan,
            bottom: TabBar(
              tabs: _kTabs,
            ),
          ),
          body: 






          StreamBuilder(
        stream: client.onSync.stream,
        builder: (context, _) => ListView.builder(
          itemCount: client.rooms.length,
          itemBuilder: (context, i) => Container(
            margin: EdgeInsets.all(8),

            decoration: BoxDecoration(
            color: Color.fromARGB(153, 123, 2, 204),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                offset: Offset(
                  0.0,
                  0.3,
                ))]

            
          ),
            child: ListTile(
            

              
              leading: 
              CircleAvatar(

                foregroundImage: client.rooms[i].avatar == null
                    ? NetworkImage('https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                    : NetworkImage(client.rooms[i].avatar!
                        .getThumbnail(
                          client,
                          width: 56,
                          height: 56,
                        )
                        .toString()),
              ),
              title: Row(
                children: [
                  Expanded(child: Text(client.rooms[i].displayname)),
                  if (client.rooms[i].notificationCount > 0)
                    Material(elevation: 8,
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(255, 41, 173, 74),
                        child: Container(width: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child:
                                Center(child: Text(client.rooms[i].notificationCount.toString())),
                          ),
                        ))
                ],
              ),
              subtitle: Text(
                client.rooms[i].lastEvent?.body ?? 'Sem mensagem',
                maxLines: 1,
              ),
              onTap: () => _join(client.rooms[i]),
            

            
            
            ),
          ),
        ),
      ),
          



          ),
    );
  }
}
