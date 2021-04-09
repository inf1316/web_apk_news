class LostFindingModel {
  String description;
  String contactDetails;
  String state;
  String titular;

  LostFindingModel(
      {this.description, this.contactDetails, this.state, this.titular});

  LostFindingModel.fromJson(Map<String, dynamic> json)
      : description = json["descripcion"],
        contactDetails = json["datos_contacto"],
        state = json["estado"],
        titular = json["titular"];
}
