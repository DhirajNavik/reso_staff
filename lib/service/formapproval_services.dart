import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/branch_form_model.dart';
import 'package:attendance/model/discount_form_model.dart';
import 'package:attendance/model/refund_form_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class ApprovalFormService {
  Future<BranchTransfer?> getBranchTransferList() async {
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}formapprovals?form=branchtransfer'));
      print('branchtransfer --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return BranchTransfer.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<RefundApproval?> getRefundList() async {
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}formapprovals?form=refundApproval'));
      print('refundApproval --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return RefundApproval.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<DiscountApproval?> getDiscountList() async {
    try {
      final response = await http.get(
          Uri.parse('${Strings.baseUrl}formapprovals?form=discountApproval'));
      print('discountApproval --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return DiscountApproval.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<void> formApproveorReject({
    required dynamic formredid,
    required dynamic status,
    required dynamic refundamt,
  }) async {
    var userid = GetUserData().getUserId();
    try {
      final snackBarMsg = status == "1" ? "Approved" : "Rejected";
      final response = await http
          .post(Uri.parse('${Strings.baseUrl}formRequestApproval?'), body: {
        'form_request_id': formredid,
        'userid': userid,
        'status': status,
        'refundAmount': refundamt,
      });
      print('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(title: "Success", body: "Form $snackBarMsg");
      } else {
        CustomSnackBar.atBottom(
            title: "Failed", body: "Failed to Approve/Reject");
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }
}
