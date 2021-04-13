import 'package:dio/dio.dart';
import 'package:web_apk_news/constant/constants.dart';
import 'package:web_apk_news/models/publicationModel.dart';
import 'package:web_apk_news/shared/imageCard.dart';
import 'clientTokenApiService.dart';

class PublicationApiService {
  Future<List<ImageListCard>> getAll([bool present]) async {
    Dio _dio = new Dio();
    List<ImageListCard> result = [];

    try {
      var token = await ClientTokenApiService().getToken();

      Response response = await _dio.get('$URL_API/publicaciones',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          queryParameters: {'flag': true});

      if (response.statusCode == 200) {
        var responseData = (response.data['publicaciones'] as List)
            .map((news) => PublicationModel.fromJson(news))
            .toList();

        responseData.asMap().forEach((key, value) {
          result.add(new ImageListCard(
              value.title,
              value.datePublication,
              "10 min",
              value.view,
              value.publicationImageModel
                  .map((e) => '$LOCALHOST' + e.urlImage)
                  .toList()));
        });
        return result;
      } else {
        throw new Exception("Image publication failed ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }
}
