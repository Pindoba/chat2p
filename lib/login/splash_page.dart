import 'package:chat2p/appbar_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



// class SplashPage extends StatelessWidget {
//   const SplashPage({super.key});

  // @override
  // Widget build(BuildContext context) {







class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 80.0,
  fontFamily: 'Horizon',

);
  
    // return 
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color.fromARGB(255, 63, 63, 63),
        // width: double.infinity,
        // height: double.infinity,
        child: Center(
          child: AnimatedTextKit(
             animatedTexts: [
            ColorizeAnimatedText(
              'Chat2P',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
              speed: const Duration(seconds: 2),
      
            ),
            
           
          ],
          isRepeatingAnimation: true,
          onTap: () {
             Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  AppBarPage()));
          },
            ),
        ),
        ),
      ),
    );
    
  }
}


















    
  //   return MaterialApp(
  //     title: 'Chat2P',
  //     theme: ThemeData(

  //       useMaterial3: false, 
  //       colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 2, 204)),//.copyWith(background: Colors.black26),
  //       // brightness: Brightness.dark,
  //       primaryColor: Color.fromARGB(255, 123, 2, 204)
  //     ),
  //     home: const Splash(),
  //   );
  // }
// }



// class Splash extends StatelessWidget {
//   const Splash({super.key});

  // @override
  // Widget build(BuildContext context) {
//     const colorizeColors = [
//   Colors.purple,
//   Colors.blue,
//   Colors.yellow,
//   Colors.red,
// ];

// const colorizeTextStyle = TextStyle(
//   fontSize: 80.0,
//   fontFamily: 'Horizon',

// );
  
//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: const Color.fromARGB(255, 63, 63, 63),
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: AnimatedTextKit(
//              animatedTexts: [
//             ColorizeAnimatedText(
//               'Chat2P',
//               textStyle: colorizeTextStyle,
//               colors: colorizeColors,
//               speed: const Duration(seconds: 2),
      
//             ),
            
           
//           ],
//           isRepeatingAnimation: true,
//           onTap: () {
//              Navigator.push(context,
//           MaterialPageRoute(builder: (context) =>  AppBarPage()));
//           },
//             ),
//         ),
//         ),
//       ),
//     );
  // }





  //     body: Center(
     
  //       child: Column(
       
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[ElevatedButton(onPressed: (){
  //           Navigator.push(context,
  //   MaterialPageRoute(builder: (context) =>  AppBarPage()),
  // );
  //         }, child: Text('Login')),
