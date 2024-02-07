class RaisingToModel {
  bool? status;
  List<RaisingToDatum>? data;
  String? message;

  RaisingToModel({
    this.status,
    this.data,
    this.message,
  });

  factory RaisingToModel.fromJson(Map<String, dynamic> json) => RaisingToModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<RaisingToDatum>.from(
                json["data"]!.map((x) => RaisingToDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RaisingToDatum {
  String? name;
  String? employeeid;
  String? userid;

  RaisingToDatum({
    this.name,
    this.employeeid,
    this.userid,
  });

  factory RaisingToDatum.fromJson(Map<String, dynamic> json) => RaisingToDatum(
        name: json["name"],
        employeeid: json["employeeid"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "employeeid": employeeid,
        "userid": userid,
      };
}
