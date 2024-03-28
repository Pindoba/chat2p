// import 'package:matrix/matrix.dart';


// Future<void> teste() async {


// final client = Client("Chat2P");

// client.onLoginStateChanged.stream.listen((bool loginState){ 
//   print("LoginState: ${loginState.toString()}");
// } as void Function(LoginState event)?);

// client.onEvent.stream.listen((EventUpdate eventUpdate){ 
//   print("New event update!");
// });

// client.onRoomUpdate.stream.listen((RoomUpdate eventUpdate){ 
//   print("New room update!");
// });

// await client.checkHomeserver("https://matrix.org");
// await client.login(
//   identifier: AuthenticationUserIdentifier(user: 'welton89'),
//   password: 'maximo36',
// );

// await client.getRoomById('your_room_id').sendTextEvent('Hello world');

// }