class AddApplicationsListModel {
  List<dynamic>? rights;
  List<Rightslookup>? rightslookup;
  List<Paymenttypelookup>? paymenttypelookup;
  List<Paymentstatuslookup>? paymentstatuslookup;
  List<Roleslookup>? roleslookup;
  List<Operationslookup>? operationslookup;
  List<Elookup>? feestructurelookup;
  List<Elookup>? cuttofffeelookup;
  List<Coursetypelookup>? coursetypelookup;
  List<FeestructurelookupOther>? feestructurelookupOther;
  List<Admissiontypelookup>? admissiontypelookup;
  List<Applicationstatuslookup>? applicationstatuslookup;
  List<Boardlookup>? boardlookup;
  List<Categorylookup>? categorylookup;
  List<Courselookup>? courselookup;
  List<Applicationtypelookup>? applicationtypelookup;
  List<Genderlookup>? genderlookup;
  List<Nationalitylookup>? nationalitylookup;
  List<Religionlookup>? religionlookup;
  List<Secondlanguagelookup>? secondlanguagelookup;
  List<Branchlookup>? branchlookup;
  List<Discountlookup>? discountlookup;
  List<Materialrequisition>? materialrequisition;
  List<Batchlookup>? batchlookup;
  List<Sectionlookup>? sectionlookup;
  List<dynamic>? subjectlookup;
  List<Stateslookup>? stateslookup;
  List<Districtslookup>? districtslookup;
  List<Wallettypelookup>? wallettypelookup;
  List<Reservationstatuslookup>? reservationstatuslookup;
  String? rightsJson;
  String? rightslookupJson;
  String? paymenttypelookupJson;
  String? paymentstatuslookupJson;
  String? roleslookupJson;
  String? operationslookupJson;
  String? feestructurelookupJson;
  String? cuttofffeelookupJson;
  String? coursetypelookupJson;
  String? feestructurelookupOtherJson;
  String? admissiontypelookupJson;
  String? applicationstatuslookupJson;
  String? boardlookupJson;
  String? categorylookupJson;
  String? courselookupJson;
  String? applicationtypelookupJson;
  String? genderlookupJson;
  String? nationalitylookupJson;
  String? religionlookupJson;
  String? secondlanguagelookupJson;
  String? branchlookupJson;
  String? discountlookupJson;
  String? batchlookupJson;
  String? sectionlookupJson;
  String? subjectlookupJson;
  String? stateslookupJson;
  String? districtslookupJson;
  String? wallettypelookupJson;
  String? reservationstatuslookupJson;

  AddApplicationsListModel({
    this.rights,
    this.rightslookup,
    this.paymenttypelookup,
    this.paymentstatuslookup,
    this.roleslookup,
    this.operationslookup,
    this.feestructurelookup,
    this.cuttofffeelookup,
    this.coursetypelookup,
    this.feestructurelookupOther,
    this.admissiontypelookup,
    this.applicationstatuslookup,
    this.boardlookup,
    this.categorylookup,
    this.courselookup,
    this.applicationtypelookup,
    this.genderlookup,
    this.nationalitylookup,
    this.religionlookup,
    this.secondlanguagelookup,
    this.branchlookup,
    this.discountlookup,
    this.materialrequisition,
    this.batchlookup,
    this.sectionlookup,
    this.subjectlookup,
    this.stateslookup,
    this.districtslookup,
    this.wallettypelookup,
    this.reservationstatuslookup,
    this.rightsJson,
    this.rightslookupJson,
    this.paymenttypelookupJson,
    this.paymentstatuslookupJson,
    this.roleslookupJson,
    this.operationslookupJson,
    this.feestructurelookupJson,
    this.cuttofffeelookupJson,
    this.coursetypelookupJson,
    this.feestructurelookupOtherJson,
    this.admissiontypelookupJson,
    this.applicationstatuslookupJson,
    this.boardlookupJson,
    this.categorylookupJson,
    this.courselookupJson,
    this.applicationtypelookupJson,
    this.genderlookupJson,
    this.nationalitylookupJson,
    this.religionlookupJson,
    this.secondlanguagelookupJson,
    this.branchlookupJson,
    this.discountlookupJson,
    this.batchlookupJson,
    this.sectionlookupJson,
    this.subjectlookupJson,
    this.stateslookupJson,
    this.districtslookupJson,
    this.wallettypelookupJson,
    this.reservationstatuslookupJson,
  });

