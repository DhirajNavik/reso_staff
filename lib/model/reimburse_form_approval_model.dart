class ReimburseFormModel {
  bool? status;
  List<ReimburseFormDatum>? data;
  String? message;

  ReimburseFormModel({
    this.status,
    this.data,
    this.message,
  });

  factory ReimburseFormModel.fromJson(Map<String, dynamic> json) =>
      ReimburseFormModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ReimburseFormDatum>.from(
                json["data"]!.map((x) => ReimburseFormDatum.fromJson(x))),
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

class ReimburseFormDatum {
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
  String? name;
  String? employeeid;
  String? firebase;

  ReimburseFormDatum({
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
    this.name,
    this.employeeid,
    this.firebase,
  });

  factory ReimburseFormDatum.fromJson(Map<String, dynamic> json) =>
      ReimburseFormDatum(
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
        name: json["name"],
        employeeid: json["employeeid"],
        firebase: json["firebase"],
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
        "name": name,
        "employeeid": employeeid,
        "firebase": firebase,
      };
}
