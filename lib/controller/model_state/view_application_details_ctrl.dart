import 'dart:developer';
import 'dart:io';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/add_applications_ctrl.dart';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/model/RepoREsponse.dart';
import 'package:attendance/model/application_details_model.dart';
import 'package:attendance/model/application_lookup_model.dart';
import 'package:attendance/model/get_bank_details_model.dart';
import 'package:attendance/model/view_details_status_model.dart';
import 'package:attendance/service/add_applications_services.dart';
import 'package:attendance/service/view_application_details_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAppDetailsGetx extends GetxController {
  final AddAppGetx addAppController = Get.put(AddAppGetx());
  GlobalKey<FormState> addapplicationformKey = GlobalKey<FormState>();
  late TextEditingController commentboxController = TextEditingController();
  late TextEditingController dobController = TextEditingController();
  TextEditingController studentnameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController motherController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();

  TextEditingController alternateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController coursefeesController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

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
  String? _selectedApplicationStatus = '';

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
  String get selectedApplicationStatus =>
      _selectedApplicationStatus!; //App Stat

  // Setters for selected values
  set selectedButtonn(String value) {
    selectedButton = value;
    update();
  }

  set selectedApplicationType(String value) {
    _selectedApplicationType = value;
    update();
  }

  String reservationstatusid = '';
  set selectedApplicationStatus(String value) {
    _selectedApplicationStatus = value;
    for (var i in statusDataList) {
      if (i.reservationstatusname == value) {
        if (i.reservationstatusid != null) {
          reservationstatusid = i.reservationstatusid.toString();
          log('reservationstatusid --> ${i.reservationstatusid.toString()}');
        }
      }
    }
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

  // List<ViewDetailsData>
  ViewDetailsData? responseData;
  Future<void> setPreLookups() async {}

  Future<void> getViewApplicationDetails(
      {required String applicationid}) async {
    selectedApplicationStatus = '';
    responseData = null;
    paymentList.clear();
    clearFields();
    await getLookUpss();
    final response = await ViewApplicationDetailsServices()
        .getViewApplicationDetails(applicationid: applicationid);
    if (response != null && response.data != null) {
      responseData = response.data;
      // selectedApplicationType = responseData!.applicationtype!;
      selectedCourse = responseData!.coursename!.toString();
      selectedAdmissionType = responseData!.admissiontypename!;
      selectedBranch = responseData!.branchname ?? '';
      selectedGender = responseData!.gendername!;
      update();
      // selectedCourse = responseData!.coursetype.toString();

      // String get selectedAcademicYear => _selectedAcademicYear!;

      // String get selectedBoard => _selectedBoard!;
      // String get selectedState => _selectedState!;
      // String get selectedDistrict => _selectedDistrict!;

      // String get selectedBatch => _selectedBatch!;
      //----Text Controllers
      fatherController = TextEditingController(text: responseData!.fathername);
      motherController = TextEditingController(text: responseData!.mothername);
      studentnameController = TextEditingController(text: responseData!.name);
      dobController =
          TextEditingController(text: responseData!.dateofbirth.toString());
      schoolController = TextEditingController(text: responseData!.branchname);
      ;
      placeController =
          TextEditingController(text: responseData!.branchAddress);
      aadhaarController =
          TextEditingController(text: responseData!.studentaadhaar);
      // streetController = TextEditingController(text: responseData!.);
      // cityController = TextEditingController(text: responseData!.);
      // villageController = TextEditingController(text: responseData!.);
      // pinController =TextEditingController(text: responseData!.);
      // placeController=TextEditingController(text: responseData!.address.contains(other))
      mobileController = TextEditingController(text: responseData!.mobile1);
      alternateController = TextEditingController(text: responseData!.mobile2);
      emailController = TextEditingController(text: responseData!.email);
      aadhaarController = TextEditingController(text: "");
      coursefeesController =
          TextEditingController(text: responseData!.fee.toString());
      commentsController = TextEditingController(text: responseData!.comments);
    }
    getReservationStatus();
    update();
  }

  List<RepoDatum> paymentList = [];

  Future<void> getPaymentDetails(String userID, String batchID) async {
    final response = await ViewApplicationDetailsServices()
        .getPaymentDetails(userID: userID, batchID: batchID);
    if (response != null && response.data != null) {
      paymentList.clear();
      paymentList = response.data ?? [];

      log("----------$paymentList");
      update();
    }
    update();
  }

  List<String> statusNameList = [];
  List<StatusDatum> statusDataList = [];

  Future<void> getReservationStatus() async {
    final response =
        await ViewApplicationDetailsServices().getReservationStatus();
    if (response != null && response.data != null) {
      statusDataList = response.data ?? [];
      for (var i in statusDataList) {
        statusNameList.add(i.reservationstatusname!);

        log("----${i.reservationstatusname}");
      }
      update();
    }
    update();
  }

  String roleID = "";
  Future<void> getRollID() async {
    ProvGetnSet roleid = Get.put(ProvGetnSet());
    await roleid.getSavedResponse();
    dynamic data = roleid.savedResponse;
    roleID = data.toString();
    update();
    log("43y8yi83iy834y8432o8432o82--------> ${roleID.toString()}");
    update();
  }

  Future<void> confirmStatus({required String applicationid}) async {
    if (reservationstatusid != null && reservationstatusid.isNotEmpty) {
      await ViewApplicationDetailsServices().confirmStatus(
        reservationstatusid: reservationstatusid,
        comments: commentboxController.text,
        fee: responseData!.fee!,
        fee1: responseData!.fee1!,
        applicationid: responseData!.applicationid!,
      );

      await getViewApplicationDetails(applicationid: applicationid);
      await addAppController.viewCreatedApplications(appID: applicationid);

      reservationstatusid = '';
      commentboxController.clear();
      Get.back();
    }
    update();
  }

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
}
