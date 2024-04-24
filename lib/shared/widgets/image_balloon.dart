import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBalloon extends StatelessWidget {
  const ImageBalloon({super.key, required this.url_image});
  final String url_image;

  @override
  Widget build(BuildContext context) {
    return 
    




    Container(
      constraints: const BoxConstraints(
                    
                     maxWidth: 250),
      child: CachedNetworkImage(
         imageUrl: url_image,
         progressIndicatorBuilder: (context, url, downloadProgress) => 
                 CircularProgressIndicator(value: downloadProgress.progress),
         errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    )




    
    // Container(
    //               constraints: const BoxConstraints(
                    
    //                 maxWidth: 250),
    //               child: Image.network(
    //                 url_image,

    //                 fit: BoxFit.fitWidth,
    //               ),
    //             )
    ;
  }
}