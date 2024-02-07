import 'dart:developer';
import 'package:attendance/model/branch_form_model.dart';
import 'package:attendance/model/discount_form_model.dart';
import 'package:attendance/model/refund_form_model.dart';
import 'package:attendance/service/formapproval_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApproveFormGetx extends GetxController {
  List<TextEditingController> discountController = [];
  late TextEditingController refundController;

  List<BranchTransferDatum> branchTransferList = [];
  List<RefundApprovalDatum> refundList = [];
  List<DiscountApprovalDatum> discountList = [];

  Future<void> initializeControllers() async {
    await getDiscountList();
    discountController =
        List.generate(discountList.length, (_) => TextEditingController());
    if (discountList.isNotEmpty) {
      for (int i = 0; i < discountList.length; i++) {
        discountController[i].text =
            discountList[i].data!.amount.toString(); // Set the initial text
      }
    }
    update();
  }

  @override
  void dispose() {
    for (var controller in discountController) {
      controller.dispose();
    }
    super.dispose();
  }

  bool showLoader = true;

  Future<void> getBranchTransferList() async {
    showLoader = true;
    update();
    BranchTransfer? response =
        await ApprovalFormService().getBranchTransferList();
    if (response != null) {
      if (response.data != null) {
        update();
        branchTransferList = response.data ?? [];
        update();
      } else {
        log('null');
      }
      showLoader = false;
      update();
    }
  }

  Future<void> getrefundList() async {
    showLoader = true;
    update();
    RefundApproval? response = await ApprovalFormService().getRefundList();
    if (response != null) {
      if (response.data != null) {
        update();
        refundList = response.data ?? [];
      } else {
        log('null');
      }
      showLoader = false;
      update();
    }
  }

  Future<void> getDiscountList() async {
    showLoader = true;
    update();
    DiscountApproval? response = await ApprovalFormService().getDiscountList();
    if (response != null) {
      if (response.data != null) {
        update();
        discountList = response.data ?? [];
      } else {
        log('null');
      }
      showLoader = false;
      update();
    }
  }

  Future<void> loadresources(String type) async {
    type == 'refund'
        ? await getrefundList()
        : type == 'branch'
            ? await getBranchTransferList()
            : await getDiscountList();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  void formApproveorReject({
    dynamic formredid,
    dynamic refundamt,
    dynamic status,
  }) async {
    await ApprovalFormService().formApproveorReject(
        formredid: formredid, refundamt: refundamt, status: status);
    await getrefundList();
    getBranchTransferList();
    await getDiscountList();
  }

  TextEditingController searchCtrl = TextEditingController();

  List<dynamic> discountSearchData = [];

  void getSearchResultDiscount(String value) {
    discountSearchData.clear();
    for (var i in discountList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        DiscountApprovalDatum data = DiscountApprovalDatum(
          formRequestId: i.formRequestId,
          formGroupId: i.formGroupId,
          userId: i.userId,
          formType: i.formType,
          data: i.data,
          fromdate: i.fromdate,
          todate: i.todate,
          indata: i.indata,
          gatepassid: i.gatepassid,
          createdTimestamp: i.createdTimestamp,
          updatedTimestamp: i.updatedTimestamp,
          status: i.status,
          batchid: i.batchid,
          datumCreatedBy: i.datumCreatedBy,
          datumUpdatedBy: i.datumUpdatedBy,
          name: i.name,
          applicationnumber: i.applicationnumber,
          createdBy: i.createdBy,
          updatedBy: i.updatedBy,
          discountid: i.discountid,
        );
        update();
        discountSearchData.add(data);
        update();
      }
    }
    update();
  }

  TextEditingController branchSearchCtrl = TextEditingController();
  List<dynamic> branchSearchData = [];

  void getSearchResultBranch(String value) {
    branchSearchCtrl.clear();
    for (var i in branchTransferList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        BranchTransferDatum data = BranchTransferDatum(
          formRequestId: i.formRequestId,
          formGroupId: i.formGroupId,
          userId: i.userId,
          formType: i.formType,
          data: i.data,
          fromdate: i.fromdate,
          todate: i.todate,
          indata: i.indata,
          gatepassid: i.gatepassid,
          createdTimestamp: i.createdTimestamp,
          updatedTimestamp: i.updatedTimestamp,
          status: i.status,
          batchid: i.batchid,
          datumCreatedBy: i.datumCreatedBy,
          datumUpdatedBy: i.datumUpdatedBy,
          name: i.name,
          applicationnumber: i.applicationnumber,
          createdBy: i.createdBy,
          updatedBy: i.updatedBy,
        );
        update();
        branchSearchData.add(data);
        update();
      }
    }
    update();
  }

  TextEditingController refundSearchCtrl = TextEditingController();
  List<dynamic> refundSearchData = [];

  void getSearchResultRefund(String value) {
    refundSearchData.clear();
    for (var i in refundList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.applicationnumber
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        RefundApprovalDatum data = RefundApprovalDatum(
          formRequestId: i.formRequestId,
          formGroupId: i.formGroupId,
          userId: i.userId,
          formType: i.formType,
          data: i.data,
          fromdate: i.fromdate,
          todate: i.todate,
          indata: i.indata,
          gatepassid: i.gatepassid,
          createdTimestamp: i.createdTimestamp,
          updatedTimestamp: i.updatedTimestamp,
          status: i.status,
          batchid: i.batchid,
          datumCreatedBy: i.datumCreatedBy,
          datumUpdatedBy: i.datumUpdatedBy,
          name: i.name,
          applicationnumber: i.applicationnumber,
          createdBy: i.createdBy,
          updatedBy: i.updatedBy,
        );

        update();
        refundSearchData.add(data);
        update();
      }
    }
    update();
  }
}
