import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:web_apk_news/models/newsModel.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'clientTokenApiService.dart';
import 'package:web_apk_news/constant/constants.dart';

class NewsApiService {
  Future<List<NewsList>> getAll() async {
    Dio _dio = new Dio();
    List<NewsList> result = [];

    try {
      var token = await ClientTokenApiService().getToken();
      Response response = await _dio.get('$URL_API/noticias',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        var responseData = (response.data['noticia'] as List)
            .map((news) => NewsModel.fromJson(news))
            .toList();

        responseData.asMap().forEach((key, value) {
          result.add(NewsList('$LOCALHOST' + value.imageNewsModel[0].url_img,
              value.titular, value.journalistNewsModel[0].name, value.publicationDate, value.content));
        });

        return result;
      } else {
        throw new Exception("Failed news ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }
}
