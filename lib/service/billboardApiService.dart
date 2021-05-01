import 'package:dio/dio.dart';
import 'package:web_apk_news/models/billboardModel.dart';
import 'package:web_apk_news/constant/constants.dart';
import 'package:web_apk_news/shared/billboard.dart';

import 'clientTokenApiService.dart';

class BillboardApiService {
  Future<List<BillBoards>> getAll(int day) async {
    Dio _dio = new Dio();
    List<BillBoards> result = [];

    try {
      var token = await ClientTokenApiService().getToken();
      var dayConvert = convertDay(day);

      Response response = await _dio.get('$URL_API/perlavision',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          queryParameters: {'day': dayConvert});

      if (response.statusCode == 200) {
        var responseData = (response.data['program'] as List)
            .map((billboard) => BillBoardModel.fromJson(billboard))
            .toList();

        for (var offer in responseData) {
          result.add(new BillBoards(
              title: offer.program,
              subtitle: offer.description,
              hours: offer.time));
        }
        return result;
      } else {
        throw new Exception("Failed Billboard ...");
      }
    } on DioError catch (ex) {
      throw new Exception(ex);
    }
  }

  String convertDay(int day) {
    switch (day) {
      case 1:
        return "lunes";
      case 2:
        return "martes";
      case 3:
        return "miércoles";
      case 4:
        return "jueves";
      case 5:
        return "viernes";
      case 6:
        return "sabado";
      case 7:
        return "domingo";
    }
    return "";
  }
}
