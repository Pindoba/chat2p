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

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      title: Text('Chamadas'),
      centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          Text('Ligações')
        ]),
      ),
    )
    
    
    
    ;
  }
}