import 'dart:developer';
import 'package:attendance/model/reimburse_form_approval_model.dart';
import 'package:attendance/model/reimburselist_model.dart';
import 'package:attendance/model/reimbursement_hr_model.dart';
import 'package:attendance/model/reimbursement_model.dart';
import 'package:attendance/service/reimbursement_services.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReimbursementGetx extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getReimburseList();
    await getDropdownList();
    clearTextfield();
  }

  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<String> dropdownList = ['Select Type'];
  String dropdownvalue = 'Select Type';
  bool showLoader = false;
  bool isLoading = false;

  List<ReimburseListDatum> reimburseList = [];
  List<ReimburseFormDatum> reimburseFormList = [];
  List<ReimburseHrDatum> reimburseHRList = [];

  Future<void> getDropdownList() async {
    showLoader = true;
    ReimburseDropdown? response =
        await ReimbursementService().getDropdownList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownList.addAll(response.data!);
        reasonController.clear();
        amountController.clear();
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    showLoader = false;
    update();
  }

  Future<void> sendReimbursement(BuildContext context) async {
    CustomDialog.showDialogTransperent(context);
    await ReimbursementService().sendReimbursement(
        category: dropdownvalue,
        reason: reasonController.text,
        amount: amountController.text,
        context: context);
    update();
  }

  Future<void> getReimburseList() async {
    isLoading = true;
    ReimburseList? response = await ReimbursementService().getReimburseList();
    if (response != null) {
      if (response.data != null) {
        update();
        reimburseList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isLoading = false;
    update();
  }

  Future<void> getReimburseFormList() async {
    isLoading = true;
    ReimburseFormModel? response =
        await ReimbursementService().getReimburseFormList();
    if (response != null) {
      if (response.data != null) {
        update();
        reimburseFormList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isLoading = false;
    update();
  }

  Future<void> reimbursementformApproveReject({
    dynamic context,
    dynamic reimbursementid,
    dynamic status,
  }) async {
    await ReimbursementService().reimbursementApproveOrReject(context,
        reimbursementid: reimbursementid, status: status);

    await getReimburseFormList();
    update();
  }

  Future<void> getReimburseHRList() async {
    isLoading = true;
    ReimburseHrModel? response =
        await ReimbursementService().getReimburseHRList();
    if (response != null) {
      if (response.data != null) {
        update();
        reimburseHRList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isLoading = false;
    update();
  }

  Future<void> reimbursementHRApproveOrReject({
    dynamic context,
    dynamic reimbursementid,
    dynamic status,
  }) async {
    await ReimbursementService().reimbursementHRApproveOrReject(
      context,
      reimbursementid: reimbursementid,
      status: status,
    );

    await getReimburseHRList();
    update();
  }

  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> HRsearchData = [];
  getSearchResultHR(String value) {
    HRsearchData.clear();
    for (var i in reimburseHRList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.employeeid.toString().toLowerCase().contains(value.toLowerCase())) {
        ReimburseHrDatum data = ReimburseHrDatum(
          id: i.id,
          userid: i.userid,
          category: i.category,
          amount: i.amount,
          reason: i.reason,
          status: i.status,
          isReportingApproved: i.isReportingApproved,
          reportingApprovedBy: i.reportingApprovedBy,
          isHrApproved: i.isHrApproved,
          hrApprovedBy: i.hrApprovedBy,
          date: i.date,
          name: i.name,
          employeeid: i.employeeid,
          firebase: i.firebase,
          reportingname: i.reportingname,
          hrname: i.hrname,
        );
        update();
        HRsearchData.add(data);
        update();
      }
    }
  }

  void clearTextfield() {
    dropdownvalue = 'Select Type';
    reasonController.clear();
    amountController.clear();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  TextEditingController reimburseFormSearchCtrl = TextEditingController();
  List<dynamic> reimburseFormSearchData = [];

  void getSearchResultRefund(String value) {
    reimburseFormSearchData.clear();
    for (var i in reimburseFormList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase())) {
        ReimburseFormDatum data = ReimburseFormDatum(
          id: i.id,
          userid: i.userid,
          category: i.category,
          amount: i.amount,
          reason: i.reason,
          isReportingApproved: i.isReportingApproved,
          reportingApprovedBy: i.reportingApprovedBy,
          isHrApproved: i.isHrApproved,
          hrApprovedBy: i.hrApprovedBy,
          date: i.date,
          name: i.name,
          employeeid: i.employeeid,
          firebase: i.firebase,
        );

        update();
        reimburseFormSearchData.add(data);
        update();
      }
    }
    update();
  }
}
