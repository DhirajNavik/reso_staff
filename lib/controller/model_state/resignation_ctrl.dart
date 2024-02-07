import 'dart:developer';
import 'package:attendance/model/resignation_finance_model.dart';
import 'package:attendance/model/resignation_form_approval_model.dart';
import 'package:attendance/model/resignation_hr_model.dart';
import 'package:attendance/model/resignationlist_model.dart';
import 'package:attendance/service/resignation_services.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResignationGetx extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();

    clearTextfield();
  }

  TextEditingController lastWorkingDayController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController nullCtrl = TextEditingController();
  DateTime intialDate = DateTime.now();
  List<ResignationListDatum> resignationList = [];
  List<ResignationFormDatum> resignationFormList = [];
  List<ResignationFinanceDatum> resignationFinanceList = [];
  List<ResignationHrDatum> resignationHRList = [];

  bool isLoading = false;
  bool showLoader = false;

  Future<void> sendResignation(BuildContext context) async {
    CustomDialog.showDialogTransperent(context);
    await ResignationService().sendResignation(
      lastWorkingDay: lastWorkingDayController.text,
      resignationReason: reasonController.text,
      context: context,
    );
    getResignationList();
    update();
  }

  Future<void> getResignationList() async {
    isLoading = true;
    ResignationList? response = await ResignationService().getResignationList();
    if (response != null) {
      if (response.data != null) {
        update();
        resignationList = response.data ?? [];
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

  Future<void> getResignationFormList() async {
    isLoading = true;
    ResignationFormModel? response =
        await ResignationService().getResignationFormList();
    if (response != null) {
      if (response.data != null) {
        update();
        resignationFormList = response.data ?? [];
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

  Future<void> resignationFormApproveOrReject({
    dynamic context,
    dynamic resignationid,
    dynamic status,
  }) async {
    await ResignationService().resignationFormApproveOrReject(
      context,
      resignationid: resignationid,
      status: status,
    );

    await getResignationFormList();
    update();
  }

  Future<void> getResignationFinanceList() async {
    isLoading = true;
    ResignationFinanceModel? response =
        await ResignationService().getResignationFinanceList();
    if (response != null) {
      if (response.data != null) {
        update();
        resignationFinanceList = response.data ?? [];
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

  Future<void> resignationFinanceApproveOrReject({
    dynamic context,
    dynamic resignationid,
    dynamic status,
  }) async {
    await ResignationService().resignationFinanceApproveOrReject(
      context,
      status: status,
      resignationid: resignationid,
    );

    await getResignationFinanceList();
    update();
  }

  Future<void> getResignationHRList() async {
    isLoading = true;
    ResignationHrModel? response =
        await ResignationService().getResignationHRList();
    if (response != null) {
      if (response.data != null) {
        update();
        resignationHRList = response.data ?? [];
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

  Future<void> resignationHRApproveOrReject({
    dynamic context,
    dynamic resignationid,
    dynamic status,
  }) async {
    await ResignationService().resignationHRApproveOrReject(
      context,
      status: status,
      resignationid: resignationid,
    );

    await getResignationHRList();
    update();
  }

  void clearTextfield() {
    lastWorkingDayController.clear();
    reasonController.clear();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  TextEditingController searchCtrl = TextEditingController();
  List<dynamic> searchData = [];
  getSearchResultFinance(String value) {
    searchData.clear();
    for (var i in resignationFinanceList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.employeeid.toString().toLowerCase().contains(value.toLowerCase())) {
        ResignationFinanceDatum data = ResignationFinanceDatum(
          id: i.id,
          employeeId: i.employeeId,
          lastWorkingDay: i.lastWorkingDay,
          status: i.status,
          isReportingApproved: i.isReportingApproved,
          reportingApprovedBy: i.reportingApprovedBy,
          isFinanceApproved: i.isFinanceApproved,
          financeApprovedBy: i.financeApprovedBy,
          isHrApproved: i.isHrApproved,
          hrApprovedBy: i.hrApprovedBy,
          reason: i.reason,
          date: i.date,
          name: i.name,
          employeeid: i.employeeid,
          firebase: i.firebase,
          reportingname: i.reportingname,
          financename: i.financename,
          hrname: i.hrname,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

  getSearchResultHR(String value) {
    searchData.clear();
    for (var i in resignationHRList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.employeeid.toString().toLowerCase().contains(value.toLowerCase())) {
        ResignationFinanceDatum data = ResignationFinanceDatum(
          id: i.id,
          employeeId: i.employeeId,
          lastWorkingDay: i.lastWorkingDay,
          status: i.status,
          isReportingApproved: i.isReportingApproved,
          reportingApprovedBy: i.reportingApprovedBy,
          isFinanceApproved: i.isFinanceApproved,
          financeApprovedBy: i.financeApprovedBy,
          isHrApproved: i.isHrApproved,
          hrApprovedBy: i.hrApprovedBy,
          reason: i.reason,
          date: i.date,
          name: i.name,
          employeeid: i.employeeid,
          firebase: i.firebase,
          reportingname: i.reportingname,
          financename: i.financename,
          hrname: i.hrname,
        );
        update();
        searchData.add(data);
        update();
      }
    }
  }

  TextEditingController resignationFormSearchCtrl = TextEditingController();
  List<dynamic> resignationFormsearchData = [];
  getSearchResultResignationForm(String value) {
    resignationFormsearchData.clear();
    for (var i in resignationFormList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase())) {
        ResignationFormDatum data = ResignationFormDatum(
          id: i.id,
          employeeId: i.employeeId,
          lastWorkingDay: i.lastWorkingDay,
          status: i.status,
          isReportingApproved: i.isReportingApproved,
          reportingApprovedBy: i.reportingApprovedBy,
          financeApproved: i.financeApproved,
          financeApprovedBy: i.financeApprovedBy,
          hrApproved: i.hrApproved,
          hrApprovedBy: i.hrApprovedBy,
          reason: i.reason,
          date: i.date,
          name: i.name,
          employeeid: i.employeeid,
          firebase: i.firebase,
        );

        update();
        resignationFormsearchData.add(data);
        update();
      }
    }
  }
}
