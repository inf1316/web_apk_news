import 'package:web_apk_news/models/publicationImageModel.dart';

class PublicationModel {
  String title;
  String datePublication;
  String view;
  List<PublicationImageModel> publicationImageModel;

  PublicationModel({this.title, this.datePublication, this.view});

  PublicationModel.fromJson(Map<String, dynamic> json)
      : title = json["titulo"],
        datePublication = json["fecha_publicacion"],
        view = json["view"],
        publicationImageModel = (json['imgPublicacions'] as List)
            .map((publicationImageModel) =>
                new PublicationImageModel.fromJson(publicationImageModel))
            .toList();
}
