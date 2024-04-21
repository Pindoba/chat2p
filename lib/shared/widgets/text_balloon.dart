import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TextBalloon extends StatelessWidget {
  const TextBalloon({super.key, this.body_msg});
  final String? body_msg;
  

  @override
  Widget build(BuildContext context) {
    return 
    Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: body_msg == "Redacted" ?
                     const SizedBox(width: 180,
                      child: Row(
                        
                        children: [
                        Icon(Icons.delete, color: Colors.redAccent),
                        Text("Mensagem apagada",style: TextStyle( color: Colors.redAccent,),)
                      ],),
                    ):


                 MarkdownBody(
                  data:body_msg.toString(),
                  selectable: true,
                  onTapLink: (text, href, title) => body_msg,
                  
                  ),
                     
                    //  SelectableText(
                    //   body_msg,
                    //   style: TextStyle(fontSize: 16),
                    // )
                    





                    )
    ;
  }
}



