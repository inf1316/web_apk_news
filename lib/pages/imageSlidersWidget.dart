import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/publicationApiService.dart';

import 'imageFullScreenWidget.dart';

class ImageSliders extends StatelessWidget {
  final List<String> imageList;
  final PublicationApiService apiService = PublicationApiService();
  String view;
  String idPublication;

  ImageSliders(
      {Key key,
      @required this.imageList,
      @required this.view,
      this.idPublication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = imageList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        InkResponse(
                            onTap: () {
                              apiService.setViews(view, idPublication);
                              Navigator.push<Widget>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ImageFullScreen(item);
                                  },
                                ),
                              );
                            },
                            child: Image.network(item,
                                fit: BoxFit.cover, width: 1000.0)),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    return new CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          scrollDirection: Axis.vertical,
          autoPlay: true,
        ),
        items: imageSliders);
  }
}
