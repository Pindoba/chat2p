import 'package:chat2p/login/splash_page.dart';
import 'package:flutter/material.dart';


class NewFunction extends StatelessWidget {
  const NewFunction({super.key, 
  required this.texto, 
  required this.icone, 
  this.page});
    final String texto;
    final Icon icone;
    final Function? page;

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: () {
          Navigator.push(context,
          MaterialPageRoute(
            builder: (context) =>  SplashPage()));
        },
        child:  Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            
            color:Color.fromARGB(255, 123, 2, 204),
            borderRadius: BorderRadius.circular(10),),
          child: Row(
            children: [
              icone,
              const SizedBox(width: 20,),
              Text(texto,
              style: const TextStyle(
                fontSize: 18,


              ),
              ),

            ]
          ),
        ),
      )
    ;
  }
}



icone() {
}

void rota() {
}