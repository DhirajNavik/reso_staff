class MaxAmtModel {
  bool? status;
  List<MaxAmtDatum>? data;
  String? message;

  MaxAmtModel({
    this.status,
    this.data,
    this.message,
  });

  factory MaxAmtModel.fromJson(Map<String, dynamic> json) => MaxAmtModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MaxAmtDatum>.from(
                json["data"]!.map((x) => MaxAmtDatum.fromJson(x))),
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

class MaxAmtDatum {
  String? id;
  String? discount;
  String? resdiscount;
  String? employeeid;
  String? batchid;
  String? totallimit;
  String? availablelimit;

  MaxAmtDatum({
    this.id,
    this.discount,
    this.resdiscount,
    this.employeeid,
    this.batchid,
    this.totallimit,
    this.availablelimit,
  });

  factory MaxAmtDatum.fromJson(Map<String, dynamic> json) => MaxAmtDatum(
        id: json["id"],
        discount: json["discount"],
        resdiscount: json["resdiscount"],
        employeeid: json["employeeid"],
        batchid: json["batchid"],
        totallimit: json["totallimit"],
        availablelimit: json["availablelimit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discount": discount,
        "resdiscount": resdiscount,
        "employeeid": employeeid,
        "batchid": batchid,
        "totallimit": totallimit,
        "availablelimit": availablelimit,
      };
}

class NewMaxAmtModel {
  bool? status;
  List<NewMaxDatum>? data;
  String? message;

  NewMaxAmtModel({
    this.status,
    this.data,
    this.message,
  });

  factory NewMaxAmtModel.fromJson(Map<String, dynamic> json) => NewMaxAmtModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<NewMaxDatum>.from(
                json["data"]!.map((x) => NewMaxDatum.fromJson(x))),
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

class NewMaxDatum {
  String? amount;
  int? count;

  NewMaxDatum({
    this.amount,
    this.count,
  });

  factory NewMaxDatum.fromJson(Map<String, dynamic> json) => NewMaxDatum(
        amount: json["amount"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "count": count,
      };
}
