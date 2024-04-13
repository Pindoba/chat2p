import 'package:chat2p/buscar_page.dart';
import 'package:chat2p/call/calls_page.dart';
import 'package:chat2p/channel/canal_page.dart';
import 'package:chat2p/perfil_page.dart';
import 'package:chat2p/spaces/space_page.dart';
import 'package:chat2p/talk/talk_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

const _kPages = {
  'Mensagens': Icons.message,
  'Canais': Icons.fact_check_rounded,
  'Espaços': Icons.groups_2_rounded,
  'Chamadas': Icons.call,
  'Perfil': Icons.person,
};

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  final TabStyle _tabStyle = TabStyle.reactCircle;
  final page = const TalkPage();

  @override
  Widget build(BuildContext context) {
    // print('aqui ok');

    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
           Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BuscaPage(),
      ),
    );

            // (BuildContext context) => BuscarPage(
            //       // client: client,
            //     );
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: const Column(
          children: [
            // _buildStyleSelector(),

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
          //  Colors.amber,
          backgroundColor: const Color.fromARGB(255, 123, 2, 204),
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

  // Select style enum from dropdown menu:
  // Widget _buildStyleSelector() {
  //   final dropdown = DropdownButton<TabStyle>(
  //     value: _tabStyle,
  //     onChanged: (newStyle) {
  //       if (newStyle != null) setState(() => _tabStyle = newStyle);
  //     },
  //     items: [
  //       for (final style in TabStyle.values)
  //         DropdownMenuItem(
  //           value: style,
  //           child: Text(style.toString()),
  //         )
  //     ],
  //   );
  //   return ListTile(
  //     contentPadding: const EdgeInsets.all(8),
  //     title: const Text('appbar style:'),
  //     trailing: dropdown,
  //   );
  // }
}
