import 'package:flutter/material.dart';

class TalkAllPage extends StatefulWidget {
  const TalkAllPage({super.key});

  @override
  State<TalkAllPage> createState() => _TalkAllPageState();
}

class _TalkAllPageState extends State<TalkAllPage> {
  @override
  Widget build(BuildContext context) {
      print('aqui ok talk all');

    return  Center(child: SingleChildScrollView(child: 
    Column(
      children: [ListView.builder(
        itemCount: 10,

        itemBuilder: (context,index){
          return Container(height: 20,
          color: Colors.red,
          child:  Text('Todas conversas aqui!'),
          );
        },
      ),
      ],
    ),
    )
    );
  }
  }

        
        
      