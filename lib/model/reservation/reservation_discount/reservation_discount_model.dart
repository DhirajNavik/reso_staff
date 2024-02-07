class ReservationDiscountDropdown {
  bool? status;
  List<String>? data;
  String? message;

  ReservationDiscountDropdown({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationDiscountDropdown.fromJson(Map<String, dynamic> json) =>
      ReservationDiscountDropdown(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<String>.from(json["data"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
      };
}
