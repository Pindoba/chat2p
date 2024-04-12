import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key,});
  // final Client client;



  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  @override
  Widget build(BuildContext context) {
    final client = Provider.of<Client>(context, listen: false);



      final TextEditingController _addController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Buscar usuários ou salas'),),
      body: Column(
        children: [
          Text('Buscar usuário'),
          TextFormField(
            controller: _addController,
          ),
          ElevatedButton(
              onPressed: () {
                
              },
              child: Text('Convidar contato')),
              StreamBuilder(
          stream: client.onSync.stream,
          builder: (context, _) => ListView.builder(
            itemCount: client.rooms.length,
            itemBuilder: (context, i) => 
            // client.rooms[i].isSpace == false
                 Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(0),
 
                        child: ListTile(
                          subtitleTextStyle: TextStyle(color: client.rooms[i].typingUsers.toString() != '[]' ? Colors.amber : Colors.white),
                          leading: CircleAvatar(
                            foregroundImage: client.rooms[i].avatar == null
                                ? const NetworkImage(
                                    'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                                : NetworkImage(client.rooms[i].avatar!
                                    .getThumbnail(
                                      client,
                                      width: 60,
                                      height: 80,
                                    )
                                    .toString()),
                          ),
                          title: Row(
                            children: [
                              Expanded(child: Text(client.rooms[i].displayname,maxLines: 2,)),
                              if (client.rooms[i].notificationCount > 0)
                                Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.amber,
                                    child: SizedBox(
                                      width: 35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Center(
                                            child: Text(
                                          client.rooms[i].notificationCount
                                              .toString(),
                                          style: TextStyle(color: Colors.black),
                                        )),
                                      ),
                                    ))
                            ],
                          ),
                          subtitle: Text(
                            client.rooms[i].typingUsers.toString() != '[]'
                                ? 'Digitando...'
                                : client.rooms[i].lastEvent?.body ??
                                    'Sem mensagem',
                            maxLines: 1,
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                // _option(context, client.rooms[i]);
                              },
                              icon: const Icon(
                                Icons.more_vert,
                              )),
                          onTap: () {
                            //  _join(client.rooms[i])
                          },
                        ),
                      ),
                      Divider()
                    ],
                  ),
          ),
        )
        ],
      ),
    );
  }
}
