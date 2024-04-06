// import 'package:chat2p/login/login_page.dart';
import 'dart:typed_data';

import 'package:chat2p/shared/widgets/balloon_audio_receive_component.dart';
import 'package:chat2p/shared/contact_component.dart';
import 'package:chat2p/shared/widgets/base_balloon_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:matrix/src/utils/uri_extension.dart';

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
  }

  final TextEditingController _sendController = TextEditingController();

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
   

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      // var _user = null;
      // final message = types.ImageMessage(
      //   author: _user,
      //   createdAt: DateTime.now().millisecondsSinceEpoch,
      //   height: image.height.toDouble(),
      //   id: const Uuid().v4(),
      //   name: result.name,
      //   size: bytes.length,
      //   uri: result.path,
      //   width: image.width.toDouble(),
      // );
      
     

      // _addMessage(message);
      // widget.room.sendFileEvent(
      //     MatrixImageFile(bytes: Uint8List.fromList(List<int> message.size), name: message.name));
    }
  }

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

    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/f1.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 123, 2, 204),
            title: Text(widget.room.displayname),
            centerTitle: true,
            iconTheme: IconThemeData()),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<Timeline>(
                  future: _timelineFuture,
                  builder: (context, snapshot) {
                    final timeline = snapshot.data;
                    timeline?.setReadMarker();

                    if (timeline == null) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    _count = timeline.events.length;

                    return RefreshIndicator(
                      onRefresh: timeline.requestHistory,
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
                              itemBuilder: (context, i, animation) =>
                                  timeline.events[i].relationshipEventId != null
                                      ? Container()
                                      : ScaleTransition(
                                          scale: animation,
                                          child: Opacity(
                                              opacity: timeline.events[i].status.isSent
                                                  ? 1
                                                  : 0.5,
                                              child: timeline.events[i].type ==
                                                      "m.room.message"
                                                  // timeline.events[i]
                                                  //         .messageType ==
                                                  //     "m.text"
                                                  ?
                                                  //################################################    mensagemde texto simples   ######################################

                                                  BaseBalloonWidget(
                                                      event: timeline.events[i],
                                                      room: widget.room,
                                                    )

                                                  // BalonChatReceive(
                                                  //     name: timeline
                                                  //         .events[i].sender
                                                  //         .calcDisplayname(),
                                                  //     picture: timeline
                                                  //                 .events[i]
                                                  //                 .sender
                                                  //                 .avatarUrl ==
                                                  //             null
                                                  //         ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
                                                  //         : timeline
                                                  //             .events[i]
                                                  //             .sender
                                                  //             .avatarUrl!
                                                  //             .getThumbnail(
                                                  //               widget.room
                                                  //                   .client,
                                                  //               width: 56,
                                                  //               height: 56,
                                                  //             )
                                                  //             .toString(),
                                                  //     body_msg: timeline
                                                  //         .events[i]
                                                  //         .getDisplayEvent(
                                                  //             timeline)
                                                  //         .body,
                                                  //     data_time: timeline
                                                  //         .events[i]
                                                  //         .originServerTs
                                                  //         .toIso8601String(),
                                                  //   )
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

                                                      //timeline.events[i].room.fullyRead

                                                      Center(
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(3),
                                                            // child: Text(timeline.events[i].getDisplayEvent(timeline).body),
                                                            child: timeline
                                                                        .events[
                                                                            i]
                                                                        .asUser
                                                                        .membership
                                                                        .toString() ==
                                                                    Null
                                                                ? Text(
                                                                    '${timeline.events[i].sender.calcDisplayname()} nulo')
                                                                : timeline
                                                                            .events[
                                                                                i]
                                                                            .asUser
                                                                            .membership
                                                                            .toString() ==
                                                                        'Membership.leave'
                                                                    ? Text(
                                                                        '${timeline.events[i].sender.calcDisplayname()} saiu da sala')
                                                                    : timeline.events[i].asUser.membership.toString() ==
                                                                            'Membership.join'
                                                                        ? Text(timeline.events[i].sender.calcDisplayname() +
                                                                            ' entrou na sala')
                                                                        : Text(timeline
                                                                            .events[i]
                                                                            .asUser
                                                                            .membership
                                                                            .toString()),
                                                          ),
                                                        )
                                                      : timeline.events[i].type ==
                                                                  "m.room.message" &&
                                                              timeline.events[i]
                                                                      .messageType ==
                                                                  "m.imag"
                                                          ? BalonImageReceive(
                                                              url_image: timeline
                                                                  .events[i]
                                                                  .getAttachmentUrl(
                                                                      getThumbnail:
                                                                          false,
                                                                      height:
                                                                          800,
                                                                      width:
                                                                          800,
                                                                      method: ThumbnailMethod
                                                                          .scale)
                                                                  .toString(),

                                                              name: timeline
                                                                  .events[i]
                                                                  .sender
                                                                  .calcDisplayname(),
                                                              picture: timeline
                                                                          .events[
                                                                              i]
                                                                          .sender
                                                                          .avatarUrl ==
                                                                      null
                                                                  ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
                                                                  : timeline
                                                                      .events[i]
                                                                      .sender
                                                                      .avatarUrl!
                                                                      .getThumbnail(
                                                                        widget
                                                                            .room
                                                                            .client,
                                                                        width:
                                                                            56,
                                                                        height:
                                                                            56,
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
                                                          : timeline.events[i].messageType == "m.file"
                                                              ? const Center(child: Text('Arquivo'))
                                                              : timeline.events[i].messageType == "m.video"
                                                                  ? const Center(child: Text('Video'))
                                                                  : timeline.events[i].messageType == "m.audio"
                                                                      ? BalloonAudioReceive(
                                                                          name: timeline
                                                                              .events[i]
                                                                              .sender
                                                                              .calcDisplayname(),
                                                                          picture: timeline
                                                                              .events[i]
                                                                              .sender
                                                                              .avatarUrl!
                                                                              .getThumbnail(
                                                                                widget.room.client,
                                                                                width: 56,
                                                                                height: 56,
                                                                              )
                                                                              .toString(),
                                                                          body_msg: timeline
                                                                              .events[i]
                                                                              .getDisplayEvent(timeline)
                                                                              .body,
                                                                          data_time: timeline
                                                                              .events[i]
                                                                              .originServerTs
                                                                              .toIso8601String(),
                                                                          url_image:
                                                                              'url_image',
                                                                          timeline:
                                                                              timeline,
                                                                        )
                                                                      : timeline.events[i].messageType == "m.location"
                                                                          ? const Center(child: Text('Localização'))
                                                                          : const Center(child: Text('evento aleatorio'))),
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
