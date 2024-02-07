class SiblingList {
  bool? status;
  List<SiblingListDatum>? data;
  String? message;

  SiblingList({
    this.status,
    this.data,
    this.message,
  });

  factory SiblingList.fromJson(Map<String, dynamic> json) => SiblingList(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SiblingListDatum>.from(
                json["data"]!.map((x) => SiblingListDatum.fromJson(x))),
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

class SiblingListDatum {
  String? applicationnumber;
  String? name;

  SiblingListDatum({
    this.applicationnumber,
    this.name,
  });

  factory SiblingListDatum.fromJson(Map<String, dynamic> json) =>
      SiblingListDatum(
        applicationnumber: json["applicationnumber"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "applicationnumber": applicationnumber,
        "name": name,
      };
}
