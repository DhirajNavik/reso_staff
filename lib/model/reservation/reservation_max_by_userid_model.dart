class MaxDiscountByUserIdModel {
  bool? status;
  List<MaxByUserIDDatum>? data;
  String? message;

  MaxDiscountByUserIdModel({
    this.status,
    this.data,
    this.message,
  });

  factory MaxDiscountByUserIdModel.fromJson(Map<String, dynamic> json) =>
      MaxDiscountByUserIdModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MaxByUserIDDatum>.from(json["data"]!.map((x) => MaxByUserIDDatum.fromJson(x))),
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

class MaxByUserIDDatum {
  String? amount;

  MaxByUserIDDatum({
    this.amount,
  });

  factory MaxByUserIDDatum.fromJson(Map<String, dynamic> json) => MaxByUserIDDatum(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}
