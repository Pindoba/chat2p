import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';

class BuscarPage extends StatefulWidget {
  const BuscarPage({super.key, required this.client});
  final Client client;



  @override
  State<BuscarPage> createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  @override
  Widget build(BuildContext context) {



      final TextEditingController _addController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Buscar usuários ou salas'),),
      body: Column(
        children: [
          Text('Buscar usuário'),
          TextFormField(
            controller: _addController,
          ),
          ElevatedButton(
              onPressed: () {
                
              },
              child: Text('Convidar contato'))
        ],
      ),
    );
  }
}
