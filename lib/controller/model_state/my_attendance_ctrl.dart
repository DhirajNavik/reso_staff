import 'dart:convert';
import 'dart:developer';
import 'package:attendance/controller/model_state/leave_info_ctrl.dart';
import 'package:attendance/model/application_lookup_model.dart';
import 'package:attendance/model/biometric_model.dart';
import 'package:attendance/model/outside_work_model.dart';
import 'package:attendance/service/add_applications_services.dart';
import 'package:attendance/service/outsidework_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/services_api/api.dart';
import '../../model/my_attendance_model.dart';
import '../../view/widgets/custom_snackbar.dart';

class MyAttendanceModelController extends GetxController {
  String? _selectedYear = '';
  String get selectedYearr => _selectedYear!;
  String? batchid = '';
  String? savedYear;
  set selectedYearr(String value) {
    _selectedYear = value;
    for (var i in listBatch) {
      if (i.batchname == value) {
        if (i.batchid != null) {
          batchid = i.batchid.toString();
          update();

          setString('batchid', batchid!);
        }
      }
    }
    savedbatchid();
    update();
  }

  savedbatchid() async {
    await setString('batchid', batchid.toString());
    final saveddddy = await getString('batchid');
    log('saved batchid --> ${saveddddy.toString()}');
  }

  inity() async {
    savedYear = await getString('academic_year');
    log('inity --> ${savedYear.toString()}');
    update();
  }

  setYearCallback(String newValue) async {
    selectedYearr = newValue;
    await setString('academic_year', newValue.toString());
    savedYear = await getString('academic_year');
    log('savedYear --> ${savedYear.toString()}');
    log('callback --> ${savedYear.toString()}');
    update();
  }

  String? defaultyear = '';
  List<YearDatum> listBatch = [];
  List<String> batch = [];

