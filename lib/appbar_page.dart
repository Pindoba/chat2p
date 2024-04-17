import 'package:chat2p/buscar_page.dart';
import 'package:chat2p/call/calls_page.dart';
import 'package:chat2p/channel/canal_page.dart';
import 'package:chat2p/perfil_page.dart';
import 'package:chat2p/spaces/space_page.dart';
import 'package:chat2p/talk/talk_page.dart';
import 'package:chat2p/teste_buscar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:matrix/matrix.dart';

const _kPages = {
  'Mensagens': Icons.message,
  'Canais': Icons.fact_check_rounded,
  'Espaços': Icons.groups_2_rounded,
  'Chamadas': Icons.call,
  'Perfil': Icons.person,
};

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key,  this.client});
  final Client? client;

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  final TabStyle _tabStyle = TabStyle.reactCircle;
  final page = const TalkPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SearchScreen(),
              ),
            );

            // (BuildContext context) => BuscarPage(
            //       // client: client,
            //     );
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
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
          shadowColor: Colors.amber,
          //  Colors.amber,
          backgroundColor: Theme.of(context).primaryColor,
          // const <int, dynamic>{3: '69'},
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
