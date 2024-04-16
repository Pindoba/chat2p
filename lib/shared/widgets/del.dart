// import 'package:flutter/material.dart';
// import 'package:matrix/matrix.dart';

// class BalloonAudioReceive extends StatelessWidget {
//   const BalloonAudioReceive({
//     super.key,
//     required this.name,
//     required this.picture,
//     required this.body_msg,
//     required this.data_time,
//     required this.url_image,
//     this.timeline,
//   });
//   final String name;
//   final String picture;
//   final String body_msg;
//   final String data_time;
//   final String url_image;
//   final timeline;

//   @override
//   Widget build(BuildContext context) {
//     final Future<Timeline> _timelineFuture;
    

//     // timeline = _timelineFuture;

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Container(
//           height: 40,
//           padding: const EdgeInsets.only(bottom: 10),
//           alignment: Alignment.bottomLeft,
//           child: CircleAvatar(
//             foregroundImage: NetworkImage(picture),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 3,
//                 offset: Offset(
//                   0.0,
//                   0.3,
//                 ),
//               )
//             ],
//             color: Color.fromARGB(153, 145, 55, 206),
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(0),
//                 bottomRight: Radius.circular(15),
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15)),
//           ),
//           child: Row(children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(fontSize: 18, color: Colors.orange),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.play_circle_fill,
//                           size: 52,
//                         )),
//                     Container(
//                       constraints: const BoxConstraints(maxWidth: 200),
//                       child: Image.network(
//                         'https://static.vecteezy.com/system/resources/previews/022/818/351/original/sound-wave-or-voice-message-icon-music-waveform-track-radio-play-audio-equalizer-line-illustration-vector.jpg',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                     constraints: const BoxConstraints(maxWidth: 250),
//                     child: SelectableText(
//                       body_msg,
//                     ))
//               ],
//             ),
//           ]),
//         ),
//         SizedBox(
//             width: 50,
//             child: Text(
//               // data_time,
//               timeline.toString(),
//               overflow: TextOverflow.clip,
//               style: const TextStyle(fontSize: 8),
//             )),
//       ],
//     );
//   }
// }
