import 'dart:io';
import 'package:dio/dio.dart';
import 'package:web_apk_news/models/newsModel.dart';
import 'package:web_apk_news/shared/newsList.dart';
import 'clientTokenApiService.dart';
import 'package:web_apk_news/constant/constants.dart';

class NewsApiService {
  Future<List<NewsList>> getAll([bool present]) async {
    Dio _dio = new Dio();
    List<NewsList> result = [];

    try {
      var token = await ClientTokenApiService().getToken();
      Response response;
      if (present) {
        response = await _dio.get('$URL_API/noticias',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
            queryParameters: {'flag': true});
      } else {
        response = await _dio.get('$URL_API/noticias',
            options: Options(headers: {'Authorization': 'Bearer $token'}));
      }
      if (response.statusCode == 200) {
        var responseData = (response.data['noticia'] as List)
            .map((news) => NewsModel.fromJson(news))
            .toList();

        responseData.asMap().forEach((key, value) {
          result.add(NewsList(
              idNews: value.idNews,
              imgUrl: '$LOCALHOST' + value.imageNewsModel[0].url_img,
              newsTitle: value.titular,
              author: value.journalistNewsModel[0].name,
              imageAuthor: '$LOCALHOST' + value.journalistNewsModel[0].imageUrl,
              content: value.content,
              view: value.view,
              date: value.publicationDate));
        });

        return result;
      } else {
        throw new Exception("Failed news ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }

  Future<bool> setViews(String views, String idNews) async {
    Dio _dio = new Dio();

    try {
      int viewParse = int.parse(views);
      var token = await ClientTokenApiService().getToken();
      var params = {"views": viewParse += 1, "idNoticia": idNews};

      Response response = await _dio.post('$URL_API/noticias/view',
          data: params,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        return Future.value(true);
      } else {
        throw new Exception("Failed update views ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }
}