  factory AddApplicationsListModel.fromJson(Map<String, dynamic> json) =>
      AddApplicationsListModel(
        rights: json["rights"] == null
            ? []
            : List<dynamic>.from(json["rights"]!.map((x) => x)),
        rightslookup: json["rightslookup"] == null
            ? []
            : List<Rightslookup>.from(
                json["rightslookup"]!.map((x) => Rightslookup.fromJson(x))),
        paymenttypelookup: json["paymenttypelookup"] == null
            ? []
            : List<Paymenttypelookup>.from(json["paymenttypelookup"]!
                .map((x) => Paymenttypelookup.fromJson(x))),
        paymentstatuslookup: json["paymentstatuslookup"] == null
            ? []
            : List<Paymentstatuslookup>.from(json["paymentstatuslookup"]!
                .map((x) => Paymentstatuslookup.fromJson(x))),
        roleslookup: json["roleslookup"] == null
            ? []
            : List<Roleslookup>.from(
                json["roleslookup"]!.map((x) => Roleslookup.fromJson(x))),
        operationslookup: json["operationslookup"] == null
            ? []
            : List<Operationslookup>.from(json["operationslookup"]!
                .map((x) => Operationslookup.fromJson(x))),
        feestructurelookup: json["feestructurelookup"] == null
            ? []
            : List<Elookup>.from(
                json["feestructurelookup"]!.map((x) => Elookup.fromJson(x))),
        cuttofffeelookup: json["cuttofffeelookup"] == null
            ? []
            : List<Elookup>.from(
                json["cuttofffeelookup"]!.map((x) => Elookup.fromJson(x))),
        coursetypelookup: json["coursetypelookup"] == null
            ? []
            : List<Coursetypelookup>.from(json["coursetypelookup"]!
                .map((x) => Coursetypelookup.fromJson(x))),
        feestructurelookupOther: json["feestructurelookup_Other"] == null
            ? []
            : List<FeestructurelookupOther>.from(
                json["feestructurelookup_Other"]!
                    .map((x) => FeestructurelookupOther.fromJson(x))),
        admissiontypelookup: json["admissiontypelookup"] == null
            ? []
            : List<Admissiontypelookup>.from(json["admissiontypelookup"]!
                .map((x) => Admissiontypelookup.fromJson(x))),
        applicationstatuslookup: json["applicationstatuslookup"] == null
            ? []
            : List<Applicationstatuslookup>.from(
                json["applicationstatuslookup"]!
                    .map((x) => Applicationstatuslookup.fromJson(x))),
        boardlookup: json["boardlookup"] == null
            ? []
            : List<Boardlookup>.from(
                json["boardlookup"]!.map((x) => Boardlookup.fromJson(x))),
        categorylookup: json["categorylookup"] == null
            ? []
            : List<Categorylookup>.from(
                json["categorylookup"]!.map((x) => Categorylookup.fromJson(x))),
        courselookup: json["courselookup"] == null
            ? []
            : List<Courselookup>.from(
                json["courselookup"]!.map((x) => Courselookup.fromJson(x))),
        applicationtypelookup: json["applicationtypelookup"] == null
            ? []
            : List<Applicationtypelookup>.from(json["applicationtypelookup"]!
                .map((x) => Applicationtypelookup.fromJson(x))),
        genderlookup: json["genderlookup"] == null
            ? []
            : List<Genderlookup>.from(
                json["genderlookup"]!.map((x) => Genderlookup.fromJson(x))),
        nationalitylookup: json["nationalitylookup"] == null
            ? []
            : List<Nationalitylookup>.from(json["nationalitylookup"]!
                .map((x) => Nationalitylookup.fromJson(x))),
        religionlookup: json["religionlookup"] == null
            ? []
            : List<Religionlookup>.from(
                json["religionlookup"]!.map((x) => Religionlookup.fromJson(x))),
        secondlanguagelookup: json["secondlanguagelookup"] == null
            ? []
            : List<Secondlanguagelookup>.from(json["secondlanguagelookup"]!
                .map((x) => Secondlanguagelookup.fromJson(x))),
        branchlookup: json["branchlookup"] == null
            ? []
            : List<Branchlookup>.from(
                json["branchlookup"]!.map((x) => Branchlookup.fromJson(x))),
        discountlookup: json["discountlookup"] == null
            ? []
            : List<Discountlookup>.from(
                json["discountlookup"]!.map((x) => Discountlookup.fromJson(x))),
        materialrequisition: json["materialrequisition"] == null
            ? []
            : List<Materialrequisition>.from(json["materialrequisition"]!
                .map((x) => Materialrequisition.fromJson(x))),
        batchlookup: json["batchlookup"] == null
            ? []
            : List<Batchlookup>.from(
                json["batchlookup"]!.map((x) => Batchlookup.fromJson(x))),
        sectionlookup: json["sectionlookup"] == null
            ? []
            : List<Sectionlookup>.from(
                json["sectionlookup"]!.map((x) => Sectionlookup.fromJson(x))),
        subjectlookup: json["subjectlookup"] == null
            ? []
            : List<dynamic>.from(json["subjectlookup"]!.map((x) => x)),
        stateslookup: json["stateslookup"] == null
            ? []
            : List<Stateslookup>.from(
                json["stateslookup"]!.map((x) => Stateslookup.fromJson(x))),
        districtslookup: json["districtslookup"] == null
            ? []
            : List<Districtslookup>.from(json["districtslookup"]!
                .map((x) => Districtslookup.fromJson(x))),
        wallettypelookup: json["wallettypelookup"] == null
            ? []
            : List<Wallettypelookup>.from(json["wallettypelookup"]!
                .map((x) => Wallettypelookup.fromJson(x))),
        reservationstatuslookup: json["reservationstatuslookup"] == null
            ? []
            : List<Reservationstatuslookup>.from(
                json["reservationstatuslookup"]!
                    .map((x) => Reservationstatuslookup.fromJson(x))),
        rightsJson: json["rights_json"],
        rightslookupJson: json["rightslookup_json"],
        paymenttypelookupJson: json["paymenttypelookup_json"],
        paymentstatuslookupJson: json["paymentstatuslookup_json"],
        roleslookupJson: json["roleslookup_json"],
        operationslookupJson: json["operationslookup_json"],
        feestructurelookupJson: json["feestructurelookup_json"],
        cuttofffeelookupJson: json["cuttofffeelookup_json"],
        coursetypelookupJson: json["coursetypelookup_json"],
        feestructurelookupOtherJson: json["feestructurelookup_Other_json"],
        admissiontypelookupJson: json["admissiontypelookup_json"],
        applicationstatuslookupJson: json["applicationstatuslookup_json"],
        boardlookupJson: json["boardlookup_json"],
        categorylookupJson: json["categorylookup_json"],
        courselookupJson: json["courselookup_json"],
        applicationtypelookupJson: json["applicationtypelookup_json"],
        genderlookupJson: json["genderlookup_json"],
        nationalitylookupJson: json["nationalitylookup_json"],
        religionlookupJson: json["religionlookup_json"],
        secondlanguagelookupJson: json["secondlanguagelookup_json"],
        branchlookupJson: json["branchlookup_json"],
        discountlookupJson: json["discountlookup_json"],
        batchlookupJson: json["batchlookup_json"],
        sectionlookupJson: json["sectionlookup_json"],
        subjectlookupJson: json["subjectlookup_json"],
        stateslookupJson: json["stateslookup_json"],
        districtslookupJson: json["districtslookup_json"],
        wallettypelookupJson: json["wallettypelookup_json"],
        reservationstatuslookupJson: json["reservationstatuslookup_json"],
      );

