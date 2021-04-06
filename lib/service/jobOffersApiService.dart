import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:web_apk_news/models/jobOffersModel.dart';
import 'package:web_apk_news/constant/constants.dart';
import 'package:web_apk_news/shared/jobOffer.dart';

import 'clientTokenApiService.dart';

class JobOffersApiService {
  Future<List<JobOffer>> getAll() async {
    Dio _dio = new Dio();
    List<JobOffer> result = [];
    
    try {
      var token = await ClientTokenApiService().getToken();

      // See more: https://pub.dev/packages/dio - Https certificate verification
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      Response request = await _dio.get('$URL_API/ofertas-laborales',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      var response =  (request.data['ofertas'] as List)
          .map((offers) => JobOffersModel.fromJson(offers))
          .toList();

      for (var offer in response) {
        result.add(JobOffer(offer.companyModel.nameCompany,
            offer.description, offer.contactData
        ));
      }
      return result;

    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }
}
