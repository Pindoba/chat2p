import 'package:chat2p/shared/widgets/audio_balloon.dart';
import 'package:chat2p/shared/widgets/image_balloon.dart';
import 'package:chat2p/shared/widgets/text_balloon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';
import 'package:date_time_format/date_time_format.dart';


class BaseBalloonWidget extends StatelessWidget {
  const BaseBalloonWidget({
    super.key,
    required this.event,
    required this.room,
  });

  final Event event;
  final Room room;

  @override
  Widget build(BuildContext context) {
    final String name = event.sender.calcDisplayname();
    // final String photo = 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png';
    final String photo = event.sender.avatarUrl == null
        ? 'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'
        : event.sender.avatarUrl!
            .getThumbnail(room.client, width: 56, height: 56)
            .toString();
    final String body_msg = event.body;
    final String data_time = event.originServerTs.format('l, j M, H:i');
    final String type = event.messageType;
    final String image =
        'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png';
    // : event.attachmentMxcUrl!
    //     .getDownloadLink(
    //       room.client,
    //     )
    //     .toString();
    // : event.sender.avatarUrl!
    //     .getDownloadLink(
    //       room.client,
    //     )
    //     .toString();
// event.sendAgain()
    final bool send = event.senderId == room.client.userID ? true : false;
    print(send);
    // event.;

    return Row(
      mainAxisAlignment:
          send == true ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomLeft,
          child: send != true
              ? CircleAvatar(
                  foregroundImage: NetworkImage(photo),
                )
              : Container(),
        ),
        GestureDetector(
          onTap: () {
            option(context, event);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(
                    0.0,
                    0.3,
                  ),
                )
              ],
              color: send == true
                  ? Color.fromARGB(190, 4, 79, 218)
                  : const Color.fromARGB(153, 145, 55, 206),
              borderRadius: BorderRadius.only(
                  bottomLeft:
                      send == true ? Radius.circular(15) : Radius.circular(0),
                  bottomRight:
                      send == true ? Radius.circular(0) : Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Row(children: [
              Column(
                crossAxisAlignment: send == true
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                      // event.redacted == null
                      // ?
                      
                      // : Text('' )
                    ],
                  ),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: type == "m.text"
                          ? TextBalloon(body_msg: body_msg)
                          : type == "m.audio"
                              ? AudioBalloon()
                              : type == "m.image"
                                  ? ImageBalloon(url_image: image)
                                  : Text('data')),
                  Row(
                    children: [
                      Text(
                        data_time,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(fontSize: 12, color: Colors.white54),
                      ),

                      send == true ? Icon(Icons.check_sharp,size: 17, color: event.receipts.toString() != '[]' ? Color.fromARGB(255, 169, 255, 56) : Colors.white54,):
                      Text('')


                    ],
                  )
                ],
              ),
            ]),
          ),
        ),
        // SizedBox(
        //     width: 50,
        //     child: Text(
        //       data_time,
        //       overflow: TextOverflow.clip,
        //       style: const TextStyle(fontSize: 8),
        //     )),
      ],
    );
  }
}

dynamic option(context, event) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: const Text('Opções'),
      children: [
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Apagar'),
          onTap: () => delete_event(context, event),
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Reenviar'),
          onTap: () => resend(context, event),
        ),
        ListTile(
          leading: const Icon(Icons.add_circle),
          title: const Text('Editar'),
          onTap: () => Navigator.pop(context, 'Add account'),
        ),
      ],
    ),
  ).then((returnVal) {
    if (returnVal != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You clicked: $returnVal'),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );
    }
  });

  // child: const Text('Simple dialog')
  ;
}

dynamic delete_event(context, event) {
  event.redactEvent();
  Navigator.pop(context);
}

dynamic resend(context, event) {
  event.sendAgain();
  Navigator.pop(context);
}

dynamic edit(context, event) {
  event.sendAgain();
  Navigator.pop(context);
}
