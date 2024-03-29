// import 'package:chat2p/login/login_page.dart';
import 'package:chat2p/shared/contact_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final client = Client(
//     'Matrix Example Chat',
//     databaseBuilder: (_) async {
//       final dir = await getApplicationSupportDirectory();
//       final db = HiveCollectionsDatabase('matrix_example_chat', dir.path);
//       await db.open();
//       return db;
//     },
//   );
//   await client.init();
//   runApp(MatrixExampleChat(client: client));
// }

// class MatrixExampleChat extends StatelessWidget {
//   final Client client;
//   const MatrixExampleChat({required this.client, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Matrix Example Chat',
//       builder: (context, child) => Provider<Client>(
//         create: (context) => client,
//         child: child,
//       ),
//       home: client.isLogged() ? const RoomListPage() : const LoginPage(),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _homeserverTextField = TextEditingController(
//     text: 'matrix.org',
//   );
//   final TextEditingController _usernameTextField = TextEditingController();
//   final TextEditingController _passwordTextField = TextEditingController();

//   bool _loading = false;

//   void _login() async {
//     setState(() {
//       _loading = true;
//     });

//     try {
//       final client = Provider.of<Client>(context, listen: false);
//       await client
//           .checkHomeserver(Uri.https(_homeserverTextField.text.trim(), ''));
//       await client.login(
//         LoginType.mLoginPassword,
//         password: _passwordTextField.text,
//         identifier: AuthenticationUserIdentifier(user: _usernameTextField.text),
//       );
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const RoomListPage()),
//         (route) => false,
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(e.toString()),
//         ),
//       );
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _homeserverTextField,
//               readOnly: _loading,
//               autocorrect: false,
//               decoration: const InputDecoration(
//                 prefixText: 'https://',
//                 border: OutlineInputBorder(),
//                 labelText: 'Homeserver',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _usernameTextField,
//               readOnly: _loading,
//               autocorrect: false,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Username',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _passwordTextField,
//               readOnly: _loading,
//               autocorrect: false,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _loading ? null : _login,
//                 child: _loading
//                     ? const LinearProgressIndicator()
//                     : const Text('Login'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoomListPage extends StatefulWidget {
//   const RoomListPage({Key? key}) : super(key: key);

//   @override
//   _RoomListPageState createState() => _RoomListPageState();
// }

// class _RoomListPageState extends State<RoomListPage> {
// void _logout() async {
//   final client = Provider.of<Client>(context, listen: false);
//   await client.logout();
//   Navigator.of(context).pushAndRemoveUntil(
//     MaterialPageRoute(builder: (_) => const LoginPage()),
//     (route) => false,
//   );
// }

// void _join(Room room) async {
//   if (room.membership != Membership.join) {
//     await room.join();
//   }
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => RoomPage(room: room),
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   // final client = Provider.of<Client>(context, listen: false);
//   return Scaffold(
//     appBar: AppBar(
//       title: const Text('Chats'),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.logout),
//           onPressed: _logout,
//         ),
//       ],
//     ),
//     body:
// StreamBuilder(
//   stream: client.onSync.stream,
//   builder: (context, _) => ListView.builder(
//     itemCount: client.rooms.length,
//     itemBuilder: (context, i) => ListTile(
//       leading: CircleAvatar(
//         foregroundImage: client.rooms[i].avatar == null
//             ? null
//             : NetworkImage(client.rooms[i].avatar!
//                 .getThumbnail(
//                   client,
//                   width: 56,
//                   height: 56,
//                 )
//                 .toString()),
//       ),
//       title: Row(
//         children: [
//           Expanded(child: Text(client.rooms[i].displayname)),
//           if (client.rooms[i].notificationCount > 0)
//             Material(
//                 borderRadius: BorderRadius.circular(99),
//                 color: Colors.red,
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child:
//                       Text(client.rooms[i].notificationCount.toString()),
//                 ))
//         ],
//       ),
//       subtitle: Text(
//         client.rooms[i].lastEvent?.body ?? 'No messages',
//         maxLines: 1,
//       ),
//       onTap: () => _join(client.rooms[i]),
//     ),
//   ),
// ),
//     );
//   }
// }

