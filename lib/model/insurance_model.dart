class Insurance {
  final bool? status;
  final List<InsuranceDatum>? data;
  final String? message;

  Insurance({
    this.status,
    this.data,
    this.message,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<InsuranceDatum>.from(
                json["data"]!.map((x) => InsuranceDatum.fromJson(x))),
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

class InsuranceDatum {
  final String? id;
  final String? userid;
  final String? provider;
  final String? policyNo;
  final String? url;
  final String? date;

  InsuranceDatum({
    this.id,
    this.userid,
    this.provider,
    this.policyNo,
    this.url,
    this.date,
  });

  factory InsuranceDatum.fromJson(Map<String, dynamic> json) => InsuranceDatum(
        id: json["id"],
        userid: json["userid"],
        provider: json["provider"],
        policyNo: json["policy_no"],
        url: json["url"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "provider": provider,
        "policy_no": policyNo,
        "url": url,
        "date": date,
      };
}
