import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/application_lookup_model.dart';
import 'package:attendance/model/view_application_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddApplicationServices {
  Future<AddApplicationsListModel?> getLookUps() async {
    try {
      final response = await http.get(Uri.parse(
          'https://maidendropgroup.com/public/api/helperMethods_new'));
      // log('Add Application getLookUps response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return AddApplicationsListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<YearModel?> getLookUpYear() async {
    try {
      final response = await http
          .get(Uri.parse('https://maidendropgroup.com/public/api/getbatch'));
      log('YearModel --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return YearModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ApplicationBranchLookupModel?> getLookUpBranch() async {
    try {
      final userid = GetUserData().getUserId();
      final response = await http.get(Uri.parse(
          'https://maidendropgroup.com/public/api/getbranch?userid=$userid'));
      log('getLookUpBranch response --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ApplicationBranchLookupModel.fromJson(
            json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ViewApplicationModel?> viewCreatedApplications({
    required String roleid,
    required String userid,
    required String branchid,
    required String applicationStatus,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic savedbatchid = prefs.getString('batchid');
    Map<String, dynamic> data = {
      'batchid': savedbatchid,
      'roleid': roleid,
      'userid': userid,
      'branchid': branchid,
    };
    log('reqbody --> ${data.toString()}');
    try {
      final response = await http.post(Uri.parse(
          'https://maidendropgroup.com/public/api/Applications?batchid=$savedbatchid&roleid=$roleid&userid=$userid&branchid=$branchid&applicationstatus=$applicationStatus'));
      log('https://maidendropgroup.com/public/api/Applications?batchid=$savedbatchid&roleid=$roleid&userid=$userid&branchid=$branchid&applicationstatus=$applicationStatus');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ViewApplicationModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<void> CreateApplications({
    required String studentname,
    required String dob,
    required String batchid,
    required String genderid,
    required String aadhar,
    required String fathername,
    required String mothername,
    required String school,
    required String boardid,
    required String place,
    required String street,
    required String village,
    required String city,
    required String state,
    required String district,
    required String pin,
    required String mobile1,
    required String admissiontypeid,
    required String courseid,
    required String referredby,
    required String userid,
    required String branchid,
    String? mobile2,
    String? email,
    String? comments,
    String? coursefee,
  }) async {
    Map<String, dynamic> data = {
      'name': studentname,
      'dateofbirth': dob,
      'batchid': batchid,
      'genderid': genderid,
      'studentaadhaar': aadhar,
      'fathername': fathername,
      'mothername': mothername,
      'school': school,
      'boardid': boardid,
      'place': place,
      'door_street': street,
      'village_mandal': village,
      'city_town': city,
      'state': state,
      'district': district,
      'pin': pin,
      'mobile1': mobile1,
      'mobile2': mobile2,
      'email': email,
      'admissiontypeid': admissiontypeid,
      'courseid': courseid,
      'comments': comments,
      'referredby': referredby,
      'userid': userid,
      'branchid': branchid,
      'tution_discount': coursefee,
    };
    log('reqbody --> ${data.toString()}');
    try {
      final response = await http.post(
        Uri.parse(
            'https://maidendropgroup.com/public/api/createapplicant?name=$studentname&dateofbirth=$dob&batchid=$batchid&genderid=$genderid&studentaadhaar=$aadhar&fathername=$fathername&mothername=$mothername&school=$school&boardid=$boardid&place=$place&door_street=$street&village_mandal=$village&city_town=$city&state=$state&district=$district&pin=$pin&mobile1=$mobile1&mobile2=$mobile2&email=$email&admissiontypeid=$admissiontypeid&courseid=$courseid&comments=$comments&referredby=$referredby&userid=$userid&branchid=$branchid'),
      );
      log('CreateApplications response --> ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        dynamic decodedbody = json.decode(response.body);
        if (decodedbody['status'] == true) {
          CustomSnackBar.atBottom(
            title: "Successful",
            body: "Application created Succesfully",
          );
        } else {
          CustomSnackBar.atBottom(
            title: "Failed",
            body: "Failed to create application",
            status: false,
          );
        }
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed to create application",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<void> postRetStatus({
    required int retstatus,
    required String applicationid,
  }) async {
    try {
      final Map<String, String> requestBody = {
        "retstatus": retstatus.toString(),
        "applicationid": applicationid,
      };
      print('Request Body --> ${jsonEncode(requestBody)}');

      final response = await http.post(Uri.parse(
          '${Strings.baseUrl}retstatuschanged?applicationid=$applicationid&retstatus=$retstatus'));

      log('confirmStatus -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        retstatus == 4
            ? CustomSnackBar.atBottom(
                title: "Success", body: "Marked as postpone")
            : CustomSnackBar.atBottom(
                title: "Success", body: "Marked as manually qualified");
      } else {
        CustomSnackBar.atBottom(
            title: "Failed", body: "Failed to updated status", status: false);
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }
}
