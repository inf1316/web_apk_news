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

      Response response = await _dio.get('$URL_API/ofertas-laborales',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        var responseData = (response.data['ofertas'] as List)
            .map((offers) => JobOffersModel.fromJson(offers))
            .toList();

        for (var offer in responseData) {
          result.add(JobOffer(offer.companyModel.nameCompany, offer.description,
              offer.contactData));
        }
        return result;
      } else {
        throw new Exception("Failed jobOffers ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }
}
