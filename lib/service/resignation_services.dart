import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/resignation_hr_model.dart';
import 'package:attendance/model/resignation_finance_model.dart';
import 'package:attendance/model/resignation_form_approval_model.dart';
import 'package:attendance/model/resignationlist_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/resignation/resignation.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, debugPrint;
import 'package:http/http.dart' as http;

class ResignationService {
  Future<void> sendResignation({
    required String lastWorkingDay,
    required String resignationReason,
    required BuildContext context,
  }) async {
    try {
      var userid = GetUserData().getUserId();
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}resignations'), body: {
        'userid': userid,
        'last_working_day': lastWorkingDay,
        'reason': resignationReason,
      });
      log('Add Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ResignationScreen()));
        CustomSnackBar.atBottom(
          title: "Successful",
          body: "Resignation send succesfully",
        );
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed to send resignation",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<ResignationList?> getResignationList() async {
    var userid = GetUserData().getUserId();
    log(userid);
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}resignationlist?userid=$userid'));
      log('Resignation  --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ResignationList.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ResignationFormModel?> getResignationFormList() async {
    var userid = GetUserData().getUserId();
    log(userid);
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}resignationrequests?userid=$userid'));
      log('Resignation Approvals --> \n ${Strings.baseUrl}resignationrequests?userid=$userid');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ResignationFormModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> resignationFormApproveOrReject(BuildContext context,
      {dynamic status, dynamic resignationid}) async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approveresignation'),
        body: {
          'resignationid': resignationid.toString(),
          'status': status.toString(),
          'userid': userid.toString(),
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'Resignation Approved'
                : status == '2'
                    ? 'Resignation Rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approved'
                : status == '2'
                    ? 'Failed to Reject'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ResignationFinanceModel?> getResignationFinanceList() async {
    var userid = GetUserData().getUserId();
    log(userid);
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}financeresignationrequests'));
      log('Resignation Finance Approval --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ResignationFinanceModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> resignationFinanceApproveOrReject(BuildContext context,
      {dynamic status, dynamic resignationid}) async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}financeapproveresignation'),
        body: {
          'status': status.toString(),
          'resignationid': resignationid.toString(),
          'userid': userid.toString(),
        },
      );

      log('resignationApproveOrReject response -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'Resignation Approved'
                : status == '2'
                    ? 'Resignation Rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approved'
                : status == '2'
                    ? 'Failed to Reject'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ResignationHrModel?> getResignationHRList() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}hrresignationrequests'));
      log('Reimburse HR Approval --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ResignationHrModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> resignationHRApproveOrReject(BuildContext context,
      {dynamic status, dynamic resignationid}) async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}hrapproveresignation'),
        body: {
          'status': status.toString(),
          'resignationid': resignationid.toString(),
          'userid': userid.toString(),
        },
      );

      log('reimbursementApproveOrReject response -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'Reimbursement Approved'
                : status == '2'
                    ? 'Reimbursement Rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approve'
                : status == '2'
                    ? 'Failed to Reject'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