  Map<String, dynamic> toJson() => {
        "rights":
            rights == null ? [] : List<dynamic>.from(rights!.map((x) => x)),
        "rightslookup": rightslookup == null
            ? []
            : List<dynamic>.from(rightslookup!.map((x) => x.toJson())),
        "paymenttypelookup": paymenttypelookup == null
            ? []
            : List<dynamic>.from(paymenttypelookup!.map((x) => x.toJson())),
        "paymentstatuslookup": paymentstatuslookup == null
            ? []
            : List<dynamic>.from(paymentstatuslookup!.map((x) => x.toJson())),
        "roleslookup": roleslookup == null
            ? []
            : List<dynamic>.from(roleslookup!.map((x) => x.toJson())),
        "operationslookup": operationslookup == null
            ? []
            : List<dynamic>.from(operationslookup!.map((x) => x.toJson())),
        "feestructurelookup": feestructurelookup == null
            ? []
            : List<dynamic>.from(feestructurelookup!.map((x) => x.toJson())),
        "cuttofffeelookup": cuttofffeelookup == null
            ? []
            : List<dynamic>.from(cuttofffeelookup!.map((x) => x.toJson())),
        "coursetypelookup": coursetypelookup == null
            ? []
            : List<dynamic>.from(coursetypelookup!.map((x) => x.toJson())),
        "feestructurelookup_Other": feestructurelookupOther == null
            ? []
            : List<dynamic>.from(
                feestructurelookupOther!.map((x) => x.toJson())),
        "admissiontypelookup": admissiontypelookup == null
            ? []
            : List<dynamic>.from(admissiontypelookup!.map((x) => x.toJson())),
        "applicationstatuslookup": applicationstatuslookup == null
            ? []
            : List<dynamic>.from(
                applicationstatuslookup!.map((x) => x.toJson())),
        "boardlookup": boardlookup == null
            ? []
            : List<dynamic>.from(boardlookup!.map((x) => x.toJson())),
        "categorylookup": categorylookup == null
            ? []
            : List<dynamic>.from(categorylookup!.map((x) => x.toJson())),
        "courselookup": courselookup == null
            ? []
            : List<dynamic>.from(courselookup!.map((x) => x.toJson())),
        "applicationtypelookup": applicationtypelookup == null
            ? []
            : List<dynamic>.from(applicationtypelookup!.map((x) => x.toJson())),
        "genderlookup": genderlookup == null
            ? []
            : List<dynamic>.from(genderlookup!.map((x) => x.toJson())),
        "nationalitylookup": nationalitylookup == null
            ? []
            : List<dynamic>.from(nationalitylookup!.map((x) => x.toJson())),
        "religionlookup": religionlookup == null
            ? []
            : List<dynamic>.from(religionlookup!.map((x) => x.toJson())),
        "secondlanguagelookup": secondlanguagelookup == null
            ? []
            : List<dynamic>.from(secondlanguagelookup!.map((x) => x.toJson())),
        "branchlookup": branchlookup == null
            ? []
            : List<dynamic>.from(branchlookup!.map((x) => x.toJson())),
        "discountlookup": discountlookup == null
            ? []
            : List<dynamic>.from(discountlookup!.map((x) => x.toJson())),
        "materialrequisition": materialrequisition == null
            ? []
            : List<dynamic>.from(materialrequisition!.map((x) => x.toJson())),
        "batchlookup": batchlookup == null
            ? []
            : List<dynamic>.from(batchlookup!.map((x) => x.toJson())),
        "sectionlookup": sectionlookup == null
            ? []
            : List<dynamic>.from(sectionlookup!.map((x) => x.toJson())),
        "subjectlookup": subjectlookup == null
            ? []
            : List<dynamic>.from(subjectlookup!.map((x) => x)),
        "stateslookup": stateslookup == null
            ? []
            : List<dynamic>.from(stateslookup!.map((x) => x.toJson())),
        "districtslookup": districtslookup == null
            ? []
            : List<dynamic>.from(districtslookup!.map((x) => x.toJson())),
        "wallettypelookup": wallettypelookup == null
            ? []
            : List<dynamic>.from(wallettypelookup!.map((x) => x.toJson())),
        "reservationstatuslookup": reservationstatuslookup == null
            ? []
            : List<dynamic>.from(
                reservationstatuslookup!.map((x) => x.toJson())),
        "rights_json": rightsJson,
        "rightslookup_json": rightslookupJson,
        "paymenttypelookup_json": paymenttypelookupJson,
        "paymentstatuslookup_json": paymentstatuslookupJson,
        "roleslookup_json": roleslookupJson,
        "operationslookup_json": operationslookupJson,
        "feestructurelookup_json": feestructurelookupJson,
        "cuttofffeelookup_json": cuttofffeelookupJson,
        "coursetypelookup_json": coursetypelookupJson,
        "feestructurelookup_Other_json": feestructurelookupOtherJson,
        "admissiontypelookup_json": admissiontypelookupJson,
        "applicationstatuslookup_json": applicationstatuslookupJson,
        "boardlookup_json": boardlookupJson,
        "categorylookup_json": categorylookupJson,
        "courselookup_json": courselookupJson,
        "applicationtypelookup_json": applicationtypelookupJson,
        "genderlookup_json": genderlookupJson,
        "nationalitylookup_json": nationalitylookupJson,
        "religionlookup_json": religionlookupJson,
        "secondlanguagelookup_json": secondlanguagelookupJson,
        "branchlookup_json": branchlookupJson,
        "discountlookup_json": discountlookupJson,
        "batchlookup_json": batchlookupJson,
        "sectionlookup_json": sectionlookupJson,
        "subjectlookup_json": subjectlookupJson,
        "stateslookup_json": stateslookupJson,
        "districtslookup_json": districtslookupJson,
        "wallettypelookup_json": wallettypelookupJson,
        "reservationstatuslookup_json": reservationstatuslookupJson,
      };
}

