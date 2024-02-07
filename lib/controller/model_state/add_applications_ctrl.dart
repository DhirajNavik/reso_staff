import 'dart:developer';
import 'dart:io';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/my_attendance_ctrl.dart';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/model/application_lookup_model.dart';
import 'package:attendance/model/view_application_model.dart';
import 'package:attendance/service/add_applications_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAppGetx extends GetxController {
  GlobalKey<FormState> addapplicationformKey = GlobalKey<FormState>();

  late TextEditingController dobController = TextEditingController();
  final TextEditingController studentnameController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController motherController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();

  final TextEditingController alternateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController coursefeesController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  String selectedButton = 'Application Details';
  String? _selectedApplicationType = '';
  String? _selectedCourseType = '';
  String? _selectedAdmissionType = '';
  String? _selectedCourse = '';
  String? _selectedAcademicYear = '';
  String? _selectedBranch = '';
  String? _selectedBoard = '';
  String? _selectedState = '';
  String? _selectedDistrict = '';
  String? _selectedGender = '';
  String? _selectedBatch = '';

  // Getters for selected values
  String get selectedButtonn => selectedButton;
  String get selectedApplicationType => _selectedApplicationType!;
  String get selectedCourseType => _selectedCourseType!;
  String get selectedAdmissionType => _selectedAdmissionType!;
  String get selectedCourse => _selectedCourse!;
  String get selectedAcademicYear => _selectedAcademicYear!;
  String get selectedBranch => _selectedBranch!;
  String get selectedBoard => _selectedBoard!;
  String get selectedState => _selectedState!;
  String get selectedDistrict => _selectedDistrict!;
  String get selectedGender => _selectedGender!;
  String get selectedBatch => _selectedBatch!;

  // Setters for selected values
  set selectedButtonn(String value) {
    selectedButton = value;
    update();
  }

  set selectedApplicationType(String value) {
    _selectedApplicationType = value;
    update();
  }

  set selectedCourseType(String value) {
    _selectedCourseType = value;
    update();
  }

  String admissiontypeid = '';
  set selectedAdmissionType(String value) {
    _selectedAdmissionType = value;
    for (var i in listAdmissionType) {
      if (i.admissiontypename == value) {
        if (i.admissiontypeid != null) {
          admissiontypeid = i.admissiontypeid.toString();
          log('admissiontypeid --> ${i.admissiontypeid.toString()}');
        }
      }
    }
    update();
  }

  String courseid = '';
  set selectedCourse(String value) {
    _selectedCourse = value;
    for (var i in listCourse) {
      if (i.coursename == value) {
        if (i.courseid != null) {
          courseid = i.courseid.toString();
          log('courseid --> ${i.courseid.toString()}');
        }
      }
    }
    update();
  }

  String batchid = '';
  set selectedAcademicYear(String value) {
    _selectedAcademicYear = value;
    for (var i in listBatch) {
      if (i.batchname == value) {
        if (i.batchid != null) {
          batchid = i.batchid.toString();
          log('batchid --> ${i.batchid.toString()}');
        }
      }
    }
    update();
  }

  String branchid = '';
  set selectedBranch(String value) {
    _selectedBranch = value;
    for (var i in listBranch) {
      if (i.branchname == value) {
        if (i.branchid != null) {
          branchid = i.branchid.toString();
          log('branchid --> ${i.branchid.toString()}');
        }
      }
    }
    update();
  }

  String boardid = '';
  set selectedBoard(String value) {
    _selectedBoard = value;
    for (var i in listBoard) {
      if (i.boardname == value) {
        if (i.boardname != null) {
          boardid = i.boardid.toString();
          log('boardid --> ${i.boardid.toString()}');
        }
      }
    }
    update();
  }

  String stateid = '';
  set selectedState(String value) {
    _selectedState = value;
    for (var i in listState) {
      if (i.stateName == value) {
        if (i.stateName != null) {
          stateid = i.stateId.toString();
          log('stateid --> ${i.stateId.toString()}');
        }
      }
    }
    update();
  }

  String districtid = '';
  set selectedDistrict(String value) {
    _selectedDistrict = value;
    for (var i in listDistrict) {
      if (i.districtName == value) {
        if (i.districtName != null) {
          districtid = i.districtId.toString();
          log('districtId --> ${i.districtId.toString()}');
        }
      }
    }
    update();
  }

  String genderid = '';
  set selectedGender(String value) {
    _selectedGender = value;
    for (var i in listGender) {
      if (i.gendername == value) {
        if (i.genderid != null) {
          genderid = i.genderid.toString();
          log('genderid --> ${i.genderid.toString()}');
        }
      }
    }
    update();
  }

  set selectedBatch(String value) {
    _selectedBatch = value;
    update();
  }

  List<Applicationtypelookup> listApplicationType = [];
  List<String> applicationType = [];

  List<Coursetypelookup> listCourseType = [];
  List<String> courseType = [];

  List<Admissiontypelookup> listAdmissionType = [];
  List<String> admissionType = [];

  List<Courselookup> listCourse = [];
  List<String> course = [];

  List<BranchLookupDatum> listBranch = [];
  List<String> branch = [];

  List<Boardlookup> listBoard = [];
  List<String> board = [];

  List<Stateslookup> listState = [];
  List<String> state = [];

  List<Districtslookup> listDistrict = [];
  List<String> district = [];

  List<Genderlookup> listGender = [];
  List<String> gender = [];

  List<Batchlookup> listBatch = [];
  List<String> batch = [];

  Future<void> getLookUpBranch() async {
    final response = await AddApplicationServices().getLookUpBranch();
    // - - BRANCH
    if (response != null && response.data != null) {
      listBranch = response.data ?? [];
      branch = [...listBranch.map((g) => g.branchname!)];
      log('branch --> ${branch.toString()}');
      update();
    }
  }

  Future<void> getLookUpss() async {
    getLookUpBranch();
    final response = await AddApplicationServices().getLookUps();
    if (response != null) {
      // - - APPLICATION TYPE
      if (response.applicationtypelookup != null) {
        listApplicationType = response.applicationtypelookup!
            .map((g) => Applicationtypelookup.fromJson(g.toJson()))
            .toList();
        applicationType = [...listApplicationType.map((g) => g.name!)];
        update();
      }
      // - - COURSE TYPE
      if (response.coursetypelookup != null) {
        listCourseType = response.coursetypelookup!
            .map((g) => Coursetypelookup.fromJson(g.toJson()))
            .toList();
        courseType = [...listCourseType.map((g) => g.coursetype!)];
        update();
      }
      // - - ADMISSION TYPE
      if (response.admissiontypelookup != null) {
        listAdmissionType = response.admissiontypelookup!
            .map((g) => Admissiontypelookup.fromJson(g.toJson()))
            .toList();
        admissionType = [...listAdmissionType.map((g) => g.admissiontypename!)];
        update();
      }
      // - - COURSE
      if (response.courselookup != null) {
        listCourse = response.courselookup!
            .map((g) => Courselookup.fromJson(g.toJson()))
            .toList();
        course = [...listCourse.map((g) => g.coursename!)];
        update();
      }
      // - - ACADEMIC YEAR
      if (response.batchlookup != null) {
        int currentYear = DateTime.now().year;
        batch.clear();
        listBatch = response.batchlookup!
            .map((g) => Batchlookup.fromJson(g.toJson()))
            .toSet()
            .toList();

        for (var i in listBatch) {
          log('${i.year} >= $currentYear');
          if (int.parse(i.year!) >= currentYear) {
            batch.add(i.batchname!);
            if (i.isactive == '1') {
              batch.add(i.batchname!);
              update();
            }
          }
        }

        update();
      }

      // - - BOARD
      if (response.boardlookup != null) {
        listBoard = response.boardlookup!
            .map((g) => Boardlookup.fromJson(g.toJson()))
            .toList();
        board = [...listBoard.map((g) => g.boardname!)];
        update();
      }
      // - - STATE
      if (response.stateslookup != null) {
        listState = response.stateslookup!
            .map((g) => Stateslookup.fromJson(g.toJson()))
            .toList();
        state = [...listState.map((g) => g.stateName!)];
        update();
      }
      // - - DISTRICT
      if (response.districtslookup != null) {
        listDistrict = response.districtslookup!
            .map((g) => Districtslookup.fromJson(g.toJson()))
            .toList();
        district = [...listDistrict.map((g) => g.districtName!)];
        update();
      }
      // - - GENDER
      if (response.genderlookup != null) {
        listGender = response.genderlookup!
            .map((g) => Genderlookup.fromJson(g.toJson()))
            .toList();
        gender = [...listGender.map((g) => g.gendername!)];
        update();
      }
      update();
    } else {
      debugPrint('null');
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDob(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      selectableDayPredicate: (DateTime day) {
        return day.isBefore(DateTime.now().add(Duration(days: 1)));
      },
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Strings.primaryColor,
            cardColor: Strings.primaryColor,
            colorScheme: ColorScheme.light(primary: Strings.primaryColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            canvasColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      DateTime inputDateTime = DateTime.parse(selectedDate.toString());
      String formattedDate = DateFormat('dd/MM/yyyy').format(inputDateTime);

      dobController = TextEditingController(text: formattedDate);
      update();
    }
  }

  String savedRoleID = '';
  List<ViewApplicationDatum> viewApplicationList = [];
  Future<void> viewCreatedApplications({required String appID}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedRoleID = await prefs.getString('apiRoleid') ?? '';
    log('Saved Role ID --> ${savedRoleID.toString()}');
    update();
    searchViewCtrl.clear();
    viewApplicationList.clear();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // dynamic applicationStatus = prefs.getString('applicationStatus');
    ProvGetnSet roleid = Get.put(ProvGetnSet());
    await roleid.getSavedResponse();
    dynamic savedResponse = roleid.savedResponse;

    final response = await AddApplicationServices().viewCreatedApplications(
        branchid: GetUserData().getUserBranch(),
        roleid: savedResponse.toString(),
        userid: GetUserData().getUserId(),
        applicationStatus: appID);
    if (response != null && response.data != null) {
      viewApplicationList = response.data ?? [];
      update();
    }
  }

  Future<void> postRetStatus(
      {required int retstatus, required String applicationid}) async {
    await AddApplicationServices()
        .postRetStatus(applicationid: applicationid, retstatus: retstatus);
    await viewCreatedApplications(appID: "");
  }

  createApplication() async {
    await AddApplicationServices().CreateApplications(
      studentname: studentnameController.text,
      dob: dobController.text,
      batchid: batchid,
      genderid: genderid,
      aadhar: aadhaarController.text,
      fathername: fatherController.text,
      mothername: motherController.text,
      school: schoolController.text,
      boardid: boardid,
      place: placeController.text,
      street: streetController.text,
      village: villageController.text,
      city: cityController.text,
      state: stateid,
      district: districtid,
      pin: pinController.text,
      mobile1: mobileController.text,
      admissiontypeid: admissiontypeid,
      courseid: courseid,
      referredby: '1',
      userid: GetUserData().getUserId(),
      branchid: branchid,
      coursefee: coursefeesController.text,
      comments: commentsController.text,
      email: emailController.text,
      mobile2: alternateController.text,
    );
    await clearFields();
  }

  createApplicationCallback(BuildContext context) async {
    if (studentnameController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        batchid.isNotEmpty &&
        genderid.isNotEmpty &&
        aadhaarController.text.isNotEmpty &&
        fatherController.text.isNotEmpty &&
        motherController.text.isNotEmpty &&
        schoolController.text.isNotEmpty &&
        boardid.isNotEmpty &&
        placeController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        villageController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        selectedState.isNotEmpty &&
        selectedDistrict.isNotEmpty &&
        pinController.text.isNotEmpty &&
        mobileController.text.isNotEmpty &&
        admissiontypeid.isNotEmpty &&
        courseid.isNotEmpty &&
        branchid.isNotEmpty) {
      await createApplication();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all the required fields'),
        backgroundColor: Colors.red,
      ));
    }
  }

  String? textFormValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  Future<void> clearFields() async {
    stateid = '';
    districtid = '';
    admissiontypeid = '';
    batchid = '';
    genderid = '';
    boardid = '';
    branchid = '';
    courseid = '';
    studentnameController.clear();
    dobController.clear();
    fatherController.clear();
    motherController.clear();
    schoolController.clear();
    placeController.clear();
    streetController.clear();
    cityController.clear();
    villageController.clear();
    pinController.clear();
    landmarkController.clear();
    mobileController.clear();
    alternateController.clear();
    emailController.clear();
    aadhaarController.clear();
    coursefeesController.clear();
    commentsController.clear();
    _selectedApplicationType = '';
    _selectedCourseType = '';
    _selectedAdmissionType = '';
    _selectedCourse = '';
    _selectedAcademicYear = '';
    _selectedBranch = '';
    _selectedBoard = '';
    _selectedState = '';
    _selectedDistrict = '';
    _selectedGender = '';
    _selectedBatch = '';
    update();
  }

  File? image;

  Future pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    update();
  }

  TextEditingController searchViewCtrl = TextEditingController();
  List<dynamic> searchViewData = [];
  getSearchResult(String value) {
    searchViewData.clear();
    for (var i in viewApplicationList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationUkey
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        ViewApplicationDatum data = ViewApplicationDatum(
          applicationid: i.applicationid,
          applicationUkey: i.applicationUkey,
          applicationtype: i.applicationtype,
          name: i.name,
          fathername: i.fathername,
          mothername: i.mothername,
          profileImage: i.profileImage,
          parentoccupation: i.parentoccupation,
          visitorname: i.visitorname,
          relationwithstudent: i.relationwithstudent,
          visitornumber: i.visitornumber,
          studentaadhaar: i.studentaadhaar,
          dateofbirth: i.dateofbirth,
          nationalityid: i.nationalityid,
          religionid: i.religionid,
          categoryid: i.categoryid,
          genderid: i.genderid,
          secondlanguageid: i.secondlanguageid,
          address: i.address,
          mobile1: i.mobile1,
          mobile2: i.mobile2,
          email: i.email,
          referredby: i.referredby,
          previousClassInformation: i.previousClassInformation,
          comments: i.comments,
          feecomments: i.feecomments,
          reservationstatusid: i.reservationstatusid,
          retstatus: i.retstatus,
          admissiondate: i.admissiondate,
          scholarship: i.scholarship,
          tuitionDiscount: i.tuitionDiscount,
          tuitionDiscount1: i.tuitionDiscount1,
          hostelDiscount: i.hostelDiscount,
          ipeDiscount: i.ipeDiscount,
          finalMisc: i.finalMisc,
          createdBy: i.createdBy,
          updatedBy: i.updatedBy,
          approvedBy: i.approvedBy,
          approvedDate: i.approvedDate,
          batchid: i.batchid,
          branchid: i.branchid,
          courseid: i.courseid,
          coursetype: i.coursetype,
          sectionid: i.sectionid,
          admissiontypeid: i.admissiontypeid,
          rezofastdetails: i.rezofastdetails,
          discountrequested: i.discountrequested,
          discountgiven: i.discountgiven,
          discountapprovedBy: i.discountapprovedBy,
          additionaldiscountgiven: i.additionaldiscountgiven,
          isMigrate: i.isMigrate,
          transferemployee: i.transferemployee,
          isProfileUploaded: i.isProfileUploaded,
          isEnrolled: i.isEnrolled,
          branchname: i.branchname,
          latitude: i.latitude,
          longitude: i.longitude,
          branchAddress: i.branchAddress,
          foundationtype: i.foundationtype,
          campustype: i.campustype,
          gendertype: i.gendertype,
          gatepassid: i.gatepassid,
          branchcode: i.branchcode,
          discountid: i.discountid,
          fvoucherid: i.fvoucherid,
          reservationDiscountid: i.reservationDiscountid,
          npfid: i.npfid,
          npfname: i.npfname,
          isActive: i.isActive,
          reservationstatusname: i.reservationstatusname,
          retid: i.retid,
          retstatusname: i.retstatusname,
          admissiontypename: i.admissiontypename,
          intime: i.intime,
          outtime: i.outtime,
          coursename: i.coursename,
          packagename: i.packagename,
          nextid: i.nextid,
          studentkitDayscholar: i.studentkitDayscholar,
          studentkitResdential: i.studentkitResdential,
          gendername: i.gendername,
        );

        update();
        searchViewData.add(data);
        update();
      }
    }
  }
}
