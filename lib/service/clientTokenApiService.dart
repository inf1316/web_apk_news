import 'dart:io';
import 'package:dio/dio.dart';
import 'package:web_apk_news/constant/constants.dart';

// See more (HTTPS in Localhost) : https://gist.github.com/adnan360/ad2b1cfc44114ac6f91fbb668c76798d
class ClientTokenApiService {
  Future<String> getToken() async {
    Dio _dio = new Dio();

    try {
      var params = {"username": "manuel", "password": "admin"};

      Response response = await _dio.post('$URL_API/login/login',
          data: params,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw new Exception("Failed authentication ...");
      }
    } on DioError catch (e) {
      print(e);
      throw new Exception(e);
    }
  }
}
