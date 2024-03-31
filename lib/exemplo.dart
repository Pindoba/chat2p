// import 'package:chat2p/login/login_page.dart';
import 'package:chat2p/shared/contact_component.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';




class RoomPage extends StatefulWidget {
  final Room room;

  const RoomPage({required this.room, Key? key})
      : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final Future<Timeline> _timelineFuture;


  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  int _count = 0;

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
  }

  @override
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

    return Container(


        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/image/f1.png'),
                                fit: BoxFit.cover,
                                
                                )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 123, 2, 204),
          title: Text(widget.room.displayname),
          centerTitle: true,
          iconTheme: IconThemeData()      ),
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
      
                    return RefreshIndicator(
                      onRefresh: () async => await timeline.requestHistory,
                      child: Column(
                        children: [
                          // Center(
                          //   child: TextButton(
                          //       onPressed: timeline.requestHistory,
                          //       child: const Text('Load more...')),
                          // ),
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
                                          opacity:
                                              timeline.events[i].status.isSent
                                                  ? 1
                                                  : 0.5,
                                          child: timeline.events[i].type ==
                                                      "m.room.message" &&
                                                  timeline.events[i]
                                                          .messageType ==
                                                      "m.text"
                                              ?
                                              //################################################mensagemde texto simples   ######################################
                                              BalonChatReceive(
                                                  name: timeline.events[i].sender
                                                      .calcDisplayname(),
                                                  picture: timeline.events[i]
                                                              .sender.avatarUrl ==
                                                          null
                                                      ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
                                                      : timeline.events[i].sender
                                                          .avatarUrl!
                                                          .getThumbnail(
                                                            widget.room.client,
                                                            width: 56,
                                                            height: 56,
                                                          )
                                                          .toString(),
                                                  body_msg: timeline.events[i]
                                                      .getDisplayEvent(timeline)
                                                      .body,
                                                  data_time: timeline
                                                      .events[i].originServerTs
                                                      .toIso8601String(),
                                                )
                                              //################################################   eventos relacionado aos menbros    ###########################################
                                              : timeline.events[i].type ==
                                                      "m.room.member"
                                                  ?
                                
                                                  //   timeline.events[i].sender.messageType == "m.room.message"
                                
                                                  //   timeline.events[i].sender.avatarUrl
                                                  //
                                                  //  timeline.events[i].sender.avatarUrl!.getThumbnail(widget.room.client,width: 56,height: 56,).toString()
                                                  //
                                                  // timeline.events[i].sender.calcDisplayname()
                                                  //
                                                  //  timeline.events[i].originServerTs.toIso8601String()
                                                  //
                                                  //  timeline.events[i].getDisplayEvent(timeline).body
                                                  // body_msg: timeline.events[i].getDisplayEvent(timeline).attachmentMxcUrl.toString(),
                                
                                                  Center(
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.all(
                                                                3),
                                                        // child: Text(timeline.events[i].getDisplayEvent(timeline).body),
                                                        child: timeline
                                                                    .events[i]
                                                                    .asUser
                                                                    .membership
                                                                    .toString() ==
                                                                Null
                                                            ? Text('${timeline
                                                                    .events[i]
                                                                    .sender
                                                                    .calcDisplayname()} nulo')
                                                            : timeline
                                                                        .events[i]
                                                                        .asUser
                                                                        .membership
                                                                        .toString() ==
                                                                    'Membership.leave'
                                                                ? Text('${timeline
                                                                        .events[i]
                                                                        .sender
                                                                        .calcDisplayname()} saiu da sala')
                                                                : timeline
                                                                            .events[i]
                                                                            .asUser
                                                                            .membership
                                                                            .toString() ==
                                                                        'Membership.join'
                                                                    ? Text(timeline.events[i].sender.calcDisplayname() + ' entrou na sala')
                                                                    : Text(timeline.events[i].asUser.membership.toString()),
                                                      ),
                                                    )
                                                  : timeline.events[i].type ==
                                                              "m.room.message" &&
                                                          timeline.events[i]
                                                                  .messageType ==
                                                              "m.image"
                                                      ? BalonImageReceive(
                                                          url_image:
                                                              'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png',
                                
                                                          name: timeline
                                                              .events[i].sender
                                                              .calcDisplayname(),
                                                          picture: timeline
                                                                      .events[i]
                                                                      .sender
                                                                      .avatarUrl ==
                                                                  null
                                                              ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
                                                              : timeline
                                                                  .events[i]
                                                                  .sender
                                                                  .avatarUrl!
                                                                  .getThumbnail(
                                                                    widget.room
                                                                        .client,
                                                                    width: 56,
                                                                    height: 56,
                                                                  )
                                                                  .toString(),
                                
                                                          body_msg: timeline
                                                              .events[i]
                                                              .attachmentMxcUrl
                                                              .toString(), //mxcUrlToHttp//(content.url, window.innerWidth, window.innerHeight, 'scale'),
                                                          // body_msg: timeline.events[i].getDisplayEvent(timeline).body,
                                
                                                          data_time: timeline
                                                              .events[i]
                                                              .originServerTs
                                                              .toIso8601String(),
                                                        )
                                                      : const Center(
                                                          child: Text(
                                                              'evento aleatorio'))),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'))),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _handleImageSelection();
                          },
                          icon: const Icon(Icons.add)),
                      Expanded(
                          child: TextField(
                        controller: _sendController,
                        decoration: const InputDecoration(
                          hintText: 'Enviar mensagem',
                        ),
                      )),
                      IconButton(
                        icon: const Icon(Icons.send_outlined),
                        onPressed: _send,
                      ),
                    ],
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
