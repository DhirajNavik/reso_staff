import 'dart:convert';
import 'dart:developer';
import 'package:attendance/model/RepoREsponse.dart';
import 'package:attendance/model/view_details_status_model.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/application_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewApplicationDetailsServices {
  Future<ViewApplicationDetailsModel?> getViewApplicationDetails(
      {required String applicationid}) async {
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}getapplicationdetails?applicationid=$applicationid'));

      log('getViewApplicationDetails --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ViewApplicationDetailsModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<RepoResponse?> getPaymentDetails(
      {required String userID, required String batchID}) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // dynamic batchID = prefs.getString('batchid');
      Map<String, dynamic> data = {'userid': userID, "batchid": batchID};
      log('get Payment Request Body --> $data');

      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}getApplicationPaymentLinks?userid=$userID&batchid=$batchID'));

      log('getPaymentDetails --> \n ${json.decode(response.body)}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return RepoResponse.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationStatusModel?> getReservationStatus() async {
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}reservationstatuslookup'));

      log('getReservationStatus -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationStatusModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<void> confirmStatus({
    required String reservationstatusid,
    required String comments,
    required String applicationid,
    required int fee,
    required int fee1,
  }) async {
    try {
      final Map<String, String> requestBody = {
        "reservationstatusid": reservationstatusid!,
        "comments": comments,
        "applicationid": applicationid,
        "fee": fee.toString(),
        "fee1": fee1.toString(),
      };
      print('Request Body --> ${jsonEncode(requestBody)}');

      final response = await http.post(Uri.parse(
          'https://maidendropgroup.com/public/agentdashboard/updateapplicationdetails?applicationid=$applicationid&reservationstatusid=$reservationstatusid&fee=$fee&fee1=$fee1&comments=$comments'));

      log('confirmStatus -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(title: "Success", body: "Status updated");
      } else {
        CustomSnackBar.atBottom(
            title: "Failed", body: "Failed to updated status", status: false);
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }
}
