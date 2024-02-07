class ReservationDropdown {
  bool? status;
  List<Datum>? data;
  String? message;

  ReservationDropdown({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationDropdown.fromJson(Map<String, dynamic> json) =>
      ReservationDropdown(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  String? reservationid;
  String? reservationUkey;
  String? admissiontypeid;
  String? name;
  String? courseid;
  String? branchid;
  String? batchid;

  Datum({
    this.reservationid,
    this.reservationUkey,
    this.admissiontypeid,
    this.name,
    this.courseid,
    this.branchid,
    this.batchid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reservationid: json["reservationid"],
        reservationUkey: json["reservation_ukey"],
        admissiontypeid: json["admissiontypeid"],
        name: json["name"],
        courseid: json["courseid"],
        branchid: json["branchid"],
        batchid: json["batchid"],
      );

  Map<String, dynamic> toJson() => {
        "reservationid": reservationid,
        "reservation_ukey": reservationUkey,
        "admissiontypeid": admissiontypeid,
        "name": name,
        "courseid": courseid,
        "branchid": branchid,
        "batchid": batchid,
      };
}

class ReservationStudentDropdown {
  bool? status;
  List<Datum>? data;
  String? message;

  ReservationStudentDropdown({
    this.status,
    this.data,
    this.message,
  });

  factory ReservationStudentDropdown.fromJson(Map<String, dynamic> json) =>
      ReservationStudentDropdown(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class StudentDatum {
  String? reservationid;
  String? reservationUkey;
  String? admissiontypeid;
  String? courseid;
  String? batchid;
  String? branchid;
  String? name;

  StudentDatum({
    this.reservationid,
    this.reservationUkey,
    this.admissiontypeid,
    this.courseid,
    this.batchid,
    this.branchid,
    this.name,
  });

  factory StudentDatum.fromJson(Map<String, dynamic> json) => StudentDatum(
        reservationid: json["reservationid"],
        reservationUkey: json["reservation_ukey"],
        admissiontypeid: json["admissiontypeid"],
        courseid: json["courseid"],
        batchid: json["batchid"],
        branchid: json["branchid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "reservationid": reservationid,
        "reservation_ukey": reservationUkey,
        "admissiontypeid": admissiontypeid,
        "courseid": courseid,
        "batchid": batchid,
        "branchid": branchid,
        "name": name,
      };
}
