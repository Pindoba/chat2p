// import 'package:chat2p/login/splash_page.dart';
// import 'package:chat2p/talk/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class ContactComponent extends StatelessWidget {
//   const ContactComponent(
//       {super.key, required this.name, required this.picture, this.page});
//   final String name;
//   final String picture;
//   final Function? page;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ChatPage()));
//       },
//       child: Container(
//         height: 80,
//         margin: EdgeInsets.all(8),
//         padding: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           boxShadow: const <BoxShadow>[
//             BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 10,
//                 offset: Offset(
//                   0.0,
//                   0.75,
//                 ))
//           ],
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(children: [
//           CircleAvatar(
//             child: Image.network(picture),
//           ),
//           // Image.network(''),
//           const SizedBox(
//             width: 20,
//           ),
//           Column(
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               Text('Inicio da ultima mensagem recebida...')
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
// }

class BalonChatReceive extends StatelessWidget {
  const BalonChatReceive({
    super.key,
    required this.name,
    required this.picture,
    required this.body_msg,
    required this.data_time,
  });
  final String name;
  final String picture;
  final String body_msg;
  final String data_time;

  @override
  Widget build(BuildContext context) {
    return  Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              foregroundImage: NetworkImage(picture),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(
                    0.0,
                    0.3,
                  ),
                )
              ],
              color: Color.fromARGB(153, 145, 55, 206),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18, 
                      color: Colors.orange),
                  ),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: SelectableText(
                                              body_msg,
                                            ))
                ],
              ),
            ]),
          ),
          SizedBox(
              width: 50,
              child: Text(
                              data_time,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 8),
                            )),
        ],
      )
    ;
  }
}

class BalonImageReceive extends StatelessWidget {
  const BalonImageReceive({
    super.key,
    required this.name,
    required this.picture,
    required this.body_msg,
    required this.data_time, required this.url_image,
  });
  final String name;
  final String picture;
  final String body_msg;
  final String data_time;
  final String url_image;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              foregroundImage: NetworkImage(picture),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3,
                  offset: Offset(
                    0.0,
                    0.3,
                  ),
                )
              ],
              color: Color.fromARGB(153, 145, 55, 206),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, color: Colors.orange),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Image.network(
                      url_image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: SelectableText(
                                              body_msg,
                                            ))
                ],
              ),
            ]),
          ),
          SizedBox(
              width: 50,
              child: Text(
                              data_time,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(fontSize: 8),
                            )),
        ],
      )
    ;
  }
}
