import 'package:web_apk_news/models/publicationImageModel.dart';

class PublicationModel {
  int idPublication;
  String title;
  String datePublication;
  int view;
  List<PublicationImageModel> publicationImageModel;

  PublicationModel({this.title, this.datePublication, this.view});

  PublicationModel.fromJson(Map<String, dynamic> json)
      : title = json["titulo"],
        idPublication = (json["id_publicacion"] as int),
        datePublication = json["fecha_publicacion"],
        view = (json["view"] as int),
        publicationImageModel = (json['imgPublicacions'] as List)
            .map((publicationImageModel) =>
                new PublicationImageModel.fromJson(publicationImageModel))
            .toList();
}
