class ReservationApprovalModel {
  bool? status;
  List<ReservationApprovalDatum>? data;
  String? message;

  ReservationApprovalModel({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationApprovalModel.fromJson(Map<String, dynamic> json) =>
      ReservationApprovalModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ReservationApprovalDatum>.from(json["data"]!.map((x) => ReservationApprovalDatum.fromJson(x))),
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

class ReservationApprovalDatum {
  String? paidamount;
  String? discounts;
  String? batchid;
  String? requestedTo;
  String? reservationid;
  dynamic approvedby;
  String? createdby;
  String? amount;
  String? id;
  String? amount1;
  String? name;
  String? reservationUkey;
  String? reason;
  String? totalfee;
  String? admissiontypename;
  String? branchname;
  String? coursename;
  String? discounttype;
  String? status;
  String? comments;
  String? reservationDiscountid;

  ReservationApprovalDatum({
    this.paidamount,
    this.discounts,
    this.batchid,
    this.requestedTo,
    this.reservationid,
    this.approvedby,
    this.createdby,
    this.amount,
    this.id,
    this.amount1,
    this.name,
    this.reservationUkey,
    this.reason,
    this.totalfee,
    this.admissiontypename,
    this.branchname,
    this.coursename,
    this.discounttype,
    this.status,
    this.comments,
    this.reservationDiscountid,
  });

  factory ReservationApprovalDatum.fromJson(Map<String, dynamic> json) => ReservationApprovalDatum(
        paidamount: json["paidamount"],
        discounts: json["discounts"],
        batchid: json["batchid"],
        requestedTo: json["requested_to"],
        reservationid: json["reservationid"],
        approvedby: json["approvedby"],
        createdby: json["createdby"],
        amount: json["amount"],
        id: json["id"],
        amount1: json["amount1"],
        name: json["name"],
        reservationUkey: json["reservation_ukey"],
        reason: json["reason"],
        totalfee: json["totalfee"],
        admissiontypename: json["admissiontypename"],
        branchname: json["branchname"],
        coursename: json["coursename"],
        discounttype: json["discounttype"],
        status: json["status"],
        comments: json["comments"],
        reservationDiscountid: json["reservation_discountid"],
      );

  Map<String, dynamic> toJson() => {
        "paidamount": paidamount,
        "discounts": discounts,
        "batchid": batchid,
        "requested_to": requestedTo,
        "reservationid": reservationid,
        "approvedby": approvedby,
        "createdby": createdby,
        "amount": amount,
        "id": id,
        "amount1": amount1,
        "name": name,
        "reservation_ukey": reservationUkey,
        "reason": reason,
        "totalfee": totalfee,
        "admissiontypename": admissiontypename,
        "branchname": branchname,
        "coursename": coursename,
        "discounttype": discounttype,
        "status": status,
        "comments": comments,
        "reservation_discountid": reservationDiscountid,
      };
}

// class ReservationApprovalModel {
//   bool? status;
//   List<ReservationApprovalDatum>? data;
//   String? message;

//   ReservationApprovalModel({
//     this.status,
//     this.data,
//     this.message,
//   });

//   factory ReservationApprovalModel.fromJson(Map<String, dynamic> json) =>
//       ReservationApprovalModel(
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<ReservationApprovalDatum>.from(
//                 json["data"]!.map((x) => ReservationApprovalDatum.fromJson(x))),
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

// class ReservationApprovalDatum {
//   String? id;
//   String? amount;
//   String? amount1;
//   String? discounttype;
//   String? comments;
//   String? status;
//   String? reservationUkey;
//   String? name;
//   String? studentid;
//   String? reservationdiscountid;
//   String? reason;
//   String? approvedby;
//   String? branchname;
//   String? coursename;
//   String? admissiontypename;
//   String? discounts;
//   String? totalfee;
//   String? paidamount;
//   String? reservationid;
//   String? createdby;
//   ReservationApprovalDatum({
//     this.id,
//     this.amount,
//     this.amount1,
//     this.discounttype,
//     this.comments,
//     this.status,
//     this.reservationUkey,
//     this.name,
//     this.studentid,
//     this.reservationdiscountid,
//     this.reason,
//     this.approvedby,
//     this.branchname,
//     this.coursename,
//     this.admissiontypename,
//     this.discounts,
//     this.totalfee,
//     this.paidamount,
//     this.reservationid,
//     this.createdby,
//   });

//   factory ReservationApprovalDatum.fromJson(Map<String, dynamic> json) =>
//       ReservationApprovalDatum(
//         id: json["id"],
//         amount: json["amount"],
//         amount1: json["amount1"],
//         discounttype: json["discounttype"],
//         comments: json["comments"],
//         status: json["status"],
//         reservationUkey: json["reservation_ukey"],
//         name: json["name"],
//         studentid: json["studentid"],
//         reservationdiscountid: json["reservation_discountid"],
//         reason: json["reason"],
//         approvedby: json["approvedby"],
//         branchname: json["branchname"],
//         coursename: json["coursename"],
//         admissiontypename: json["admissiontypename"],
//         discounts: json["discounts"],
//         totalfee: json["totalfee"],
//         paidamount: json["paidamount"],
//         reservationid: json["reservationid"],
//         createdby: json["createdby"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "amount": amount,
//         "amount1": amount1,
//         "discounttype": discounttype,
//         "comments": comments,
//         "status": status,
//         "reservation_ukey": reservationUkey,
//         "name": name,
//         "studentid": studentid,
//         "reservationdiscountid": reservationdiscountid,
//         "reason": reason,
//         "approvedby": approvedby,
//         "branchname": branchname,
//         "coursename": coursename,
//         "admissiontypename": admissiontypename,
//         "discounts": discounts,
//         "totalfee": totalfee,
//         "paidamount": paidamount,
//         "reservationid": reservationid,
//         "createdby": createdby,
//       };
// }
