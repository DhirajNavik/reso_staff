import 'dart:convert';
import 'dart:developer';
import 'package:attendance/model/discount_details_model.dart';
import 'package:attendance/model/reservation/reservation_approval_model.dart';
import 'package:attendance/model/reservation/reservation_discount/raising_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_discount_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_max_amt_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservationlist_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_sibling_model.dart';
import 'package:attendance/model/reservation/reservation_max_by_userid_model.dart';
import 'package:attendance/view/pages/reservation_discount/reservation_discount.dart';
import 'package:attendance/view/pages/s_vouchers/s_vouchers.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/constant/strings.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_dropdown_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/get_user_id.dart';

class ReservationDiscountService {
  Future<void> sendReservation({
    required String comments,
    required String discounttype,
    required String amount,
    required String branchid,
    required String reservationid,
    required String reason,
    required String batchid,
    required String rasingto,
    required String amount1,
    required String type,
    required BuildContext context,
    required bool from,
  }) async {
    try {
      var userid = GetUserData().getUserId();
      final Map<String, String> requestBody = {
        'reservationid': reservationid,
        'amount': amount,
        'amount1': amount1,
        'discounttype': discounttype,
        'comments': comments,
        'userid': userid,
        'branchid': branchid,
        'reason': reason,
        'batchid': batchid,
        'requested_to': rasingto,
      };
      log('requestBody --> ${requestBody.toString()}');
      final response = await http.post(
          Uri.parse('${Strings.baseUrl}createreservationdiscount'),
          body: {
            'reservationid': reservationid,
            'amount': amount,
            'amount1': amount1,
            'discounttype': discounttype,
            'comments': comments,
            'userid': userid,
            'branchid': branchid,
            'reason': reason,
            'batchid': batchid,
            'requested_to': rasingto,
            'type': type
          });
      log('Add Bank response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var decodedbody = json.decode(response.body);
        if (decodedbody['status'] == false) {
          if (context.mounted) {
            Navigator.pop(context);
            CustomSnackBar.atBottom(
                title: "Failed", body: decodedbody['message'], status: false);
          }
        } else if (decodedbody['status'] == true) {
          if (context.mounted) {
            Navigator.pop(context);
            from == true
                ? Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SVouchersScreen()))
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReservationDiscountScreen()));
            CustomSnackBar.atBottom(
              title: "Successful",
              body: "Reservation send succesfully",
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
        print('Post request failed');
      }
    } catch (e) {
      debugPrint('catche is $e');
    }
  }

  Future<NewMaxAmtModel?> getMaxAmountNew(
      {required String branchidd,
      required String addmissiontype,
      required String courseid,
      required String batchid,
      required String reservationid,
      required BuildContext context}) async {
    try {
      final Map<String, String> requestBody = {
        "admissiontypeid": addmissiontype,
        "batchid": batchid,
        "branchid": branchidd,
        "courseid": courseid,
        "reservationid": reservationid,
      };
      log('requestBody reservationmaxdiscount --> ${requestBody.toString()}');

      final response = await http.post(Uri.parse(
          '${Strings.baseUrl}reservationmaxdiscount?admissiontypeid=$addmissiontype&batchid=$batchid&branchid=$branchidd&courseid=$courseid&reservationid=$reservationid'));

      log('Reservation Max Discount New response --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return NewMaxAmtModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationStudentDropdown?> getDropdownStudentList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    Map<String, dynamic> datareq = {
      'branchid': GetUserData().branchId(),
      'batchid': batchid
    };
    print(datareq.toString());
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}Studentlist'),
        body: {'branchid': GetUserData().branchId(), 'batchid': batchid},
      );
      print(
          '${Strings.baseUrl}Studentlist?branchid=${GetUserData().branchId()}&batchid=$batchid');
      log('Studdent ApplicationNo/Name --> ${response.body} ');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationStudentDropdown.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationDropdown?> getDropdownList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    Map<String, dynamic> datareq = {
      'branchid': GetUserData().branchId(),
      'batchid': batchid
    };
    print(datareq.toString());
    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}Approvedapplicationlist'),
        body: {'branchid': GetUserData().branchId(), 'batchid': batchid},
      );

      log('ReservationNo/Name --> ${Strings.baseUrl}Approvedapplicationlist?branchid=${GetUserData().branchId()}&batchid=$batchid');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationDropdown.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationListModel?> getReservationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}reservationdiscountlist?userid=$userid&batchid=$batchid'));
      log('getReservationList  --> ${response.body} ');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationDiscountDropdown?> getDropdownListDiscount() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}discounttype'));
      log('getDropdownList --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationDiscountDropdown.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<ReservationApprovalModel?> getReservationFormList(
      {required String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic batchid = prefs.getString('batchid');
    log(batchid.toString());
    var userid = GetUserData().getUserId();
    Map<String, dynamic> data = {
      "userid": userid,
      "batchid": batchid,
      "type": type
    };
    log('req ody  --> \n ${data}');

    try {
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}reservationdiscountrequests?userid=$userid&batchid=$batchid&type=$type'));
      log('reservationdiscountrequests  --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return ReservationApprovalModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<dynamic> reservationApproveOrReject(
    BuildContext context, {
    required dynamic status,
    required dynamic amount,
    required dynamic amount1,
    required dynamic comments,
    required dynamic discounttype,
    required dynamic reservationid,
    required dynamic id,
    required dynamic voucherid,
    required dynamic commentreason,
    required dynamic type,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic savedbatchid = prefs.getString('batchid');
    var userid = GetUserData().getUserId();
    Map<String, dynamic> data = {
      'studentid': reservationid.toString(),
      'discounttype': discounttype.toString(),
      'comments': comments.toString(),
      'id': id.toString(),
      'userid': userid.toString(),
      'amount': amount.toString(),
      'amount1': amount1.toString(),
      'status': status.toString(),
      'voucherid': voucherid,
      'commentreason': commentreason,
      'type': type,
      'batchid': savedbatchid
    };
    log("data --> ${data.toString()}");

    try {
      final response = await http.post(
        Uri.parse('${Strings.baseUrl}approvereservationdiscount'),
        body: {
          'studentid': reservationid.toString(),
          'discounttype': discounttype.toString(),
          'comments': comments.toString(),
          'id': id.toString(),
          'userid': userid.toString(),
          'amount': amount.toString(),
          'amount1': amount1.toString(),
          'status': status.toString(),
          'voucherid': voucherid,
          'commentreason': commentreason,
          'type': type,
          'batchid': savedbatchid
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        CustomSnackBar.atBottom(
            title: 'Success',
            body: status == '1'
                ? 'S - Voucher approved succesfully'
                : status == '2'
                    ? 'S - Voucher rejected'
                    : '');
      } else {
        CustomSnackBar.atBottom(
            title: 'Failed',
            body: status == '1'
                ? 'Failed to approve S - Voucher'
                : status == '2'
                    ? 'Failed to reject S - Voucher'
                    : '');
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<SiblingList?> getSiblingDropdownList() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}Siblinglist'));

      log('SiblingList getDropdownList --> ');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return SiblingList.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<MaxAmtModel?> getMaxAmount() async {
    var userid = GetUserData().getUserId();
    try {
      final response = await http
          .get(Uri.parse('${Strings.baseUrl}employeelimit?userid=$userid'));
      log('getMaxAmount --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return MaxAmtModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<RaisingToModel?> getRaisingTo() async {
    try {
      final response =
          await http.get(Uri.parse('${Strings.baseUrl}reservationdiscountto'));
      log('getRaisingTo -->  ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return RaisingToModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<DiscountsDetailsModel?> getDiscountsDetails({
    required dynamic reservationid,
    dynamic? type,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic batchid = prefs.getString('batchid');
      final response = await http.post(Uri.parse(
          '${Strings.baseUrl}reservationdiscounts?userid=$reservationid&batchid=$batchid&type=$type'));
      log('getDiscountsDetails -->  ${Strings.baseUrl}reservationdiscounts?userid=$reservationid&batchid=$batchid&type=$type');
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return DiscountsDetailsModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }

  Future<MaxDiscountByUserIdModel?> getReservationmaxdiscountbyuserid(
      {required dynamic batchid}) async {
    var userid = GetUserData().getUserId();
    try {
      final Map<String, dynamic> data = {
        'userid': userid,
        'batchid': batchid,
      };
      log('request body --> \n ${data.toString()}');
      final response = await http.get(Uri.parse(
          '${Strings.baseUrl}reservationmaxdiscountbyuserid?userid=$userid&batchid=$batchid'));
      log('getMaxAmount by userid error --> \n ${response.body}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return MaxDiscountByUserIdModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('catche is $e');
      return null;
    }
  }
}
