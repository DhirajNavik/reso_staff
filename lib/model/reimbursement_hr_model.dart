class ReimburseHrModel {
  bool? status;
  List<ReimburseHrDatum>? data;
  String? message;

  ReimburseHrModel({
    this.status,
    this.data,
    this.message,
  });

  factory ReimburseHrModel.fromJson(Map<String, dynamic> json) =>
      ReimburseHrModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ReimburseHrDatum>.from(
                json["data"]!.map((x) => ReimburseHrDatum.fromJson(x))),
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

class ReimburseHrDatum {
  String? id;
  String? userid;
  String? category;
  String? amount;
  String? reason;
  String? status;
  String? isReportingApproved;
  String? reportingApprovedBy;
  dynamic isHrApproved;
  dynamic hrApprovedBy;
  String? date;
  String? name;
  String? employeeid;
  String? firebase;
  String? reportingname;
  String? hrname;

  ReimburseHrDatum({
    this.id,
    this.userid,
    this.category,
    this.amount,
    this.reason,
    this.status,
    this.isReportingApproved,
    this.reportingApprovedBy,
    this.isHrApproved,
    this.hrApprovedBy,
    this.date,
    this.name,
    this.employeeid,
    this.firebase,
    this.reportingname,
    this.hrname,
  });

  factory ReimburseHrDatum.fromJson(Map<String, dynamic> json) =>
      ReimburseHrDatum(
        id: json["id"],
        userid: json["userid"],
        category: json["category"],
        amount: json["amount"],
        reason: json["reason"],
        status: json["status"],
        isReportingApproved: json["is_reporting_approved"],
        reportingApprovedBy: json["reporting_approved_by"],
        isHrApproved: json["is_hr_approved"],
        hrApprovedBy: json["hr_approved_by"],
        date: json["date"],
        name: json["name"],
        employeeid: json["employeeid"],
        firebase: json["firebase"],
        reportingname: json["reportingname"],
        hrname: json["hrname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "category": category,
        "amount": amount,
        "reason": reason,
        "status": status,
        "is_reporting_approved": isReportingApproved,
        "reporting_approved_by": reportingApprovedBy,
        "is_hr_approved": isHrApproved,
        "hr_approved_by": hrApprovedBy,
        "date": date,
        "name": name,
        "employeeid": employeeid,
        "firebase": firebase,
        "reportingname": reportingname,
        "hrname": hrname,
      };
}
