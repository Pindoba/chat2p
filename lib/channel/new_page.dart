import 'package:chat2p/shared/compo.dart';
import 'package:flutter/material.dart';
// import 'package:myapp/favorito_page.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return 
    
     Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 123, 2, 204),
        title: Text('Novo'),
        
        ),
      
      body: Center(
        child: Column(children: [
          NewFunction(texto: 'Novo Contato', icone: const Icon(Icons.person_add, size: 48,),),
          NewFunction(texto: 'Novo Grupo', icone: Icon(Icons.groups, size: 40,),),
          NewFunction(texto: 'Nova Categoria', icone: Icon(Icons.category, size: 48,),),
        ]),
      ),
    )
    
    
    
    ;
  }
}