import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatefulWidget {
  final String url;
  ImageScreen(this.url);

  @override
  _MyImageScreen createState() => _MyImageScreen(url);
}

// See more: https://pub.dev/packages/photo_view
class _MyImageScreen extends State<ImageScreen> {
  final String url;

  _MyImageScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: [
        PhotoView(imageProvider: new NetworkImage(url)),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        )
      ],
    ));
  }
}
