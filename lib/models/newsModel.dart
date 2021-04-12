import 'imageNewsModel.dart';
import 'journalistNewsModel.dart';

class NewsModel {
  int idNews;
  String publicationDate;
  String titular;
  String content;
  int view;
  List<ImageNewsModel> imageNewsModel;
  List<JournalistNewsModel> journalistNewsModel;

  NewsModel(
      {this.idNews,
      this.publicationDate,
      this.titular,
      this.content,
      this.imageNewsModel,
      this.journalistNewsModel});

  NewsModel.fromJson(Map<String, dynamic> json)
      : idNews = json["id_noticias"],
        publicationDate = json["fecha_publicacion"],
        titular = json["titular"],
        content = json["contenido"],
        view = json["views"],
        imageNewsModel = (json['imgNoticias'] as List)
            .map((imageNews) => new ImageNewsModel.fromJson(imageNews))
            .toList(),
        journalistNewsModel = (json['periodistas'] as List)
            .map((journalist) => new JournalistNewsModel.fromJson(journalist))
            .toList();
}
