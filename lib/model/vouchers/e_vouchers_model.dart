class EVoucherListModel {
  bool? status;
  List<EVoucherDatum>? data;
  String? message;

  EVoucherListModel({
    this.status,
    this.data,
    this.message,
  });

  factory EVoucherListModel.fromJson(Map<String, dynamic> json) =>
      EVoucherListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EVoucherDatum>.from(
                json["data"]!.map((x) => EVoucherDatum.fromJson(x))),
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

class EVoucherDatum {
  String? amount;
  String? amount1;
  String? reservationDiscountid;
  String? approvedby;
  dynamic approvedDate;
  String? discounttype;
  String? comments;
  String? reason;
  String? status;
  String? reservationUkey;
  String? name;
  String? type;
  String? studentname;
  String? applicationnumber;
  String? commentreason;

  EVoucherDatum(
      {this.amount,
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
      this.type,
      this.studentname,
      this.applicationnumber,
      this.commentreason});

  factory EVoucherDatum.fromJson(Map<String, dynamic> json) => EVoucherDatum(
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
      type: json["type"],
      applicationnumber: json["applicationnumber"],
      studentname: json["studentname"],
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
        "type": type,
        "studentname": studentname,
        "applicationnumber": applicationnumber,
        "commentreason": commentreason
      };
}