class Admissiontypelookup {
  String? admissiontypeid;
  String? admissiontypename;
  String? intime;
  String? outtime;
  String? npfid;
  String? npfname;

  Admissiontypelookup({
    this.admissiontypeid,
    this.admissiontypename,
    this.intime,
    this.outtime,
    this.npfid,
    this.npfname,
  });

  factory Admissiontypelookup.fromJson(Map<String, dynamic> json) =>
      Admissiontypelookup(
        admissiontypeid: json["admissiontypeid"],
        admissiontypename: json["admissiontypename"],
        intime: json["intime"],
        outtime: json["outtime"],
        npfid: json["npfid"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "admissiontypeid": admissiontypeid,
        "admissiontypename": admissiontypename,
        "intime": intime,
        "outtime": outtime,
        "npfid": npfid,
        "npfname": npfname,
      };
}

class Applicationstatuslookup {
  String? applicationstatusid;
  String? applicationstatusname;

  Applicationstatuslookup({
    this.applicationstatusid,
    this.applicationstatusname,
  });

  factory Applicationstatuslookup.fromJson(Map<String, dynamic> json) =>
      Applicationstatuslookup(
        applicationstatusid: json["applicationstatusid"],
        applicationstatusname: json["applicationstatusname"],
      );

  Map<String, dynamic> toJson() => {
        "applicationstatusid": applicationstatusid,
        "applicationstatusname": applicationstatusname,
      };
}

class Applicationtypelookup {
  String? id;
  String? name;

