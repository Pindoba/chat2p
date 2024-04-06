import 'package:chat2p/spaces/list_space_page.dart';
import 'package:flutter/material.dart';

class SpacePage extends StatelessWidget {
  const SpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Container(
        
        child: ListSpacePage(),),
    )
    
    ;
  }
}