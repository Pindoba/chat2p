import 'package:flutter/material.dart';

class ImageBalloon extends StatelessWidget {
  const ImageBalloon({super.key, required this.url_image});
  final String url_image;

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
                  // constraints: const BoxConstraints(
                    
                  //   maxWidth: 250),
                  child: Image.network(
                    url_image,

                    fit: BoxFit.fitWidth,
                  ),
                )
    ;
  }
}