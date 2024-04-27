import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

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
                  styleSheet: MarkdownStyleSheet(
                    // a: TextStyle(fontSize: 17),
                    // p: TextStyle(fontSize: 17),
                    // checkbox: TextStyle(fontSize: 17),
                    // h1: TextStyle(fontSize: 30),
                    // h2: TextStyle(fontSize: 28),
                    // h3: TextStyle(fontSize: 26),
                    h1Align: WrapAlignment.center,
                    textScaleFactor: 1.2
                    
                    ),
                  shrinkWrap: true,
                  fitContent: true,
                  extensionSet: md.ExtensionSet(
                                md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                                <md.InlineSyntax>[
                                  md.EmojiSyntax(),
                                  ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                                ],
                              ),
                  onSelectionChanged: (text, selection, cause) {
                    
                  },
                  onTapText: () {
                    
                  },
                  data:body_msg.toString(),
                  selectable: true,
                  // onTapLink: (text, href, title) => Uri(),
                  
                  ),
                     
                    //  SelectableText(
                    //   body_msg,
                    //   style: TextStyle(fontSize: 16),
                    // )
                    





                    )
    ;
  }
}



