import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// for show image in full screen
// See more: https://pub.dev/packages/photo_view
class ImageFullScreen extends StatefulWidget {
  final String url;
  ImageFullScreen(this.url);

  @override
  _ImageFullScreen createState() => _ImageFullScreen(url);
}

class _ImageFullScreen extends State<ImageFullScreen> {
  final String url;

  _ImageFullScreen(this.url);

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
