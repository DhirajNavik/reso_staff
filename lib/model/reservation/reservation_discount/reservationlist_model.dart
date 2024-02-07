// To parse this JSON data, do
//
//     final reservationListModel = reservationListModelFromJson(jsonString);

import 'dart:convert';

ReservationListModel reservationListModelFromJson(String str) =>
    ReservationListModel.fromJson(json.decode(str));

String reservationListModelToJson(ReservationListModel data) =>
    json.encode(data.toJson());

class ReservationListModel {
  bool? status;
  List<ReservationListDatum>? data;
  String? message;

  ReservationListModel({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationListModel.fromJson(Map<String, dynamic> json) =>
      ReservationListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ReservationListDatum>.from(
                json["data"]!.map((x) => ReservationListDatum.fromJson(x))),
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

class ReservationListDatum {
  String? amount;
  dynamic amount1;
  String? reservationDiscountid;
  String? approvedby;
  dynamic approvedDate;
  String? discounttype;
  String? comments;
  String? reason;
  String? status;
  dynamic reservationUkey;
  dynamic name;
  String? studentname;
  String? applicationnumber;
  String? type;
  String? commentreason;

  ReservationListDatum({
    this.amount,
    this.amount1,
    this.reservationDiscountid,
    this.approvedby,
    this.approvedDate,
    this.discounttype,
    this.comments,
    this.reason,
    this.status,
    this.reservationUkey,
    this.name,
    this.studentname,
    this.applicationnumber,
    this.type,
    this.commentreason,
  });

  factory ReservationListDatum.fromJson(Map<String, dynamic> json) =>
      ReservationListDatum(
          amount: json["amount"],
          amount1: json["amount1"],
          reservationDiscountid: json["reservation_discountid"],
          approvedby: json["approvedby"],
          approvedDate: json["approved_date"],
          discounttype: json["discounttype"],
          comments: json["comments"],
          reason: json["reason"],
          status: json["status"],
          reservationUkey: json["reservation_ukey"],
          name: json["name"],
          studentname: json["studentname"],
          applicationnumber: json["applicationnumber"],
          type: json["type"],
          commentreason: json["commentreason"]);

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount1": amount1,
        "reservation_discountid": reservationDiscountid,
        "approvedby": approvedby,
        "approved_date": approvedDate,
        "discounttype": discounttype,
        "comments": comments,
        "reason": reason,
        "status": status,
        "reservation_ukey": reservationUkey,
        "name": name,
        "studentname": studentname,
        "applicationnumber": applicationnumber,
        "type": type,
        "commentreason": commentreason
      };
}


// class ReservationListModel {
//   bool? status;
//   List<ReservationListDatum>? data;
//   String? message;

//   ReservationListModel({
//     this.status,
//     this.data,
//     this.message,
//   });

//   factory ReservationListModel.fromJson(Map<String, dynamic> json) =>
//       ReservationListModel(
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<ReservationListDatum>.from(
//                 json["data"]!.map((x) => ReservationListDatum.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class ReservationListDatum {
//   String? amount;
//   String? amount1;
//   String? discounttype;
//   String? comments;
//   String? status;
//   String? reservationUkey;
//   String? name;
//   String? reservationdiscountid;
//   String? reason;
//   String? approvedby;
//   String? approveddate;

//   ReservationListDatum({
//     this.amount,
//     this.amount1,
//     this.discounttype,
//     this.comments,
//     this.status,
//     this.reservationUkey,
//     this.name,
//     this.reservationdiscountid,
//     this.reason,
//     this.approvedby,
//     this.approveddate,
//   });

//   factory ReservationListDatum.fromJson(Map<String, dynamic> json) =>
//       ReservationListDatum(
//         amount: json["amount"],
//         amount1: json["amount1"],
//         discounttype: json["discounttype"],
//         comments: json["comments"],
//         status: json["status"],
//         reservationUkey: json["reservation_ukey"],
//         name: json["name"],
//         reservationdiscountid: json["reservation_discountid"],
//         reason: json["reason"],
//         approvedby: json["approvedby"],
//         approveddate: json["approved_date"],
//       );

//   Map<String, dynamic> toJson() => {
//         "amount": amount,
//         "amount1": amount1,
//         "discounttype": discounttype,
//         "comments": comments,
//         "status": status,
//         "reservation_ukey": reservationUkey,
//         "name": name,
//         "reservationdiscountid": reservationdiscountid,
//         "reason": reason,
//         "approvedby": approvedby,
//         "approved_date": approveddate
//       };
// }
