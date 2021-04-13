class PublicationImageModel {
  String subTitle;
  String urlImage;

  PublicationImageModel({this.subTitle, this.urlImage});

  PublicationImageModel.fromJson(Map<String, dynamic> json)
      : subTitle = json["subtitulo"],
        urlImage = json["urlimage"];
}
