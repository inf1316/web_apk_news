import 'package:dio/dio.dart';
import 'package:web_apk_news/models/lostFindingModel.dart';
import 'package:web_apk_news/shared/lostFinding.dart';
import 'clientTokenApiService.dart';
import 'package:web_apk_news/constant/constants.dart';

class LostFindingApiService {
  Future<List<LostFinding>> getAll() async {
    Dio _dio = new Dio();
    List<LostFinding> result = [];

    try {
      var token = await ClientTokenApiService().getToken();

      Response response = await _dio.get('$URL_API/perdida',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        var responseData = (response.data['perdidasHallazgo'] as List)
            .map((lost) => LostFindingModel.fromJson(lost))
            .toList();

        for (var offer in responseData) {
          result.add(LostFinding(
              description: offer.description,
              contactDetails: offer.contactDetails,
              state: offer.state,
              titular: offer.titular));
        }
        return result;
      } else {
        throw new Exception("Failed LostFinding ...");
      }
    } on DioError catch (e) {
      print(e);
      throw new Exception(e);
    }
  }
}
