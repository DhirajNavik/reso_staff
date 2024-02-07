import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/reimburse_form_approval_model.dart';
import 'package:attendance/model/reimburselist_model.dart';
import 'package:attendance/model/reimbursement_hr_model.dart';
import 'package:attendance/model/reimbursement_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/reimbursement/reimbursement.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, debugPrint;
import 'package:http/http.dart' as http;

class ReimbursementService {
  Future<void> sendReimbursement(
      {required String category,
      required String reason,
      required String amount,
      required BuildContext context}) async {
    try {
      var userid = GetUserData().getUserId();
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}reimbursement'), body: {
        'userid': userid,
        'reason': reason,
        'category': category,
        'amount': amount,
      });
      log('Add Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Navigator.pop(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReimbursementScreen()));
        CustomSnackBar.atBottom(
          title: "Successful",
          body: "Reimbursement send succesfully",
        );
        log('Post request successful');
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed to send reimbursement",
          status: false,
        );
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<ReimburseDropdown?> getDropdownList() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}reimbursementtype'));
      log('getDropdownList --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReimburseDropdown.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReimburseList?> getReimburseList() async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}reimbursementlist?userid=$userid'));
      log('Reimburse  --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReimburseList.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReimburseFormModel?> getReimburseFormList() async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}reimbursementrequests?userid=$userid'));
      log('Reimburse Approvals --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReimburseFormModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> reimbursementApproveOrReject(BuildContext context,
      {dynamic status, dynamic reimbursementid}) async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approvereimbursement?'),
        body: {
          'status': status.toString(),
          'reimbursementid': reimbursementid.toString(),
          'userid': userid.toString(),
        },
      );

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

  Future<ReimburseHrModel?> getReimburseHRList() async {
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}hrreimbursementrequests'));
      log('Reimburse HR Approvals --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReimburseHrModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> reimbursementHRApproveOrReject(BuildContext context,
      {dynamic status, dynamic reimbursementid}) async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}hrapprovereimbursement'),
        body: {
          'status': status.toString(),
          'reimbursementid': reimbursementid.toString(),
          'userid': userid.toString(),
        },
      );

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
