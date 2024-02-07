class DiscountsDetailsModel {
  bool? status;
  List<DiscountsDetailsDatum>? data;
  String? message;

  DiscountsDetailsModel({
    this.status,
    this.data,
    this.message,
  });

  factory DiscountsDetailsModel.fromJson(Map<String, dynamic> json) =>
      DiscountsDetailsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DiscountsDetailsDatum>.from(
                json["data"]!.map((x) => DiscountsDetailsDatum.fromJson(x))),
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

class DiscountsDetailsDatum {
  String? amount;
  String? amount1;
  String? reservationDiscountid;
  String? approvedby;
  String? createdby;
  String? discounttype;
  String? comments;
  String? reason;
  String? status;
  String? reservationUkey;
  String? name;
  String? date;
  String? approveddate;
  String? vouchertype;

  DiscountsDetailsDatum({
    this.amount,
    this.amount1,
    this.reservationDiscountid,
    this.approvedby,
    this.createdby,
    this.discounttype,
    this.comments,
    this.reason,
    this.status,
    this.reservationUkey,
    this.name,
    this.date,
    this.approveddate,
    this.vouchertype,
  });

  factory DiscountsDetailsDatum.fromJson(Map<String, dynamic> json) =>
      DiscountsDetailsDatum(
          amount: json["amount"],
          amount1: json["amount1"],
          reservationDiscountid: json["reservation_discountid"],
          approvedby: json["approvedby"],
          createdby: json["createdby"],
          discounttype: json["discounttype"],
          comments: json["comments"],
          reason: json["reason"],
          status: json["status"],
          reservationUkey: json["reservation_ukey"],
          name: json["name"],
          date: json["date"],
          approveddate: json["approved_date"],
          vouchertype: json["vouchertype"]);

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "amount1": amount1,
        "reservation_discountid": reservationDiscountid,
        "approvedby": approvedby,
        "createdby": createdby,
        "discounttype": discounttype,
        "comments": comments,
        "reason": reason,
        "status": status,
        "reservation_ukey": reservationUkey,
        "name": name,
        "date": date,
        "approved_date": approveddate,
        "vouchertype": vouchertype
      };
}
