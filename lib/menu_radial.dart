import 'package:animated_radial_menu/animated_radial_menu.dart';
import 'package:flutter/material.dart';

class RadialMenuPage extends StatelessWidget {
  const RadialMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  

      body: RadialMenu(
        children: [
          RadialButton(
            
            icon: Icon(Icons.ac_unit),
            buttonColor: Colors.teal,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TargetScreen()),
            ),
          ),
          RadialButton(
            icon: Icon(Icons.camera_alt),
            buttonColor: Colors.green,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TargetScreen()),
            ),
          ),
          RadialButton(
            icon: Icon(Icons.map),
            buttonColor: Colors.orange,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TargetScreen()),
            ),
          ),
          RadialButton(
            icon: Icon(Icons.access_alarm),
            buttonColor: Colors.indigo,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TargetScreen()),
            ),
          ),
          RadialButton(
            icon: Icon(Icons.watch),
            buttonColor: Colors.pink,
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TargetScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class TargetScreen extends StatelessWidget {
  const TargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Target Screen")),
    );
  }
}