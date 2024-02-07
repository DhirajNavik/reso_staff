// To parse this JSON data, do
//
//     final viewDashBoardModel = viewDashBoardModelFromJson(jsonString);

import 'dart:convert';

ViewDashBoardModel viewDashBoardModelFromJson(String str) =>
    ViewDashBoardModel.fromJson(json.decode(str));

String viewDashBoardModelToJson(ViewDashBoardModel data) =>
    json.encode(data.toJson());

class ViewDashBoardModel {
  bool? status;
  List<DashBoardDatum>? data;
  String? message;

  ViewDashBoardModel({
    this.status,
    this.data,
    this.message,
  });

  factory ViewDashBoardModel.fromJson(Map<String, dynamic> json) =>
      ViewDashBoardModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DashBoardDatum>.from(
                json["data"]!.map((x) => DashBoardDatum.fromJson(x))),
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

class DashBoardDatum {
  int? total;
  int? pending;
  int? approved;
  int? confirmed;

  DashBoardDatum({
    this.total,
    this.pending,
    this.approved,
    this.confirmed,
  });

  factory DashBoardDatum.fromJson(Map<String, dynamic> json) => DashBoardDatum(
        total: json["Total"],
        pending: json["Pending"],
        approved: json["Approved"],
        confirmed: json["Confirmed"],
      );

  Map<String, dynamic> toJson() => {
        "Total": total,
        "Pending": pending,
        "Approved": approved,
        "Confirmed": confirmed,
      };
}
