class ReservationStatusModel {
  bool? status;
  List<StatusDatum>? data;
  String? message;

  ReservationStatusModel({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationStatusModel.fromJson(Map<String, dynamic> json) =>
      ReservationStatusModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<StatusDatum>.from(json["data"]!.map((x) => StatusDatum.fromJson(x))),
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

class StatusDatum {
  String? reservationstatusid;
  String? reservationstatusname;

  StatusDatum({
    this.reservationstatusid,
    this.reservationstatusname,
  });

  factory StatusDatum.fromJson(Map<String, dynamic> json) => StatusDatum(
        reservationstatusid: json["reservationstatusid"],
        reservationstatusname: json["reservationstatusname"],
      );

  Map<String, dynamic> toJson() => {
        "reservationstatusid": reservationstatusid,
        "reservationstatusname": reservationstatusname,
      };
}
