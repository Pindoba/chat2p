import 'package:chat2p/login/splash_page.dart';
import 'package:chat2p/talk/chat_page.dart';
import 'package:flutter/material.dart';


class ContactComponent extends StatelessWidget {
  const ContactComponent({super.key, 
  required this.name, 
  required this.picture, 
  this.page});
    final String name;
    final String picture;
    final Function? page;

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
          Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>  ChatPage()));
        },
        child:  Container(
          height: 80,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0.0, 0.75, )
              )
            ],
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),),
          child: Row(
            children: [
              CircleAvatar(child:Image.network(picture) ,),
              // Image.network(''),
              const SizedBox(width: 20,),
              Column(
                children: [
                  Text(name,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  ),
                  Text('Inicio da ultima mensagem recebida...')
                ],
              ),

            ]
          ),
        ),
      )
    ;
  }
}



icone() {
}

void rota() {
}