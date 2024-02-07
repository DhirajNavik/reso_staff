import 'dart:convert';
import 'dart:developer';
import 'package:attendance/model/view_application_dashboard.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDashBoardService {
  Future<ViewDashBoardModel?> getDashboardDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic batchID = prefs.getString('batchid');
      final userID = GetUserData().getUserId();
      final branchID = GetUserData().getUserBranch();

      Map<String, dynamic> data = {
        'userid': userID,
        "batchid": batchID,
        "branchid": branchID
      };
      log('get dashboard Request Body --> $data');

      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}getapplicationscount?batchid=$batchID&userid=4&branchid=$branchID'));

      log('getDashboard --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ViewDashBoardModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
