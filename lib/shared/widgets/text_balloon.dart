import 'package:flutter/material.dart';

class TextBalloon extends StatelessWidget {
  const TextBalloon({super.key, this.body_msg});
  final  body_msg;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: SelectableText(
                      body_msg,
                    ))
    ;
  }
}