  Applicationtypelookup({
    this.id,
    this.name,
  });

  factory Applicationtypelookup.fromJson(Map<String, dynamic> json) =>
      Applicationtypelookup(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Batchlookup {
  String? batchid;
  String? batchname;
  String? year;
  String? isactive;

  Batchlookup({
    this.batchid,
    this.batchname,
    this.year,
    this.isactive,
  });

  factory Batchlookup.fromJson(Map<String, dynamic> json) => Batchlookup(
        batchid: json["batchid"],
        batchname: json["batchname"],
        year: json["year"],
        isactive: json["isactive"],
      );

  Map<String, dynamic> toJson() => {
        "batchid": batchid,
        "batchname": batchname,
        "year": year,
        "isactive": isactive,
      };
}

class Boardlookup {
  String? boardid;
  String? boardname;

  Boardlookup({
    this.boardid,
    this.boardname,
  });

  factory Boardlookup.fromJson(Map<String, dynamic> json) => Boardlookup(
        boardid: json["boardid"],
        boardname: json["boardname"],
      );

  Map<String, dynamic> toJson() => {
        "boardid": boardid,
        "boardname": boardname,
      };
}

class Branchlookup {
  String? branchid;
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

  Branchlookup({
    this.branchid,
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
  });

  factory Branchlookup.fromJson(Map<String, dynamic> json) => Branchlookup(
        branchid: json["branchid"],
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
      );

  Map<String, dynamic> toJson() => {
        "branchid": branchid,
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
      };
}

class Categorylookup {
  String? categoryid;
  String? categoryname;
  String? npfid;
  String? npfname;

  Categorylookup({
    this.categoryid,
    this.categoryname,
    this.npfid,
    this.npfname,
  });

  factory Categorylookup.fromJson(Map<String, dynamic> json) => Categorylookup(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
        npfid: json["npfid"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
        "npfid": npfid,
        "npfname": npfname,
      };
}

class Courselookup {
  String? courseid;
  String? coursename;
  String? packagename;
  String? nextid;
  String? studentkitDayscholar;
  String? studentkitResdential;
  String? npfid;
  String? npfname;

  Courselookup({
    this.courseid,
    this.coursename,
    this.packagename,
    this.nextid,
    this.studentkitDayscholar,
    this.studentkitResdential,
    this.npfid,
    this.npfname,
  });

  factory Courselookup.fromJson(Map<String, dynamic> json) => Courselookup(
        courseid: json["courseid"],
        coursename: json["coursename"],
        packagename: json["packagename"],
        nextid: json["nextid"],
        studentkitDayscholar: json["studentkit_dayscholar"],
        studentkitResdential: json["studentkit_resdential"],
        npfid: json["npfid"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "courseid": courseid,
        "coursename": coursename,
        "packagename": packagename,
        "nextid": nextid,
        "studentkit_dayscholar": studentkitDayscholar,
        "studentkit_resdential": studentkitResdential,
        "npfid": npfid,
        "npfname": npfname,
      };
}

class Coursetypelookup {
  String? id;
  String? coursetype;

  Coursetypelookup({
    this.id,
    this.coursetype,
  });

  factory Coursetypelookup.fromJson(Map<String, dynamic> json) =>
      Coursetypelookup(
        id: json["id"],
        coursetype: json["coursetype"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coursetype": coursetype,
      };
}

class Elookup {
  String? id;
  String? branchid;
  String? courseid;
  String? admissiontypeid;
  String? batchid;
  String? fee;
  String? hostelFee;
  String? admissiontypename;
  String? intime;
  String? outtime;
  String? npfid;
  String? npfname;
  String? coursename;
  String? packagename;
  String? nextid;
  String? studentkitDayscholar;
  dynamic studentkitResdential;
  String? feesid;
  String? feetype;
  String? feesvalue;
  String? feecategoryid;

  Elookup({
    this.id,
    this.branchid,
    this.courseid,
    this.admissiontypeid,
    this.batchid,
    this.fee,
    this.hostelFee,
    this.admissiontypename,
    this.intime,
    this.outtime,
    this.npfid,
    this.npfname,
    this.coursename,
    this.packagename,
    this.nextid,
    this.studentkitDayscholar,
    this.studentkitResdential,
    this.feesid,
    this.feetype,
    this.feesvalue,
    this.feecategoryid,
  });

  factory Elookup.fromJson(Map<String, dynamic> json) => Elookup(
        id: json["id"],
        branchid: json["branchid"],
        courseid: json["courseid"],
        admissiontypeid: json["admissiontypeid"],
        batchid: json["batchid"],
        fee: json["fee"],
        hostelFee: json["hostel_fee"],
        admissiontypename: json["admissiontypename"],
        intime: json["intime"],
        outtime: json["outtime"],
        npfid: json["npfid"],
        npfname: json["npfname"],
        coursename: json["coursename"],
        packagename: json["packagename"],
        nextid: json["nextid"],
        studentkitDayscholar: json["studentkit_dayscholar"],
        studentkitResdential: json["studentkit_resdential"],
        feesid: json["feesid"],
        feetype: json["feetype"],
        feesvalue: json["feesvalue"],
        feecategoryid: json["feecategoryid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchid": branchid,
        "courseid": courseid,
        "admissiontypeid": admissiontypeid,
        "batchid": batchid,
        "fee": fee,
        "hostel_fee": hostelFee,
        "admissiontypename": admissiontypename,
        "intime": intime,
        "outtime": outtime,
        "npfid": npfid,
        "npfname": npfname,
        "coursename": coursename,
        "packagename": packagename,
        "nextid": nextid,
        "studentkit_dayscholar": studentkitDayscholar,
        "studentkit_resdential": studentkitResdential,
        "feesid": feesid,
        "feetype": feetype,
        "feesvalue": feesvalue,
        "feecategoryid": feecategoryid,
      };
}

class Discountlookup {
  String? id;
  String? discountname;

  Discountlookup({
    this.id,
    this.discountname,
  });

  factory Discountlookup.fromJson(Map<String, dynamic> json) => Discountlookup(
        id: json["id"],
        discountname: json["discountname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discountname": discountname,
      };
}

class Districtslookup {
  String? districtId;
  String? districtName;
  String? stateId;
  String? npfid;
  String? npfname;

  Districtslookup({
    this.districtId,
    this.districtName,
    this.stateId,
    this.npfid,
    this.npfname,
  });

  factory Districtslookup.fromJson(Map<String, dynamic> json) =>
      Districtslookup(
        districtId: json["district_id"],
        districtName: json["district_name"],
        stateId: json["state_id"],
        npfid: json["npfid"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
        "state_id": stateId,
        "npfid": npfid,
        "npfname": npfname,
      };
}

class FeestructurelookupOther {
  String? feesid;
  String? feetype;
  String? courseid;
  String? admissiontypeid;
  String? feesvalue;
  String? feecategoryid;
  String? batchid;

  FeestructurelookupOther({
    this.feesid,
    this.feetype,
    this.courseid,
    this.admissiontypeid,
    this.feesvalue,
    this.feecategoryid,
    this.batchid,
  });

  factory FeestructurelookupOther.fromJson(Map<String, dynamic> json) =>
      FeestructurelookupOther(
        feesid: json["feesid"],
        feetype: json["feetype"],
        courseid: json["courseid"],
        admissiontypeid: json["admissiontypeid"],
        feesvalue: json["feesvalue"],
        feecategoryid: json["feecategoryid"],
        batchid: json["batchid"],
      );

  Map<String, dynamic> toJson() => {
        "feesid": feesid,
        "feetype": feetype,
        "courseid": courseid,
        "admissiontypeid": admissiontypeid,
        "feesvalue": feesvalue,
        "feecategoryid": feecategoryid,
        "batchid": batchid,
      };
}

class Genderlookup {
  String? genderid;
  String? gendername;

  Genderlookup({
    this.genderid,
    this.gendername,
  });

  factory Genderlookup.fromJson(Map<String, dynamic> json) => Genderlookup(
        genderid: json["genderid"],
        gendername: json["gendername"],
      );

  Map<String, dynamic> toJson() => {
        "genderid": genderid,
        "gendername": gendername,
      };
}

class Materialrequisition {
  String? materialrequisitionid;
  String? materialrequisitionname;

  Materialrequisition({
    this.materialrequisitionid,
    this.materialrequisitionname,
  });

  factory Materialrequisition.fromJson(Map<String, dynamic> json) =>
      Materialrequisition(
        materialrequisitionid: json["materialrequisitionid"],
        materialrequisitionname: json["materialrequisitionname"],
      );

  Map<String, dynamic> toJson() => {
        "materialrequisitionid": materialrequisitionid,
        "materialrequisitionname": materialrequisitionname,
      };
}

class Nationalitylookup {
  String? nationalityid;
  String? nationalityname;

  Nationalitylookup({
    this.nationalityid,
    this.nationalityname,
  });

  factory Nationalitylookup.fromJson(Map<String, dynamic> json) =>
      Nationalitylookup(
        nationalityid: json["nationalityid"],
        nationalityname: json["nationalityname"],
      );

  Map<String, dynamic> toJson() => {
        "nationalityid": nationalityid,
        "nationalityname": nationalityname,
      };
}

class Operationslookup {
  String? operationid;
  String? operationname;
  String? parent;

  Operationslookup({
    this.operationid,
    this.operationname,
    this.parent,
  });

  factory Operationslookup.fromJson(Map<String, dynamic> json) =>
      Operationslookup(
        operationid: json["operationid"],
        operationname: json["operationname"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "operationid": operationid,
        "operationname": operationname,
        "parent": parent,
      };
}

class Paymentstatuslookup {
  String? paymentstatusid;
  String? paymentstatusname;

  Paymentstatuslookup({
    this.paymentstatusid,
    this.paymentstatusname,
  });

  factory Paymentstatuslookup.fromJson(Map<String, dynamic> json) =>
      Paymentstatuslookup(
        paymentstatusid: json["paymentstatusid"],
        paymentstatusname: json["paymentstatusname"],
      );

  Map<String, dynamic> toJson() => {
        "paymentstatusid": paymentstatusid,
        "paymentstatusname": paymentstatusname,
      };
}

class Paymenttypelookup {
  String? paymenttypeid;
  String? paymenttypename;

  Paymenttypelookup({
    this.paymenttypeid,
    this.paymenttypename,
  });

  factory Paymenttypelookup.fromJson(Map<String, dynamic> json) =>
      Paymenttypelookup(
        paymenttypeid: json["paymenttypeid"],
        paymenttypename: json["paymenttypename"],
      );

  Map<String, dynamic> toJson() => {
        "paymenttypeid": paymenttypeid,
        "paymenttypename": paymenttypename,
      };
}

class Religionlookup {
  String? religionid;
  String? religionname;
  String? npfname;

  Religionlookup({
    this.religionid,
    this.religionname,
    this.npfname,
  });

  factory Religionlookup.fromJson(Map<String, dynamic> json) => Religionlookup(
        religionid: json["religionid"],
        religionname: json["religionname"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "religionid": religionid,
        "religionname": religionname,
        "npfname": npfname,
      };
}

class Reservationstatuslookup {
  String? reservationstatusid;
  String? reservationstatusname;

  Reservationstatuslookup({
    this.reservationstatusid,
    this.reservationstatusname,
  });

  factory Reservationstatuslookup.fromJson(Map<String, dynamic> json) =>
      Reservationstatuslookup(
        reservationstatusid: json["reservationstatusid"],
        reservationstatusname: json["reservationstatusname"],
      );

  Map<String, dynamic> toJson() => {
        "reservationstatusid": reservationstatusid,
        "reservationstatusname": reservationstatusname,
      };
}

class Rightslookup {
  String? roleid;
  String? operationid;
  String? add;
  String? view;
  String? edit;
  String? delete;
  String? rolename;
  String? candelete;
  String? roleHierarchy;
  String? operationname;
  String? parent;

  Rightslookup({
    this.roleid,
    this.operationid,
    this.add,
    this.view,
    this.edit,
    this.delete,
    this.rolename,
    this.candelete,
    this.roleHierarchy,
    this.operationname,
    this.parent,
  });

  factory Rightslookup.fromJson(Map<String, dynamic> json) => Rightslookup(
        roleid: json["roleid"],
        operationid: json["operationid"],
        add: json["_add"],
        view: json["_view"],
        edit: json["_edit"],
        delete: json["_delete"],
        rolename: json["rolename"],
        candelete: json["candelete"],
        roleHierarchy: json["role_hierarchy"],
        operationname: json["operationname"],
        parent: json["parent"],
      );

  Map<String, dynamic> toJson() => {
        "roleid": roleid,
        "operationid": operationid,
        "_add": add,
        "_view": view,
        "_edit": edit,
        "_delete": delete,
        "rolename": rolename,
        "candelete": candelete,
        "role_hierarchy": roleHierarchy,
        "operationname": operationname,
        "parent": parent,
      };
}

class Roleslookup {
  String? roleid;
  String? rolename;
  String? candelete;
  String? roleHierarchy;

  Roleslookup({
    this.roleid,
    this.rolename,
    this.candelete,
    this.roleHierarchy,
  });

  factory Roleslookup.fromJson(Map<String, dynamic> json) => Roleslookup(
        roleid: json["roleid"],
        rolename: json["rolename"],
        candelete: json["candelete"],
        roleHierarchy: json["role_hierarchy"],
      );

  Map<String, dynamic> toJson() => {
        "roleid": roleid,
        "rolename": rolename,
        "candelete": candelete,
        "role_hierarchy": roleHierarchy,
      };
}

class Secondlanguagelookup {
  String? secondlanguageid;
  String? secondlanguagename;

  Secondlanguagelookup({
    this.secondlanguageid,
    this.secondlanguagename,
  });

  factory Secondlanguagelookup.fromJson(Map<String, dynamic> json) =>
      Secondlanguagelookup(
        secondlanguageid: json["secondlanguageid"],
        secondlanguagename: json["secondlanguagename"],
      );

  Map<String, dynamic> toJson() => {
        "secondlanguageid": secondlanguageid,
        "secondlanguagename": secondlanguagename,
      };
}

class Sectionlookup {
  String? sectionid;
  String? sectionname;

  Sectionlookup({
    this.sectionid,
    this.sectionname,
  });

  factory Sectionlookup.fromJson(Map<String, dynamic> json) => Sectionlookup(
        sectionid: json["sectionid"],
        sectionname: json["sectionname"],
      );

  Map<String, dynamic> toJson() => {
        "sectionid": sectionid,
        "sectionname": sectionname,
      };
}

class Stateslookup {
  String? stateId;
  String? stateName;
  String? countryId;
  String? npfid;
  String? npfname;

  Stateslookup({
    this.stateId,
    this.stateName,
    this.countryId,
    this.npfid,
    this.npfname,
  });

  factory Stateslookup.fromJson(Map<String, dynamic> json) => Stateslookup(
        stateId: json["state_id"],
        stateName: json["state_name"],
        countryId: json["country_id"],
        npfid: json["npfid"],
        npfname: json["npfname"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
        "country_id": countryId,
        "npfid": npfid,
        "npfname": npfname,
      };
}

class Wallettypelookup {
  String? wallettypeid;
  String? wallettypename;
  String? islocked;

  Wallettypelookup({
    this.wallettypeid,
    this.wallettypename,
    this.islocked,
  });

  factory Wallettypelookup.fromJson(Map<String, dynamic> json) =>
      Wallettypelookup(
        wallettypeid: json["wallettypeid"],
        wallettypename: json["wallettypename"],
        islocked: json["islocked"],
      );

  Map<String, dynamic> toJson() => {
        "wallettypeid": wallettypeid,
        "wallettypename": wallettypename,
        "islocked": islocked,
      };
}

class ApplicationBranchLookupModel {
  bool? status;
  List<BranchLookupDatum>? data;
  String? message;

  ApplicationBranchLookupModel({
    this.status,
    this.data,
    this.message,
  });

  factory ApplicationBranchLookupModel.fromJson(Map<String, dynamic> json) =>
      ApplicationBranchLookupModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<BranchLookupDatum>.from(
                json["data"]!.map((x) => BranchLookupDatum.fromJson(x))),
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

class BranchLookupDatum {
  String? branchid;
  String? branchname;

  BranchLookupDatum({
    this.branchid,
    this.branchname,
  });

  factory BranchLookupDatum.fromJson(Map<String, dynamic> json) =>
      BranchLookupDatum(
        branchid: json["branchid"],
        branchname: json["branchname"],
      );

  Map<String, dynamic> toJson() => {
        "branchid": branchid,
        "branchname": branchname,
      };
}

class YearModel {
  bool? status;
  List<YearDatum>? data;
  String? message;

  YearModel({
    this.status,
    this.data,
    this.message,
  });

  factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<YearDatum>.from(
                json["data"]!.map((x) => YearDatum.fromJson(x))),
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

class YearDatum {
  String? batchid;
  String? batchname;
  String? year;
  String? isactive;

  YearDatum({
    this.batchid,
    this.batchname,
    this.year,
    this.isactive,
  });

  factory YearDatum.fromJson(Map<String, dynamic> json) => YearDatum(
        batchid: json["batchid"],
        batchname: json["batchname"],
        year: json["year"],
        isactive: json["isactive"],
      );

  Map<String, dynamic> toJson() => {
        "batchid": batchid,
        "batchname": batchname,
        "year": year,
        "isactive": isactive,
      };
}
