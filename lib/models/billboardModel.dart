class BillBoardModel {
  String time;
  String description;
  String program;

  BillBoardModel({this.time, this.description, this.program});

  BillBoardModel.fromJson(Map<String, dynamic> json)
      : time = json["hora"],
        description = json["descripcion"],
        program = json["programa"];
}