class RoomPage extends StatefulWidget {
  final Room room;
  const RoomPage({required this.room, Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final Future<Timeline> _timelineFuture;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _count = 0;

  @override
  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
  }

  void initState() {
    _timelineFuture = widget.room.getTimeline(onChange: (i) {
      print('on change! $i');
      _listKey.currentState?.setState(() {});
    }, onInsert: (i) {
      print('on insert! $i');
      _listKey.currentState?.insertItem(i);
      _count++;
    }, onRemove: (i) {
      print('On remove $i');
      _count--;
      _listKey.currentState?.removeItem(i, (_, __) => const ListTile());
    }, onUpdate: () {
      print('On update');
    });
    super.initState();
    // _timeline.requestHistory();
  }

  final TextEditingController _sendController = TextEditingController();

  void _send() {
    widget.room.sendTextEvent(_sendController.text.trim());
    _sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final client = Client(
      'Chat2P',
      databaseBuilder: (_) async {
        final dir = await getApplicationSupportDirectory();
        final db = HiveCollectionsDatabase('Chat2P', dir.path);
        await db.open();
        return db;
      },
    );

    final my_user = client.userID;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 123, 2, 204),
        title: Text(widget.room.displayname),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Timeline>(
                future: _timelineFuture,
                builder: (context, snapshot) {
                  final timeline = snapshot.data;

                  if (timeline == null) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  _count = timeline.events.length;

                  return Column(
                    children: [
                      Center(
                        child: TextButton(
                            onPressed: timeline.requestHistory,
                            child: const Text('Load more...')),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: AnimatedList(
                          key: _listKey,
                          reverse: true,
                          initialItemCount: timeline.events.length,
                          itemBuilder: (context, i, animation) => timeline
                                      .events[i].relationshipEventId !=
                                  null
                              ? Container()
                              : ScaleTransition(
                                  scale: animation,
                                  child: Opacity(
                                    opacity: timeline.events[i].status.isSent
                                        ? 1
                                        : 0.5,
                                    child: timeline.events[i].type == "m.room.message" ?


                                    
                                    BalonChatReceive(
                                      name: timeline.events[i].sender.calcDisplayname(), 
                                      // ignore: unnecessary_null_comparison
                                      picture: 
                                      timeline.events[i].sender.avatarUrl == null ? 
                                               'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png': 
                                                timeline.events[i].sender.avatarUrl!.getThumbnail(widget.room.client, width: 56,height: 56,).toString(),
                                      body_msg: timeline.events[i].getDisplayEvent(timeline).body,
                                      data_time: timeline.events[i].originServerTs.toIso8601String(),
                                      ): 
                                      
                                      timeline.events[i].type == "m.room.member" ? 
                                      








                                    // Container(
                                    //   margin: timeline.events[i].sender.messageType == "m.room.message"
                                              
                                    //       ? const EdgeInsets.only(
                                    //           top: 8,
                                    //           bottom: 8,
                                    //           left: 8,
                                    //           right: 80)
                                    //       : const EdgeInsets.only(
                                    //           top: 8,
                                    //           bottom: 8,
                                    //           left: 80,
                                    //           right: 8),
                                    //   decoration: BoxDecoration(
                                    //       color:
                                    //           Color.fromARGB(153, 145, 55, 206),
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //       boxShadow: const <BoxShadow>[
                                    //         BoxShadow(
                                    //             color: Colors.black,
                                    //             blurRadius: 1,
                                    //             offset: Offset(
                                    //               0.0,
                                    //               0.3,
                                    //             ))
                                    //       ]),
                                    //   child: ListTile(
                                    //     leading: CircleAvatar(
                                    //       foregroundImage: timeline.events[i]
                                    //                   .sender.avatarUrl ==
                                    //               null
                                    //           ? const NetworkImage(
                                    //               'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png')
                                    //           : NetworkImage(timeline
                                    //               .events[i].sender.avatarUrl!
                                    //               .getThumbnail(
                                    //                 widget.room.client,
                                    //                 width: 56,
                                    //                 height: 56,
                                    //               )
                                    //               .toString()),
                                    //     ),
                                    //     title: Row(
                                    //       children: [
                                    //         Expanded(
                                    //           child: Text(timeline
                                    //               .events[i].sender
                                    //               .calcDisplayname()),
                                    //         ),
                                    //         Text(
                                    //           timeline.events[i].originServerTs
                                    //               .toIso8601String(),
                                    //           style:
                                    //               const TextStyle(fontSize: 10),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //     subtitle: Text(timeline.events[i]
                                    //         .getDisplayEvent(timeline)
                                    //         .body),
                                    //   ),
                                    // ) 







                                     Center(
                                      child: Container(margin: const EdgeInsets.all(3),
                                        // child: Text(timeline.events[i].getDisplayEvent(timeline).body),
                                        child: timeline.events[i].asUser.membership.toString() ==  Null ? 
                                          Text(timeline.events[i].sender.calcDisplayname() + ' nulo') : 
                                            timeline.events[i].asUser.membership.toString() == 'Membership.leave' ? 
                                              Text(timeline.events[i].sender.calcDisplayname() + ' saiu da sala') : 
                                                timeline.events[i].asUser.membership.toString() == 'Membership.join' ? 
                                                  Text(timeline.events[i].sender.calcDisplayname() +' entrou na sala') :


                                                Text('outro evento'),
                                      ),
                                            ): Text('')
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _handleImageSelection();
                      },
                      icon: Icon(Icons.add)),
                  Expanded(
                      child: TextField(
                    controller: _sendController,
                    decoration: const InputDecoration(
                      hintText: 'Send message',
                    ),
                  )),
                  IconButton(
                    icon: const Icon(Icons.send_outlined),
                    onPressed: _send,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
