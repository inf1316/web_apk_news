import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_apk_news/service/publicationApiService.dart';
import 'package:web_apk_news/shared/imageCard.dart';
import 'imageCardWidget.dart';

class ImageList extends StatefulWidget {
  const ImageList({Key key}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final PublicationApiService apiService = PublicationApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: 80,
        child: FutureBuilder(
            future: apiService.getAll(),
            builder: (context, AsyncSnapshot<List<ImageListCard>> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Column(children: [Icon(Icons.error, size: 120)]));
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<ImageListCard> imageCard = snapshot.data;
                return ListView.builder(
                    itemCount: imageCard.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          child: ImageCard(
                            imageListCard: ImageListCard(
                              imageCard[index].imageTitle,
                              imageCard[index].datePublication,
                              "10 min",
                              imageCard[index].viewImage,
                              imageCard[index].urlImage,
                              imageCard[index].idPublication,
                            ),
                          ),
                        ),
                        onTap: () {
                          print("click in image");
                        },
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
