class ReimburseList {
  bool? status;
  List<ReimburseListDatum>? data;
  String? message;

  ReimburseList({
    this.status,
    this.data,
    this.message,
  });

  factory ReimburseList.fromJson(Map<String, dynamic> json) => ReimburseList(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ReimburseListDatum>.from(
                json["data"]!.map((x) => ReimburseListDatum.fromJson(x))),
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

class ReimburseListDatum {
  String? id;
  String? userid;
  String? category;
  String? amount;
  String? reason;
  dynamic isReportingApproved;
  dynamic reportingApprovedBy;
  dynamic isHrApproved;
  dynamic hrApprovedBy;
  String? date;
  String? reportingname;
  String? hrname;

  ReimburseListDatum({
    this.id,
    this.userid,
    this.category,
    this.amount,
    this.reason,
    this.isReportingApproved,
    this.reportingApprovedBy,
    this.isHrApproved,
    this.hrApprovedBy,
    this.date,
    this.reportingname,
    this.hrname,
  });

  factory ReimburseListDatum.fromJson(Map<String, dynamic> json) =>
      ReimburseListDatum(
        id: json["id"],
        userid: json["userid"],
        category: json["category"],
        amount: json["amount"],
        reason: json["reason"],
        isReportingApproved: json["is_reporting_approved"],
        reportingApprovedBy: json["reporting_approved_by"],
        isHrApproved: json["is_hr_approved"],
        hrApprovedBy: json["hr_approved_by"],
        date: json["date"],
        reportingname: json["reportingname"],
        hrname: json["hrname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "category": category,
        "amount": amount,
        "reason": reason,
        "is_reporting_approved": isReportingApproved,
        "reporting_approved_by": reportingApprovedBy,
        "is_hr_approved": isHrApproved,
        "hr_approved_by": hrApprovedBy,
        "date": date,
        "reportingname": reportingname,
        "hrname": hrname,
      };
}
