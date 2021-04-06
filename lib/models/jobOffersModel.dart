import 'package:web_apk_news/models/companyModel.dart';

class JobOffersModel {
  String description;
  String contactData;
  CompanyModel companyModel;

  JobOffersModel({this.description, this.contactData, this.companyModel});

  JobOffersModel.fromJson(Map<String, dynamic> json)
      : description = json["descripcion"],
        contactData = json["datos_contactos"],
        companyModel = CompanyModel.fromJson(json["empresa"]);
}
