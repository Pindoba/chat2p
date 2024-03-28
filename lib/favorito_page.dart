import 'package:flutter/material.dart';

class FavoritoPage extends StatefulWidget {
  const FavoritoPage({super.key});

  @override
  State<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(

      appBar: AppBar(backgroundColor: Color.fromARGB(255, 123, 2, 204),
      title: const Text('Mensagens favoritadas'),),
      body: const Center(
        child: Column(children: [
          Text('Favorito')
        ]),
      ),
    )
    
    
    
    ;
  }
}