import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/evoucher_employee_model.dart';
import 'package:attendance/model/vouchers/e_vouchers_model.dart';
import 'package:attendance/model/vouchers_approvals/e_voucher_approval_models.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/e_vouchers/e_vouchers.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EVouchersService {
  Future<EVoucherListModel?> getEVouchersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}evoucherlist?userid=$userid&batchid=$batchid'));
      log('E-Vouchers List response  --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return EVoucherListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<void> sendEVouchers({
    required String amount,
    required String branchid,
    required String reservationid,
    required String reason,
    required String batchid,
    required String rasingto,
    required String comments,
    required String type,
    required BuildContext context,
  }) async {
    try {
      var userid = GetUserData().getUserId();
      final Map<String, String> requestBody = {
        'reservationid': reservationid,
        'userid': userid,
        'amount': amount,
        'reason': reason,
        'branchid': branchid,
        'requested_to': rasingto,
        'batchid': batchid,
        'comments': comments,
        'type': type
      };

      log('requestBody --> ${requestBody.toString()}');
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}createevoucher'), body: {
        'reservationid': reservationid,
        'userid': userid,
        'amount': amount,
        'reason': reason,
        'branchid': branchid,
        'requested_to': rasingto,
        'batchid': batchid,
        'comments': comments,
        'type': type
      });
      log('CreateEVouchers --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);
        if (decodedbody['status'] == false) {
          if (context.mounted) {
            CustomSnackBar.atBottom(
                title: "Failed", body: decodedbody['message'], status: false);
          }
        } else if (decodedbody['status'] == true) {
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EVouchersScreen()));
            CustomSnackBar.atBottom(
              title: "Successful",
              body: "Created succesfully",
            );
          }
          log('Post request successful');
        }
      } else {
        CustomSnackBar.atBottom(
          title: "Failed",
          body: "Failed to send reservation",
          status: false,
        );
        debugPrint('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<EVoucherApprovalModels?> getEVouchersApprovalList(
      {required dynamic type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}evoucherrequests?userid=$userid&batchid=$batchid&type=$type'));
      log('E-Vouchers Approval List response  --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return EVoucherApprovalModels.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<EmployeeFieldModel?> getEmployeeNameList() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}referredby'));
      log('E-Vouchers Employee Name  --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return EmployeeFieldModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> eVoucherApproveOrReject(
    BuildContext context, {
    required dynamic id,
    required dynamic amount,
    required dynamic reason,
    required dynamic reservationid,
    required dynamic status,
    required dynamic voucherid,
    required dynamic branchid,
    required dynamic type,
    required dynamic commentreason,
    required dynamic comments,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic savedbatchid = prefs.getString('batchid');
    var userid = GetUserData().getUserId();
    try {
      final Map<String, String> requestBody = {
        'studentid': reservationid.toString(),
        'userid': userid.toString(),
        'amount': amount.toString(),
        'reason': reason.toString(),
        // 'branchid': branchid.toString(),
        'voucherid': voucherid,
        'id': id.toString(),
        'commentreason': commentreason,
        'type': type,
        'status': status.toString(),
        'commentreason': commentreason,
        'type': type,
        'batchid': savedbatchid,
        'commemts': comments
      };
      log('requestBody --> $requestBody');
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approveevoucher'),
        body: {
          'studentid': reservationid.toString(),
          'userid': userid.toString(),
          'amount': amount.toString(),
          'reason': reason.toString(),
          'voucherid': voucherid,
          'id': id.toString(),
          'status': status.toString(),
          'commentreason': commentreason,
          'type': type,
          'batchid': savedbatchid,
          'comments': comments
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'E - Voucher approved succesfully'
                : status == '2'
                    ? 'E - Voucher rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approve E - Voucher'
                : status == '2'
                    ? 'Failed to reject E - Voucher'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
