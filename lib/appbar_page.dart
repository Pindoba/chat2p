import 'package:chat2p/call/calls_page.dart';
import 'package:chat2p/channel/canal_page.dart';
import 'package:chat2p/create/create_room_page.dart';
import 'package:chat2p/perfil_page.dart';
import 'package:chat2p/spaces/space_page.dart';
import 'package:chat2p/talk/talk_page.dart';
import 'package:chat2p/search_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:signals/signals_flutter.dart';

final typeRoom = Signal('room');
final GlobalKey<AnimatedFloatingActionButtonState> key =
    GlobalKey<AnimatedFloatingActionButtonState>();

const _kPages = {
  'Mensagens': Icons.message,
  'Canais': Icons.fact_check_rounded,
  'Espaços': Icons.groups_2_rounded,
  'Chamadas': Icons.call,
  'Perfil': Icons.person,
};

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key, this.client});
  final Client? client;

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  final TabStyle _tabStyle = TabStyle.reactCircle;
  final page = const TalkPage();

  @override
  Widget build(BuildContext context) {
    Widget search() {
      return SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SearchPage(),
              ),
            );
          },
          heroTag: "search",
          // tooltip: 'First button',
          child: const Row(
            children: [Icon(Icons.search), Text('Buscar')],
          ),
        ),
      );
    }

    Widget createRoom() {
      return SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed: () {
            typeRoom.value = 'room';
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CreateRoom(
                  typeRoom: 'room',
                ),
              ),
            );
          },
          heroTag: "createRoom",
          // tooltip: '',
          child: Row(
            children: [Icon(Icons.add), Text('Criar sala')],
          ),
        ),
      );
    }

    Widget createChannel() {
      return  SizedBox(
        width: 150,
        child: FloatingActionButton(
          onPressed:  () {
            typeRoom.value = 'channel';
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CreateRoom(
                  typeRoom: 'room',
                ),
              ),
            );
          },
          heroTag: "createChannel",
          tooltip: '',
          child: Row(
            children: [Icon(Icons.add), Text('Criar canal')],
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: AnimatedFloatingActionButton(
          curve: Curves.linear,
          fabButtons: <Widget>[search(), createRoom(), createChannel()],
          key: key,
          colorStartAnimation: Theme.of(context).indicatorColor,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
          durationAnimation: 350,
        ),
        body: const Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  TalkPage(),
                  CanalPage(),
                  SpacePage(),
                  CallsPage(),
                  PerfilPage()
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          shadowColor: Theme.of(context).indicatorColor,
          backgroundColor: Theme.of(context).primaryColor,
          // const <int, dynamic>{3: '69', 0: '3'},
          const <int, dynamic>{0: 0},
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
        ),
      ),
    );
  }
}
