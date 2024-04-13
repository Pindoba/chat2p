
import 'package:chat2p/shared/widgets/list_chat_wedget.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class BuscaPage extends StatefulWidget {
  const BuscaPage({super.key});

  @override
  State<BuscaPage> createState() => _BuscaPageState();
}



class _BuscaPageState extends State<BuscaPage> {


  final TextEditingController _addController = TextEditingController();

  void _create(Client client) async {
    String iduser = _addController.text.trim();

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


        // final   Room  result =  
       print(  client.getSpaceHierarchy("!idzuYRWVxZHioWSAvs:nitro.chat"));
       print(  client.defineFilter(client.userID.toString(),Filter()));
       
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/f3.png'),
        
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(151, 0, 0, 0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 123, 2, 204),
         
          title: const Text('Buscar')
          
          
          // TextField(
          //         decoration: const InputDecoration(
          //             // border: OutlineInputBorder(),
          //             labelText: 'Id do usuário',
          //             hintText: '@usuario:servidor.com'),
          //         controller: _addController,
          //       )
             
        ),

      
        body: StreamBuilder(
          stream: client.onSync.stream,
          builder: (context, _) => ListView.builder(
            // itemCount: 
            // result.length,
            itemCount: client.rooms.length,
            itemBuilder: (context, i) => 
            
            client.rooms[i].isSpace == false && client.rooms[i].isDirectChat == false ?
            ListChat(room: client.rooms[i],client: client,)
            
            
                : Container(),
          ),
        ),
      ),
    );
  }
}

