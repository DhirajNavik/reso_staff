class ResignationList {
  bool? status;
  List<ResignationListDatum>? data;
  String? message;

  ResignationList({
    this.status,
    this.data,
    this.message,
  });

  factory ResignationList.fromJson(Map<String, dynamic> json) =>
      ResignationList(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ResignationListDatum>.from(
                json["data"]!.map((x) => ResignationListDatum.fromJson(x))),
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

class ResignationListDatum {
  String? id;
  String? employeeId;
  DateTime? lastWorkingDay;
  String? status;
  dynamic isReportingApproved;
  dynamic reportingApprovedBy;
  dynamic financeApproved;
  dynamic financeApprovedBy;
  dynamic hrApproved;
  dynamic hrApprovedBy;
  String? reason;
  String? date;
  String? reportingname;
  String? financename;
  String? hrname;

  ResignationListDatum({
    this.id,
    this.employeeId,
    this.lastWorkingDay,
    this.status,
    this.isReportingApproved,
    this.reportingApprovedBy,
    this.financeApproved,
    this.financeApprovedBy,
    this.hrApproved,
    this.hrApprovedBy,
    this.reason,
    this.date,
    this.reportingname,
    this.financename,
    this.hrname,
  });

  factory ResignationListDatum.fromJson(Map<String, dynamic> json) =>
      ResignationListDatum(
        id: json["id"],
        employeeId: json["employee_id"],
        lastWorkingDay: json["last_working_day"] == null
            ? null
            : DateTime.parse(json["last_working_day"]),
        status: json["status"],
        isReportingApproved: json["is_reporting_approved"],
        reportingApprovedBy: json["reporting_approved_by"],
        financeApproved: json["finance_approved"],
        financeApprovedBy: json["finance_approved_by"],
        hrApproved: json["hr_approved"],
        hrApprovedBy: json["hr_approved_by"],
        reason: json["reason"],
        date: json["date"],
        reportingname: json["reportingname"],
        financename: json["financename"],
        hrname: json["hrname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "last_working_day":
            "${lastWorkingDay!.year.toString().padLeft(4, '0')}-${lastWorkingDay!.month.toString().padLeft(2, '0')}-${lastWorkingDay!.day.toString().padLeft(2, '0')}",
        "status": status,
        "is_reporting_approved": isReportingApproved,
        "reporting_approved_by": reportingApprovedBy,
        "finance_approved": financeApproved,
        "finance_approved_by": financeApprovedBy,
        "hr_approved": hrApproved,
        "hr_approved_by": hrApprovedBy,
        "reason": reason,
        "date": date,
        "reportingname": reportingname,
        "financename": financename,
        "hrname": hrname,
      };
}
