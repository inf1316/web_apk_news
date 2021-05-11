import 'package:web_apk_news/models/publicationImageModel.dart';

class PublicationModel {
  String idPublication;
  String title;
  String datePublication;
  String dateFullPublication;
  String view;
  List<PublicationImageModel> publicationImageModel;

  PublicationModel(
      {this.title, this.datePublication, this.view, this.dateFullPublication});

  PublicationModel.fromJson(Map<String, dynamic> json)
      : title = json["titulo"],
        idPublication = (json["id_publicacion"]),
        datePublication = json["fecha_publicacion"],
        view = (json["view"]),
        dateFullPublication = json['fecha_publicacion_aux'],
        publicationImageModel = (json['imgPublicacions'] as List)
            .map((publicationImageModel) =>
                new PublicationImageModel.fromJson(publicationImageModel))
            .toList();
}
