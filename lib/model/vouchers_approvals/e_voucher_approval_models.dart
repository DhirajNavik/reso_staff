class EVoucherApprovalModels {
  bool? status;
  List<EVoucherApprovalDatum>? data;
  String? message;

  EVoucherApprovalModels({
    this.status,
    this.data,
    this.message,
  });

  factory EVoucherApprovalModels.fromJson(Map<String, dynamic> json) =>
      EVoucherApprovalModels(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EVoucherApprovalDatum>.from(
                json["data"]!.map((x) => EVoucherApprovalDatum.fromJson(x))),
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

class EVoucherApprovalDatum {
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

  EVoucherApprovalDatum({
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

  factory EVoucherApprovalDatum.fromJson(Map<String, dynamic> json) =>
      EVoucherApprovalDatum(
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

// class EVoucherApprovalModels {
//   bool? status;
//   List<EVoucherApprovalDatum>? data;
//   String? message;

//   EVoucherApprovalModels({
//     this.status,
//     this.data,
//     this.message,
//   });

//   factory EVoucherApprovalModels.fromJson(Map<String, dynamic> json) =>
//       EVoucherApprovalModels(
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<EVoucherApprovalDatum>.from(
//                 json["data"]!.map((x) => EVoucherApprovalDatum.fromJson(x))),
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

// class EVoucherApprovalDatum {
//   String? paidamount;
//   String? discounts;
//   String? batchid;
//   String? requestedTo;
//   String? reservationid;
//   dynamic approvedby;
//   String? createdby;
//   String? amount;
//   String? id;
//   String? name;
//   String? reservationUkey;
//   String? reason;
//   String? totalfee;
//   String? admissiontypename;
//   String? branchname;
//   String? coursename;
//   String? status;
//   String? fvoucherDiscountid;

//   EVoucherApprovalDatum({
//     this.paidamount,
//     this.discounts,
//     this.batchid,
//     this.requestedTo,
//     this.reservationid,
//     this.approvedby,
//     this.createdby,
//     this.amount,
//     this.id,
//     this.name,
//     this.reservationUkey,
//     this.reason,
//     this.totalfee,
//     this.admissiontypename,
//     this.branchname,
//     this.coursename,
//     this.status,
//     this.fvoucherDiscountid,
//   });

//   factory EVoucherApprovalDatum.fromJson(Map<String, dynamic> json) =>
//       EVoucherApprovalDatum(
//         paidamount: json["paidamount"],
//         discounts: json["discounts"],
//         batchid: json["batchid"],
//         requestedTo: json["requested_to"],
//         reservationid: json["reservationid"],
//         approvedby: json["approvedby"],
//         createdby: json["createdby"],
//         amount: json["amount"],
//         id: json["id"],
//         name: json["name"],
//         reservationUkey: json["reservation_ukey"],
//         reason: json["reason"],
//         totalfee: json["totalfee"],
//         admissiontypename: json["admissiontypename"],
//         branchname: json["branchname"],
//         coursename: json["coursename"],
//         status: json["status"],
//         fvoucherDiscountid: json["fvoucher_discountid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "paidamount": paidamount,
//         "discounts": discounts,
//         "batchid": batchid,
//         "requested_to": requestedTo,
//         "reservationid": reservationid,
//         "approvedby": approvedby,
//         "createdby": createdby,
//         "amount": amount,
//         "id": id,
//         "name": name,
//         "reservation_ukey": reservationUkey,
//         "reason": reason,
//         "totalfee": totalfee,
//         "admissiontypename": admissiontypename,
//         "branchname": branchname,
//         "coursename": coursename,
//         "status": status,
//         "fvoucher_discountid": fvoucherDiscountid,
//       };
// }
