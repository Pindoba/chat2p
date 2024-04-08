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
    return Scaffold(
      body: Column(
        children: [
          Text('Buscar usuário'),
          TextFormField(),
          ElevatedButton(
              onPressed: () {
              },
              child: Text('Convidar contato'))
        ],
      ),
    );
  }
}
