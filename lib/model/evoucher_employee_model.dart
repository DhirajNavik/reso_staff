class EmployeeFieldModel {
  bool? status;
  List<EmployeeNameDatum>? data;
  String? message;

  EmployeeFieldModel({
    this.status,
    this.data,
    this.message,
  });

  factory EmployeeFieldModel.fromJson(Map<String, dynamic> json) =>
      EmployeeFieldModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EmployeeNameDatum>.from(
                json["data"]!.map((x) => EmployeeNameDatum.fromJson(x))),
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

class EmployeeNameDatum {
  String? password;
  String? mobile;
  String? active;
  String? leavespermonth;
  String? employeeid;
  String? username;
  String? roleid;
  String? branchid;
  String? userid;
  String? name;
  String? rolename;
  dynamic discount;
  dynamic totallimit;
  dynamic availablelimit;

  EmployeeNameDatum({
    this.password,
    this.mobile,
    this.active,
    this.leavespermonth,
    this.employeeid,
    this.username,
    this.roleid,
    this.branchid,
    this.userid,
    this.name,
    this.rolename,
    this.discount,
    this.totallimit,
    this.availablelimit,
  });

  factory EmployeeNameDatum.fromJson(Map<String, dynamic> json) =>
      EmployeeNameDatum(
        password: json["password"],
        mobile: json["mobile"],
        active: json["active"],
        leavespermonth: json["leavespermonth"],
        employeeid: json["employeeid"],
        username: json["username"],
        roleid: json["roleid"],
        branchid: json["branchid"],
        userid: json["userid"],
        name: json["name"],
        rolename: json["rolename"],
        discount: json["discount"],
        totallimit: json["totallimit"],
        availablelimit: json["availablelimit"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "mobile": mobile,
        "active": active,
        "leavespermonth": leavespermonth,
        "employeeid": employeeid,
        "username": username,
        "roleid": roleid,
        "branchid": branchid,
        "userid": userid,
        "name": name,
        "rolename": rolename,
        "discount": discount,
        "totallimit": totallimit,
        "availablelimit": availablelimit,
      };
}
