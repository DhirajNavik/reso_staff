class ReimburseDropdown {
  bool? status;
  List<String>? data;
  String? message;

  ReimburseDropdown({
    this.status,
    this.data,
    this.message,
  });

  factory ReimburseDropdown.fromJson(Map<String, dynamic> json) =>
      ReimburseDropdown(
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
