class ViewApplicationModel {
  bool? status;
  List<ViewApplicationDatum>? data;
  String? message;

  ViewApplicationModel({
    this.status,
    this.data,
    this.message,
  });

  factory ViewApplicationModel.fromJson(Map<String, dynamic> json) =>
      ViewApplicationModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ViewApplicationDatum>.from(
                json["data"]!.map((x) => ViewApplicationDatum.fromJson(x))),
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

class ViewApplicationDatum {
  String? applicationid;
  String? applicationUkey;
  String? applicationtype;
  String? name;
  String? fathername;
  String? mothername;
  dynamic profileImage;
  String? parentoccupation;
  String? visitorname;
  String? relationwithstudent;
  String? visitornumber;
  String? studentaadhaar;
  DateTime? dateofbirth;
  String? nationalityid;
  String? religionid;
  String? categoryid;
  String? genderid;
  String? secondlanguageid;
  String? address;
  String? mobile1;
  String? mobile2;
  String? email;
  String? referredby;
  String? previousClassInformation;
  String? comments;
  dynamic feecomments;
  String? reservationstatusid;
  String? retstatus;
  DateTime? admissiondate;
  String? scholarship;
  String? tuitionDiscount;
  String? tuitionDiscount1;
  String? hostelDiscount;
  String? ipeDiscount;
  String? finalMisc;
  String? createdBy;
  dynamic updatedBy;
  String? approvedBy;
  DateTime? approvedDate;
  String? batchid;
  String? branchid;
  String? courseid;
  String? coursetype;
  String? sectionid;
  String? admissiontypeid;
  dynamic rezofastdetails;
  String? discountrequested;
  dynamic discountgiven;
  dynamic discountapprovedBy;
  String? additionaldiscountgiven;
  String? isMigrate;
  String? transferemployee;
  String? isProfileUploaded;
  String? isEnrolled;
  String? branchname;
  String? latitude;
  String? longitude;
  String? branchAddress;
  String? foundationtype;
  String? campustype;
  String? gendertype;
  String? gatepassid;
  String? branchcode;
  String? discountid;
  String? fvoucherid;
  String? reservationDiscountid;
  String? npfid;
  String? npfname;
  String? isActive;
  String? reservationstatusname;
  String? retid;
  String? retstatusname;
  String? admissiontypename;
  String? intime;
  String? outtime;
  String? coursename;
  String? packagename;
  String? nextid;
  String? studentkitDayscholar;
  String? studentkitResdential;
  String? gendername;

  ViewApplicationDatum({
    this.applicationid,
    this.applicationUkey,
    this.applicationtype,
    this.name,
    this.fathername,
    this.mothername,
    this.profileImage,
    this.parentoccupation,
    this.visitorname,
    this.relationwithstudent,
    this.visitornumber,
    this.studentaadhaar,
    this.dateofbirth,
    this.nationalityid,
    this.religionid,
    this.categoryid,
    this.genderid,
    this.secondlanguageid,
    this.address,
    this.mobile1,
    this.mobile2,
    this.email,
    this.referredby,
    this.previousClassInformation,
    this.comments,
    this.feecomments,
    this.reservationstatusid,
    this.retstatus,
    this.admissiondate,
    this.scholarship,
    this.tuitionDiscount,
    this.tuitionDiscount1,
    this.hostelDiscount,
    this.ipeDiscount,
    this.finalMisc,
    this.createdBy,
    this.updatedBy,
    this.approvedBy,
    this.approvedDate,
    this.batchid,
    this.branchid,
    this.courseid,
    this.coursetype,
    this.sectionid,
    this.admissiontypeid,
    this.rezofastdetails,
    this.discountrequested,
    this.discountgiven,
    this.discountapprovedBy,
    this.additionaldiscountgiven,
    this.isMigrate,
    this.transferemployee,
    this.isProfileUploaded,
    this.isEnrolled,
    this.branchname,
    this.latitude,
    this.longitude,
    this.branchAddress,
    this.foundationtype,
    this.campustype,
    this.gendertype,
    this.gatepassid,
    this.branchcode,
    this.discountid,
    this.fvoucherid,
    this.reservationDiscountid,
    this.npfid,
    this.npfname,
    this.isActive,
    this.reservationstatusname,
    this.retid,
    this.retstatusname,
    this.admissiontypename,
    this.intime,
    this.outtime,
    this.coursename,
    this.packagename,
    this.nextid,
    this.studentkitDayscholar,
    this.studentkitResdential,
    this.gendername,
  });

