// // import 'package:chat2p/login/splash_page.dart';
// // import 'package:chat2p/talk/chat_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:html/parser.dart';

// // class ContactComponent extends StatelessWidget {
// //   const ContactComponent(
// //       {super.key, required this.name, required this.picture, this.page});
// //   final String name;
// //   final String picture;
// //   final Function? page;

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //             context, MaterialPageRoute(builder: (context) => ChatPage()));
// //       },
// //       child: Container(
// //         height: 80,
// //         margin: EdgeInsets.all(8),
// //         padding: EdgeInsets.all(8),
// //         decoration: BoxDecoration(
// //           boxShadow: const <BoxShadow>[
// //             BoxShadow(
// //                 color: Colors.black,
// //                 blurRadius: 10,
// //                 offset: Offset(
// //                   0.0,
// //                   0.75,
// //                 ))
// //           ],
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(10),
// //         ),
// //         child: Row(children: [
// //           CircleAvatar(
// //             child: Image.network(picture),
// //           ),
// //           // Image.network(''),
// //           const SizedBox(
// //             width: 20,
// //           ),
// //           Column(
// //             children: [
// //               Text(
// //                 name,
// //                 style: const TextStyle(
// //                   fontSize: 18,
// //                 ),
// //               ),
// //               Text('Inicio da ultima mensagem recebida...')
// //             ],
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }

// class BalonChatReceive extends StatelessWidget {
//   const BalonChatReceive({
//     super.key,
//     required this.name,
//     required this.picture,
//     required this.body_msg,
//     required this.data_time,
//   });
//   final String name;
//   final String picture;
//   final String body_msg;
//   final String data_time;

//   @override
//   Widget build(BuildContext context) {
//     // final String body_html = parse(body_msg).toString();

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
//                 Row(
//                   children: [
//                     Text(
//                       name,
//                       style:
//                           const TextStyle(fontSize: 18, color: Colors.orange),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           option(context);
//                         },
//                         icon: const Icon(Icons.drag_handle_outlined))
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
//               data_time,
//               overflow: TextOverflow.clip,
//               style: const TextStyle(fontSize: 8),
//             )),
//       ],
//     );
//   }
// }

// class BalonImageReceive extends StatelessWidget {
//   const BalonImageReceive({
//     super.key,
//     required this.name,
//     required this.picture,
//     required this.body_msg,
//     required this.data_time,
//     required this.url_image,
//   });
//   final String name;
//   final String picture;
//   final String body_msg;
//   final String data_time;
//   final String url_image;

//   @override
//   Widget build(BuildContext context) {
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
//                 Container(
//                   constraints: const BoxConstraints(maxWidth: 250),
//                   child: Image.network(
//                     url_image,
//                     fit: BoxFit.fitWidth,
//                   ),
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
//               data_time,
//               overflow: TextOverflow.clip,
//               style: const TextStyle(fontSize: 8),
//             )),
//       ],
//     );
//   }
// }

// dynamic option(context) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) => SimpleDialog(
//       title: const Text('Dialog Title'),
//       children: [
//         ListTile(
//           leading: const Icon(Icons.account_circle),
//           title: const Text('user@example.com'),
//           onTap: () => Navigator.pop(context, 'user@example.com'),
//         ),
//         ListTile(
//           leading: const Icon(Icons.account_circle),
//           title: const Text('user2@gmail.com'),
//           onTap: () => Navigator.pop(context, 'user2@gmail.com'),
//         ),
//         ListTile(
//           leading: const Icon(Icons.add_circle),
//           title: const Text('Add account'),
//           onTap: () => Navigator.pop(context, 'Add account'),
//         ),
//       ],
//     ),
//   ).then((returnVal) {
//     if (returnVal != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('You clicked: $returnVal'),
//           action: SnackBarAction(label: 'OK', onPressed: () {}),
//         ),
//       );
//     }
//   });

//   // child: const Text('Simple dialog')
//   ;
// }





//  ////// Simple Dialog.  ////// Time Picker Dialog. ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () { final DateTime now = DateTime.now(); showTimePicker( context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute), ).then((TimeOfDay? value) { if (value != null) { ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(value.format(context)), action: SnackBarAction(label: 'OK', onPressed: () {}), ), ); } }); }, child: const Text('Time Picker Dialog'), ), ////// Date Picker Dialog. ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: () { showDatePicker( context: context, initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2025), ).then((DateTime? value) { if (value != null) { DateTime _fromDate = DateTime.now(); _fromDate = value; final String date = DateFormat.yMMMd().format(_fromDate); ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Selected date: date')),                );              }            });          },          child: const Text('Date Picker Dialog'),        ),        ////// DateRange Picker Dialog.        ElevatedButton(          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),          onPressed: () {            showDateRangePicker(              context: context,              firstDate: DateTime(2018),              lastDate: DateTime(2025),            ).then((DateTimeRange? value) {              if (value != null) {                DateTimeRange _fromRange =                    DateTimeRange(start: DateTime.now(), end: DateTime.now());                _fromRange = value;                final String range =                    '{DateFormat.yMMMd().format(_fromRange.start)} - ${DateFormat.yMMMd().format(_fromRange.end)}'; ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(range)), ); } }); }, child: const Text('Date Range Picker Dialog'), ), ////// Bottom Sheet Dialog. ElevatedButton( style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), onPressed: () { // Or: showModalBottomSheet(), with model bottom sheet, clicking // anywhere will dismiss the bottom sheet. showBottomSheet<String?>( context: context, builder: (BuildContext context) => Container( decoration: const BoxDecoration( border: Border(top: BorderSide(color: Colors.black12)), ), child: ListView( shrinkWrap: true, primary: false, children: [ const ListTile( dense: true, title: Text('This is a bottom sheet'), ), const ListTile( dense: true, title: Text('Click OK to dismiss'), ), ButtonBar( children: [ TextButton( onPressed: () => Navigator.pop(context), child: const Text('OK'), ), ], ), ], ), ), ); }, child: const Text('Bottom Sheet'), ), ] .map( (Widget button) => Container( padding: const EdgeInsets.symmetric(vertical: 8.0), child: button, ), ) .toList(), ); }}