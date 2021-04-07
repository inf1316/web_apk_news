class ImageNewsModel {
  String url_img;

  ImageNewsModel({this.url_img});

  ImageNewsModel.fromJson(Map<String, dynamic> json)
      : url_img = json["url_img"];
}
