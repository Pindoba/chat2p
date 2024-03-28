import 'package:flutter/material.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key});

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(

      appBar: AppBar(backgroundColor: Color.fromARGB(255, 123, 2, 204),
      title: Text('Chamadas'),),
      body: Center(
        child: Column(children: [
          Text('Ligações')
        ]),
      ),
    )
    
    
    
    ;
  }
}