  Future<void> getLookUpss() async {
    final response = await AddApplicationServices().getLookUpYear();
    if (response != null) {
      savedYear = await getString('academic_year') ?? '';
      log('saved yyeeaarr -----> $savedYear');
      log('saved yyeeaarr2 -----> $selectedYearr');
      //branchid
      // - - ACADEMIC YEAR
      if (response.data != null) {
        listBatch = response.data!;
        listBatch = response.data ?? [];
        batch = [...listBatch.map((g) => g.batchname!)];
        if (savedYear == null && selectedYearr.isEmpty ||
            savedYear!.isEmpty && selectedYearr.isEmpty) {
          log('here 1');
          for (var i in listBatch) {
            if (i.isactive == '1') {
              defaultyear = i.batchname;
              await setString('academic_year', defaultyear.toString());
              _selectedYear = defaultyear;
              update();
            }
          }
          for (var i in listBatch) {
            if (i.batchname == defaultyear) {
              if (i.batchid != null) {
                batchid = i.batchid.toString();
                update();
                await setString('batchid', batchid.toString());
                log('batchid --> ${i.batchid.toString()}');
                setString('batchid', batchid!);
              }
            }
          }
        } else if (savedYear != null && _selectedYear == null) {
          log('here 2');
          savedYear = await getString('academic_year') ?? '';
          _selectedYear = savedYear;
          for (var i in listBatch) {
            if (i.batchname == _selectedYear) {
              if (i.batchid != null) {
                batchid = i.batchid.toString();
                await setString('batchid', batchid.toString());
                log('batchid --> ${i.batchid.toString()}');
                setString('batchid', batchid!);
              }
            }
          }
          update();
        } else {
          _selectedYear = savedYear;
          log('here 3');
          for (var i in listBatch) {
            if (i.batchname == _selectedYear) {
              if (i.batchid != null) {
                batchid = i.batchid.toString();
                await setString('batchid', batchid.toString());
                log('batchid --> ${i.batchid.toString()}');
                setString('batchid', batchid!);
              }
            }
          }
          update();
        }

        update();
      }
    }
    final saveddddy = await getString('batchid');
    log('saved batchid --> ${saveddddy.toString()}');
    update();
  }

  Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic savedresponse = prefs.getString(key);
    return savedresponse;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // await getoutsideWorkList(GetUserData().getUserId());
  }

  TextEditingController notloginController = TextEditingController();
  String dropdownvalue = 'Select type'; // Initial value
  String type1 = '';
  String type2 = '';
  List<String> biometrics = [];
  List<OutsideWorkDatum> outsideWorkList = [];
  bool isloader = false;

  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> searchData = [];
  getSearchResult(String value) {
    searchData.clear();
    for (var i in outsideWorkList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase())) {
        OutsideWorkDatum data = OutsideWorkDatum(
          absenttype: i.absenttype,
          absentregularised: i.absentregularised,
          absentReason: i.absentReason,
          date: i.date,
          attendanceId: i.attendanceId,
          employeeId: i.employeeId,
          name: i.name,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

  Future<void> outsideWorkApproveOrReject(
      BuildContext context, dynamic status) async {
    await AbsentService().absentApproveOrReject(context, status);
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  Future<void> getoutsideWorkList(dynamic userid) async {
    isloader = true;
    OutsideWork? response = await AbsentService().absentList(userid);
    if (response != null) {
      if (response.data != null) {
        update();
        outsideWorkList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isloader = false;
    update();
  }

  Future<void> biometricList() async {
    Biometric? response = await AbsentService().biometricList();
    if (response != null) {
      if (response.data != null) {
        update();
        type1 = response.data!.type1.toString();
        type2 = response.data!.type2.toString();
        biometrics = ['Select type', type1, type2];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    showLoader = false;
    update();
  }

  Future<void> addAbsent(BuildContext context, dynamic attendenceid,
      dynamic biometric, dynamic reason) async {
    if (attendenceid != null && biometric != null && reason != null) {
      await AbsentService().absent(
          biometric: biometric, reason: reason, attendanceid: attendenceid);
      Navigator.pop(context);
    }
  }

  var stateMyAttendanceModel = <MyAttendanceModel>[].obs;

  updateMyAttendanceModel(MyAttendanceModel obj) {
    stateMyAttendanceModel.add(obj);
  }

  bool showLoader = true;

  Future<bool> getMyAttendance(String userid,
      {String branch = "", fromDate = "null", toDate = "null"}) async {
    LeaveInfoController? stateLeaveInfoCtrl = Get.put(LeaveInfoController());

    print("getMyAttendance $userid $branch");
    await stateLeaveInfoCtrl!.getLeaveInfoModel(userid, branch);

    var res = await MyAttendanceApi(
            userid: userid, fromDate: fromDate, toDate: toDate)
        .callApi();

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      // print(" ${decodedbody["status"]}");
      print(" RESPONSE ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        MyAttendanceModel userData = myAttendanceFromJson(body.toString());
        // log('needed data --> ${body.toString()}');
        await updateMyAttendanceModel(userData);
        await getLookUpss();
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "My attendance", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "My attendance",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }

  Future<bool> filterAttendance(BuildContext context, String userid,
      {String branch = "",
      required String fromDate,
      required String toDate}) async {
    var res = await FilterAttendanceApi(
            userid: userid, fromDate: fromDate, toDate: toDate)
        .callApi(context);

    if (res.statusCode == 201) {
      var body = res.body;
      final decodedbody = jsonDecode(body);
      print(" ${decodedbody["status"]}");
      print("filterAttendance ---$body");

      if (decodedbody["status"]) {
        //UserModel userData = UserModel(data: body["data"],status: body["status"],message: body["message"]).fromJson;
        MyAttendanceModel userData = myAttendanceFromJson(body.toString());
        await updateMyAttendanceModel(userData);
        return true;
      } else {
        CustomSnackBar.atBottom(
            title: "My attendance", body: "error", status: false);
        return false;
      }
    } else {
      CustomSnackBar.atBottom(
          title: "My attendance",
          body: res.statusCode.toString(),
          status: false);
      return false;
    }
  }

  //-------------------------------------------------------*Refresh Loader
  Future<void> loadresources(bool reload) async {
    Get.put(MyAttendanceModelController());

    await Get.find<MyAttendanceModelController>()
        .getMyAttendance(GetUserData().getCurrentUser().userid);
  }

  Future<void> outsideworkloadresources(bool reload) async {
    Get.put(MyAttendanceModelController());

    await Get.find<MyAttendanceModelController>()
        .getoutsideWorkList(GetUserData().getUserId());
  }
}
