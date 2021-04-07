class JournalistNewsModel {
  String name;
  String imageUrl;

  JournalistNewsModel({this.name, this.imageUrl});

  JournalistNewsModel.fromJson(Map<String, dynamic> json)
      : name = json["nombre"],
        imageUrl = json["img_perfil"];
}