  factory ViewApplicationDatum.fromJson(Map<String, dynamic> json) =>
      ViewApplicationDatum(
        applicationid: json["applicationid"],
        applicationUkey: json["application_ukey"],
        applicationtype: json["applicationtype"],
        name: json["name"],
        fathername: json["fathername"],
        mothername: json["mothername"],
        profileImage: json["profile_image"],
        parentoccupation: json["parentoccupation"],
        visitorname: json["visitorname"],
        relationwithstudent: json["relationwithstudent"],
        visitornumber: json["visitornumber"],
        studentaadhaar: json["studentaadhaar"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        nationalityid: json["nationalityid"],
        religionid: json["religionid"],
        categoryid: json["categoryid"],
        genderid: json["genderid"],
        secondlanguageid: json["secondlanguageid"],
        address: json["address"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
        email: json["email"],
        referredby: json["referredby"],
        previousClassInformation: json["previous_class_information"],
        comments: json["comments"],
        feecomments: json["feecomments"],
        reservationstatusid: json["reservationstatusid"],
        retstatus: json["retstatus"],
        admissiondate: json["admissiondate"] == null
            ? null
            : DateTime.parse(json["admissiondate"]),
        scholarship: json["scholarship"],
        tuitionDiscount: json["tuition_discount"],
        tuitionDiscount1: json["tuition_discount1"],
        hostelDiscount: json["hostel_discount"],
        ipeDiscount: json["ipe_discount"],
        finalMisc: json["final_misc"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        approvedBy: json["approved_by"],
        approvedDate: json["approved_date"] == null
            ? null
            : DateTime.parse(json["approved_date"]),
        batchid: json["batchid"],
        branchid: json["branchid"],
        courseid: json["courseid"],
        coursetype: json["coursetype"],
        sectionid: json["sectionid"],
        admissiontypeid: json["admissiontypeid"],
        rezofastdetails: json["rezofastdetails"],
        discountrequested: json["discountrequested"],
        discountgiven: json["discountgiven"],
        discountapprovedBy: json["discountapproved_by"],
        additionaldiscountgiven: json["additionaldiscountgiven"],
        isMigrate: json["is_migrate"],
        transferemployee: json["transferemployee"],
        isProfileUploaded: json["is_profile_uploaded"],
        isEnrolled: json["is_enrolled"],
        branchname: json["branchname"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        branchAddress: json["branch_address"],
        foundationtype: json["foundationtype"],
        campustype: json["campustype"],
        gendertype: json["gendertype"],
        gatepassid: json["gatepassid"],
        branchcode: json["branchcode"],
        discountid: json["discountid"],
        fvoucherid: json["fvoucherid"],
        reservationDiscountid: json["reservation_discountid"],
        npfid: json["npfid"],
        npfname: json["npfname"],
        isActive: json["is_active"],
        reservationstatusname: json["reservationstatusname"],
        retid: json["retid"],
        retstatusname: json["retstatusname"],
        admissiontypename: json["admissiontypename"],
        intime: json["intime"],
        outtime: json["outtime"],
        coursename: json["coursename"],
        packagename: json["packagename"],
        nextid: json["nextid"],
        studentkitDayscholar: json["studentkit_dayscholar"],
        studentkitResdential: json["studentkit_resdential"],
        gendername: json["gendername"],
      );

  Map<String, dynamic> toJson() => {
        "applicationid": applicationid,
        "application_ukey": applicationUkey,
        "applicationtype": applicationtype,
        "name": name,
        "fathername": fathername,
        "mothername": mothername,
        "profile_image": profileImage,
        "parentoccupation": parentoccupation,
        "visitorname": visitorname,
        "relationwithstudent": relationwithstudent,
        "visitornumber": visitornumber,
        "studentaadhaar": studentaadhaar,
        "dateofbirth":
            "${dateofbirth!.year.toString().padLeft(4, '0')}-${dateofbirth!.month.toString().padLeft(2, '0')}-${dateofbirth!.day.toString().padLeft(2, '0')}",
        "nationalityid": nationalityid,
        "religionid": religionid,
        "categoryid": categoryid,
        "genderid": genderid,
        "secondlanguageid": secondlanguageid,
        "address": address,
        "mobile1": mobile1,
        "mobile2": mobile2,
        "email": email,
        "referredby": referredby,
        "previous_class_information": previousClassInformation,
        "comments": comments,
        "feecomments": feecomments,
        "reservationstatusid": reservationstatusid,
        "retstatus": retstatus,
        "admissiondate":
            "${admissiondate!.year.toString().padLeft(4, '0')}-${admissiondate!.month.toString().padLeft(2, '0')}-${admissiondate!.day.toString().padLeft(2, '0')}",
        "scholarship": scholarship,
        "tuition_discount": tuitionDiscount,
        "tuition_discount1": tuitionDiscount1,
        "hostel_discount": hostelDiscount,
        "ipe_discount": ipeDiscount,
        "final_misc": finalMisc,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "approved_by": approvedBy,
        "approved_date":
            "${approvedDate!.year.toString().padLeft(4, '0')}-${approvedDate!.month.toString().padLeft(2, '0')}-${approvedDate!.day.toString().padLeft(2, '0')}",
        "batchid": batchid,
        "branchid": branchid,
        "courseid": courseid,
        "coursetype": coursetype,
        "sectionid": sectionid,
        "admissiontypeid": admissiontypeid,
        "rezofastdetails": rezofastdetails,
        "discountrequested": discountrequested,
        "discountgiven": discountgiven,
        "discountapproved_by": discountapprovedBy,
        "additionaldiscountgiven": additionaldiscountgiven,
        "is_migrate": isMigrate,
        "transferemployee": transferemployee,
        "is_profile_uploaded": isProfileUploaded,
        "is_enrolled": isEnrolled,
        "branchname": branchname,
        "latitude": latitude,
        "longitude": longitude,
        "branch_address": branchAddress,
        "foundationtype": foundationtype,
        "campustype": campustype,
        "gendertype": gendertype,
        "gatepassid": gatepassid,
        "branchcode": branchcode,
        "discountid": discountid,
        "fvoucherid": fvoucherid,
        "reservation_discountid": reservationDiscountid,
        "npfid": npfid,
        "npfname": npfname,
        "is_active": isActive,
        "reservationstatusname": reservationstatusname,
        "retid": retid,
        "retstatusname": retstatusname,
        "admissiontypename": admissiontypename,
        "intime": intime,
        "outtime": outtime,
        "coursename": coursename,
        "packagename": packagename,
        "nextid": nextid,
        "studentkit_dayscholar": studentkitDayscholar,
        "studentkit_resdential": studentkitResdential,
        "gendername": gendername,
      };
}
