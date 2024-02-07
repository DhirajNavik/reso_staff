class ResignationFinanceModel {
  bool? status;
  List<ResignationFinanceDatum>? data;
  String? message;

  ResignationFinanceModel({
    this.status,
    this.data,
    this.message,
  });

  factory ResignationFinanceModel.fromJson(Map<String, dynamic> json) =>
      ResignationFinanceModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ResignationFinanceDatum>.from(
                json["data"]!.map((x) => ResignationFinanceDatum.fromJson(x))),
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

class ResignationFinanceDatum {
  String? id;
  String? employeeId;
  DateTime? lastWorkingDay;
  String? status;
  String? isReportingApproved;
  String? reportingApprovedBy;
  String? isFinanceApproved;
  String? financeApprovedBy;
  String? isHrApproved;
  String? hrApprovedBy;
  String? reason;
  String? date;
  String? name;
  String? employeeid;
  String? firebase;
  String? reportingname;
  String? financename;
  String? hrname;

  ResignationFinanceDatum({
    this.id,
    this.employeeId,
    this.lastWorkingDay,
    this.status,
    this.isReportingApproved,
    this.reportingApprovedBy,
    this.isFinanceApproved,
    this.financeApprovedBy,
    this.isHrApproved,
    this.hrApprovedBy,
    this.reason,
    this.date,
    this.name,
    this.employeeid,
    this.firebase,
    this.reportingname,
    this.financename,
    this.hrname,
  });

  factory ResignationFinanceDatum.fromJson(Map<String, dynamic> json) =>
      ResignationFinanceDatum(
        id: json["id"],
        employeeId: json["employee_id"],
        lastWorkingDay: json["last_working_day"] == null
            ? null
            : DateTime.parse(json["last_working_day"]),
        status: json["status"],
        isReportingApproved: json["is_reporting_approved"],
        reportingApprovedBy: json["reporting_approved_by"],
        isFinanceApproved: json["is_finance_approved"],
        financeApprovedBy: json["finance_approved_by"],
        isHrApproved: json["is_hr_approved"],
        hrApprovedBy: json["hr_approved_by"],
        reason: json["reason"],
        date: json["date"],
        name: json["name"],
        employeeid: json["employeeid"],
        firebase: json["firebase"],
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
        "is_finance_approved": isFinanceApproved,
        "finance_approved_by": financeApprovedBy,
        "is_hr_approved": isHrApproved,
        "hr_approved_by": hrApprovedBy,
        "reason": reason,
        "date": date,
        "name": name,
        "employeeid": employeeid,
        "firebase": firebase,
        "reportingname": reportingname,
        "financename": financename,
        "hrname": hrname,
      };
}
