import 'package:chat2p/channel/base_balloon_channel_widget.dart';
import 'package:chat2p/shared/widgets/base_balloon_widget.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart';

import 'package:image_picker/image_picker.dart';
import 'package:matrix/matrix.dart';
import 'package:signals/signals_flutter.dart';
// import 'package:uuid/uuid.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:uuid/uuid.dart';
// import 'package:matrix/src/utils/uri_extension.dart';
// var c = codeHtml.value;

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
      // final image = await decodeImageFromList(bytes);
      widget.room.sendFileEvent(MatrixImageFile(bytes: bytes, name: 'message.name'));
    }
  }

  var meteOdedo = Signal(false);
  _typin() {
    return meteOdedo.value = widget.room.typingUsers.isEmpty;
  }

  void _send() {
    widget.room.sendTextEvent(_sendController.text.trim());
    // codeHtml;
    _sendController.clear();
  }

  void _editor_markdown() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const EditorMarkdown()),
    // );
  }

  void _openCamera() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CameraRoom()),
    // );
  }

  // void _image(bytes, name) {
  //   widget.room.sendFileEvent(MatrixImageFile(bytes: bytes, name: name));
  //   _sendController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/f1.png'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Column(
              children: [
                Text(widget.room.displayname),
                // widget.room.typingUsers.isEmpty == false
                meteOdedo.value == true
                    ? const Text(
                        'Digitando...',
                        style: TextStyle(color: Colors.amber, fontSize: 16),
                      )
                    : Text('')
              ],
            ),
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
                          const Divider(
                            height: 1,
                            color: Colors.amber,
                          ),
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
                                              //################################################    mensagem chat   ######################################
                                              child: timeline.events[i].type ==
                                                          "m.room.message" &&
                                                      timeline.events[i].room
                                                              .tags.isEmpty ==
                                                          true
                                                  // timeline.events[i]
                                                  //         .messageType ==
                                                  //     "m.text"
                                                  ? BaseBalloonWidget(
                                                      event: timeline.events[i],
                                                      room: widget.room,
                                                    )
                                                  // ################################################# Canal ###################################################

                                                  : timeline.events[i].type ==
                                                              "m.room.message" &&
                                                          timeline
                                                                  .events[i]
                                                                  .room
                                                                  .tags
                                                                  .isEmpty ==
                                                              false
                                                      ? BaseBalloonChannelWidget(
                                                          event: timeline
                                                              .events[i],
                                                          room: widget.room,
                                                        )

                                                      //################################################   eventos relacionado aos menbros    ###########################
                                                      : timeline.events[i].type ==
                                                              "m.room.member"
                                                          ?

                                                          //   timeline.events[i].sender.messageType == "m.room.message"

                                                          //   timeline.events[i].sender.avatarUrl

                                                          //  timeline.events[i].getDisplayEvent(timeline).body
                                                          // body_msg: timeline.events[i].getDisplayEvent(timeline).attachmentMxcUrl.toString(),

                                                          //timeline.events[i].room.fullyRead

                                                          Center(
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child: timeline
                                                                            .events[
                                                                                i]
                                                                            .asUser
                                                                            .membership
                                                                            .toString() ==
                                                                        Null
                                                                    ? Text(
                                                                        '${timeline.events[i].sender.calcDisplayname()} nulo')
                                                                    : timeline.events[i].asUser.membership.toString() ==
                                                                            'Membership.leave'
                                                                        ? Text(
                                                                            '${timeline.events[i].sender.calcDisplayname()} saiu da sala')
                                                                        : timeline.events[i].asUser.membership.toString() ==
                                                                                'Membership.join'
                                                                            ? Text('${timeline.events[i].sender.calcDisplayname()} entrou na sala')
                                                                            : Text(timeline.events[i].asUser.membership.toString()),
                                                              ),
                                                            )
                                                          : timeline.events[i].type == "m.room.message" &&
                                                                  timeline.events[i].messageType == "m.imag"
                                                              ? BaseBalloonWidget(event: timeline.events[i], room: widget.room)
                                                              : timeline.events[i].messageType == "m.file"
                                                                  ? const Center(child: Text('Arquivo'))
                                                                  : timeline.events[i].messageType == "m.video"
                                                                      ? const Center(child: Text('Video'))
                                                                      : timeline.events[i].messageType == "m.audio"
                                                                          ? BaseBalloonWidget(event: timeline.events[i], room: widget.room)
                                                                          : timeline.events[i].messageType == "m.location"
                                                                              ? const Center(child: Text('Localização'))
                                                                              : Center(child: Text(timeline.events[i].messageType.toString()))),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'))),
                  child: widget.room.canSendDefaultMessages == true
                      ? Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.amber,
                                  offset: Offset(.3, .0))
                            ],
                          ),
                          child: Row(
                            children: [
                              PopupMenuButton<int>(
                                shadowColor: Colors.amber,
                                color: Theme.of(context).primaryColor,
                                elevation: 5,
                                itemBuilder: (context) => [
                                  const PopupMenuItem<int>(
                                    value: 1,
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt_rounded),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('Camera')
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<int>(
                                    value: 2,
                                    child: Row(
                                      children: [
                                        Icon(Icons.image_rounded),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('Galeria')
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem<int>(
                                    value: 3,
                                    child: Row(
                                      children: [
                                        Icon(Icons.html_rounded),
                                        SizedBox(width: 8),
                                        Text('HTML'),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case 1:
                                      _openCamera();
                                      break;
                                    case 2:
                                      _handleImageSelection();
                                      break;
                                    case 3:
                                      _editor_markdown();

                                      break;
                                  }
                                },
                                icon: const Icon(Icons.add_circle),
                              ),
                              // IconButton(
                              //     onPressed: () {
                              //       _handleImageSelection();
                              //     },
                              //     icon: const Icon(Icons.add)),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 15,
                                  controller: _sendController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enviar mensagem',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.send_outlined),
                                onPressed: _send,
                              ),
                            ],
                          ),
                        )
                      : const Text(''),
                ),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
