class CompanyModel {
  String nameCompany;

  CompanyModel({this.nameCompany});

  CompanyModel.fromJson(Map<String, dynamic> json)
      : nameCompany = json["nombre_empresa"];
}
