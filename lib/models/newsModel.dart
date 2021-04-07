import 'imageNewsModel.dart';
import 'journalistNewsModel.dart';

class NewsModel {
  int idNew;
  String publicationDate;
  String titular;
  String content;
  List<ImageNewsModel> imageNewsModel;
  List<JournalistNewsModel> journalistNewsModel;

  NewsModel(
      {this.idNew,
      this.publicationDate,
      this.titular,
      this.content,
      this.imageNewsModel,
      this.journalistNewsModel});

  NewsModel.fromJson(Map<String, dynamic> json)
      : idNew = json["id_noticias"],
        publicationDate = json["fecha_publicacion"],
        titular = json["titular"],
        content = json["contenido"],
        imageNewsModel = (json['imgNoticias'] as List)
            .map((imageNews) => new ImageNewsModel.fromJson(imageNews))
            .toList(),
        journalistNewsModel = (json['periodistas'] as List)
            .map((journalist) => new JournalistNewsModel.fromJson(journalist))
            .toList();
}
