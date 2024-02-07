import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/vouchers_approvals/f_voucher_approval_models.dart';
import 'package:attendance/model/vouchers/f_voucher_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/f_vouchers/f_vouchers.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FVouchersService {
  Future<FVoucherListModel?> getFVouchersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}fvoucherlist?userid=$userid&batchid=$batchid'));
      log('F-Vouchers List response  --> ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return FVoucherListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<void> sendFVouchers({
    required String amount,
    required String branchid,
    required String reservationid,
    required String reason,
    required String batchid,
    required String rasingto,
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
      };

      log('requestBody --> ${requestBody.toString()}');
      final response =
          await http.post(Uri.parse('${Strings.baseUrl}createfvoucher'), body: {
        'reservationid': reservationid,
        'userid': userid,
        'amount': amount,
        'reason': reason,
        'branchid': branchid,
        'requested_to': rasingto,
        'batchid': batchid,
        'type': type
      });
      log('Add Bank response --> \n ${response.body}');

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
                MaterialPageRoute(builder: (context) => FVouchersScreen()));
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

  Future<FVoucherApprovalModels?> getFVouchersApprovalList(
      {required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}fvoucherrequests?userid=$userid&batchid=$batchid&type=$type'));
      log('F-Vouchers Approval List response  --> ${response.body} ');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return FVoucherApprovalModels.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> fVoucherApproveOrReject(
    BuildContext context, {
    required dynamic id,
    required dynamic amount,
    required dynamic reason,
    required dynamic reservationid,
    required dynamic status,
    required dynamic voucherid,
    required dynamic commentreason,
    required dynamic type,
    required dynamic comments,
  }) async {
    var userid = GetUserData().getUserId();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic savedbatchid = prefs.getString('batchid');
      final Map<String, String> requestBody = {
        'id': id.toString(),
        'amount': amount.toString(),
        'reason': reason.toString(),
        'studentid': reservationid.toString(),
        'status': status.toString(),
        'voucherid': voucherid,
        'userid': userid.toString(),
        "type": type
      };
      log('requestBody --> $requestBody');
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approvefvoucher'),
        body: {
          'id': id.toString(),
          'amount': amount.toString(),
          'reason': reason.toString(),
          'studentid': reservationid.toString(),
          'status': status.toString(),
          'voucherid': voucherid,
          'userid': userid.toString(),
          'commentreason': commentreason,
          "type": type,
          "batchid": savedbatchid,
          "comments": comments
        },
      );
      log('requestBody --> ${response.statusCode.toString()}');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'F - Voucher approved succesfully'
                : status == '2'
                    ? 'F - Voucher rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approve F - Voucher'
                : status == '2'
                    ? 'Failed to reject F - Voucher'
                    : '',
            status: false);
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
