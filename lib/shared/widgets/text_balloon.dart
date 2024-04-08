import 'package:flutter/material.dart';

class TextBalloon extends StatelessWidget {
  const TextBalloon({super.key, this.body_msg});
  final  body_msg;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: body_msg == "Redacted" ?
                    const Row(children: [
                      Icon(Icons.delete, color: Colors.redAccent),
                      Text("Mensagem apagada",style: TextStyle(color: Colors.redAccent,),)
                    ],):
                     SelectableText(
                      body_msg,style: TextStyle(fontSize: 16),
                    ))
    ;
  }
}