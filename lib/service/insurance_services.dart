import 'dart:convert';
import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/insurance_model.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:http/http.dart' as http;

class InsuranceService {
  Future<Insurance?> insuranceList() async {
    dynamic userid = GetUserData().getUserId();
    try {
      log('userrr-->${userid.toString()}');
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}insurance?userid=$userid'));
      log('response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return Insurance.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
