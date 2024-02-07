import 'dart:developer';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/model/discount_details_model.dart';
import 'package:attendance/model/vouchers_approvals/f_voucher_approval_models.dart';
import 'package:attendance/model/vouchers/f_voucher_model.dart';
import 'package:attendance/model/reservation/reservation_discount/raising_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_discount_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_dropdown_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_max_amt_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_sibling_model.dart';
import 'package:attendance/service/f_vouchers_services.dart';
import 'package:attendance/service/reservation_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FVoucherGetx extends GetxController {
  String? _selectedAddType = 'Reservation';
  String get selectedAddType => _selectedAddType!;
  List<String> board = ['Student', 'Reservation'];

  set selectedAddType(String value) {
    _selectedAddType = value;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getDropdownListDiscount();
    await getDropdownList();

    clearTextfield();
  }

  final GlobalKey<FormState> addReservationDiscountformKey =
      GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  List<TextEditingController> allcommentsControllers = [];
  List<TextEditingController> formamountControllers = [];
  List<TextEditingController> formamount2Controllers = [];

  List<String> dropdownListDiscount = ['Select Type'];
  String dropdownvalue = 'Select Type';
  bool showLoader = false;

  List<Datum> dropdownList = [];
  List<SiblingListDatum> dropdownListSiblings = [];

  // List<ReservationApprovalDatum> reservationFormList = [];

  String selectedId = '';
  String selectedadmissiontypeid = '';
  String? selectedukey;
  String? selectedValue;
  String? selectedValue2;
  String? siblingapplication;
  TextEditingController searchController = TextEditingController();
  List<MaxAmtDatum> maxAmountList = [];

  void clearfields() {
    searchController.clear();
    amountController.clear();
    reasonController.clear();
    selectedValue2 = null;
    selectedValue = null;
    dropdownvalue = 'Select Type';
    selectedId = '';
    selectedadmissiontypeid = '0';
  }

//---------------------------------F - Voucher List
  List<FVoucherDatum> reservationList = [];
  Future<void> getFVoucherList() async {
    showLoader = true;
    final response = await FVouchersService().getFVouchersList();
    if (response != null) {
      if (response.data != null) {
        update();
        reservationList = response.data ?? [];
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

//---------------------------------F - Voucher Send
  Future<void> sendFVouchers({
    required BuildContext context,
  }) async {
    if (selectedId.isNotEmpty) {
      await FVouchersService().sendFVouchers(
        amount: amountController.text,
        branchid: branchidItem,
        reservationid: selectedId,
        reason: reasonController.text,
        batchid: studentbatchid,
        rasingto: raisedUserID!,
        context: context,
        type: selectedAddType,
      );
    } else {
      CustomSnackBar.atBottom(
          title: "Select ReservationNo/Name", body: "error", status: false);
    }
  }

//---------------------------------F - Voucher onReservationSelected
  dynamic studentbatchid;
  dynamic branchidItem;
  dynamic reservationid;

  Future<void> onReservationSelected({
    dynamic id,
    dynamic typeid,
    dynamic branchid,
    dynamic courseid,
    dynamic batchid,
    dynamic reservationid,
    required BuildContext context,
  }) async {
    selectedId = id;
    selectedadmissiontypeid = typeid;
    studentbatchid = batchid;
    branchidItem = branchid;
    log(selectedId.toString());
    update();
  }

//-------------------------------
  //---------------------------------F - Voucher Approval List
  List<FVoucherApprovalDatum> reservationApprovalList = [];
  Future<void> getFVoucherApprovalList() async {
    formamountControllers.clear();
    showLoader = true;
    final response = await FVouchersService()
        .getFVouchersApprovalList(type: selectedAddType);
    if (response != null) {
      if (response.data != null) {
        update();
        reservationApprovalList = response.data ?? [];
        for (int i = 0; i < reservationApprovalList.length; i++) {
          allcommentsControllers.add(TextEditingController());
          formamountControllers.add(
              TextEditingController(text: reservationApprovalList[i].amount));
        }
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

  bool isResponding = false;
  Future<void> fVoucherApproveOrReject({
    required dynamic context,
    required dynamic amount,
    required dynamic status,
    required dynamic reason,
    required dynamic reservationid,
    required dynamic commentreason,
    required dynamic comments,
    dynamic voucherid,
    required dynamic id,
  }) async {
    isResponding = true;
    update();
    await FVouchersService().fVoucherApproveOrReject(
      context,
      amount: amount,
      status: status,
      id: id,
      reservationid: reservationid,
      reason: reason,
      voucherid: voucherid ?? '',
      commentreason: commentreason,
      type: selectedAddType,
      comments: comments,
    );
    await getFVoucherApprovalList();
    isResponding = false;
    update();
  }

//----
  Future<void> getMaxAmount() async {
    update();
    final response = await ReservationDiscountService().getMaxAmount();
    if (response != null) {
      if (response.data != null) {
        update();
        maxAmountList = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    update();
  }

  List<NewMaxDatum> newmaxAmountList = [];
  String? newMaxAmount;
  Future<void> postMaxAmountNew({
    dynamic branchidd,
    dynamic courseid,
    dynamic batchid,
    dynamic reservationid,
    required BuildContext context,
  }) async {
    update();
    final response = await ReservationDiscountService().getMaxAmountNew(
        addmissiontype: selectedadmissiontypeid,
        batchid: batchid,
        branchidd: branchidd,
        context: context,
        courseid: courseid,
        reservationid: '');

    if (response != null) {
      if (response.data != null) {
        update();
        newmaxAmountList = response.data ?? [];
        newMaxAmount = response.data![0].amount.toString();
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    update();
  }

  void onReservationchanged(String value) {
    selectedValue = value;
    update();
  }

  void onSiblingsSelected({dynamic applicationNumber}) {
    siblingapplication = applicationNumber;
    update();
  }

  void onSiblingschanged(String value) {
    selectedValue2 = value;
    update();
  }

  ProvGetnSet roleid = Get.put(ProvGetnSet());
  Future<void> getDropdownListDiscount() async {
    dynamic currentUser = GetUserData().getCurrentUser();
    roleid.getSavedResponse();
    log('employeeid = ${currentUser.employeeid}');
    log('roleid = ${roleid.savedResponse}');
    showLoader = true;
    ReservationDiscountDropdown? response =
        await ReservationDiscountService().getDropdownListDiscount();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownListDiscount.addAll(response.data!);
        if (roleid.savedResponse == '3') {
          dropdownListDiscount.remove('Referral');
        }
        if (currentUser.employeeid == 'MDG0009' ||
            currentUser.employeeid == 'MDG0003' ||
            currentUser.employeeid == 'MDG0004' ||
            currentUser.employeeid == 'MDG0005' ||
            currentUser.employeeid == 'MDG0001' ||
            currentUser.employeeid == 'MDG0002') {
          dropdownListDiscount.remove('Application');
          dropdownListDiscount.remove('Sibling');
        }
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

  Future<void> getDropdownListStudent() async {
    showLoader = true;
    ReservationStudentDropdown? response =
        await ReservationDiscountService().getDropdownStudentList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownList = response.data ?? [];
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

  Future<void> getDropdownList() async {
    showLoader = true;
    ReservationDropdown? response =
        await ReservationDiscountService().getDropdownList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownList = response.data ?? [];
        // dropdownList.addAll(response.data!.name);
        // reasonController.clear();
        // amountController.clear();
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

  // Future<void> sendReservation(
  //   BuildContext context, {
  //   required String reservationid,
  //   required String branchid,
  //   required String reason,
  //   required bool from,
  // }) async {
  //   CustomDialog.showDialogTransperent(context);
  //   await ReservationDiscountService().sendReservation(
  //       comments: '',
  //       discounttype: '',
  //       amount: amountController.text,
  //       reservationid: reservationid,
  //       context: context,
  //       branchid: branchid,
  //       reason: reason,
  //       batchid: studentbatchid,
  //       rasingto: raisedUserID!,
  //       from: from,
  //       amount1: '');
  //   clearfields();

  //   update();
  // }

  void clearTextfield() {
    dropdownvalue = 'Select Type';
    amountController.clear();
  }

  textFormValidation(String? value) {
    if (value!.isEmpty) {
      update();
      return 'This is required';
    }
    return null;
  }

  String? textFormValidation3(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    double lesserLimit;
    double enteredAmount;

    try {
      enteredAmount = double.parse(value);
    } catch (e) {
      return 'Please enter a valid number';
    }

    {
      if (double.parse(maxAmountList[0].availablelimit!) <
          double.parse(newmaxAmountList[0].amount!)) {
        lesserLimit = double.parse(maxAmountList[0].availablelimit!);
      } else {
        lesserLimit = double.parse(newmaxAmountList[0].amount!);
      }
    }

    if (enteredAmount > lesserLimit) {
      return 'Amount cannot exceed $lesserLimit';
    }
    return null;
  }

  // TextEditingController rdsearchCtrl = TextEditingController();
  // List<dynamic> rdsearchData = [];
  // getSearchResult(String value) {
  //   rdsearchData.clear();
  //   formamountControllers.clear();
  //   formamount2Controllers.clear();
  //   for (var i in reservationApprovalList) {
  //     if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
  //         i.reservationUkey
  //             .toString()
  //             .toLowerCase()
  //             .contains(value.toLowerCase())) {
  //       ReservationApprovalDatum data = ReservationApprovalDatum(
  //         id: i.id,
  //         amount: i.amount,
  //         amount1: i.amount1,
  //         discounttype: i.discounttype,
  //         comments: i.comments,
  //         status: i.status,
  //         reservationUkey: i.reservationUkey,
  //         name: i.name,
  //         studentid: i.studentid,
  //         reservationdiscountid: i.reservationdiscountid,
  //         reason: i.reason,
  //         approvedby: i.approvedby,
  //         branchname: i.branchname,
  //         coursename: i.coursename,
  //         admissiontypename: i.admissiontypename,
  //         discounts: i.discounts,
  //         totalfee: i.totalfee,
  //         paidamount: i.paidamount,
  //         reservationid: i.reservationid,
  //       );

  //       update();
  //       rdsearchData.add(data);
  //       formamountControllers.add(TextEditingController(text: i.amount));
  //       formamount2Controllers.add(TextEditingController(text: i.amount1));
  //       update();
  //     }
  //   }

  //   update();
  // }

  List<RaisingToDatum> rasingToList = [];
  List<String> rasingToNameList = [];
  TextEditingController raisingToController = TextEditingController();
  Future<void> getRaisingTo() async {
    showLoader = true;
    final response = await ReservationDiscountService().getRaisingTo();
    if (response != null) {
      if (response.data != null) {
        rasingToNameList.clear();
        update();
        rasingToList = response.data ?? [];
        for (var i in response.data!) {
          rasingToNameList.add(i.name!);
        }
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

  String? selectedRaisedTo;
  String? raisedUserID;
  raisedToValue(String newValue) {
    selectedRaisedTo = newValue;
    update();
    log('ctrl pro -->${raisingToController.text}');
    update();
    for (var i in rasingToList) {
      if (i.name == selectedRaisedTo) {
        raisedUserID = i.userid.toString();
      }
    }
  }

  //-------------------------------*** F - Voucher
  TextEditingController s1amountController = TextEditingController();
  TextEditingController s2amountController = TextEditingController();

  //----Validation
  String? fVoucherValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    return null;
  }

  //-----F Voucher Search
  TextEditingController fVouchersearchCtrl = TextEditingController();
  List<dynamic> fVouchersearchData = [];
  getSearchResultHR(String value) {
    fVouchersearchData.clear();
    for (var i in reservationList) {
      if (i.type == '2') {
        if (i.studentname
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            i.applicationnumber
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase())) {
          FVoucherDatum data = FVoucherDatum(
              amount: i.amount,
              amount1: i.amount1,
              reservationDiscountid: i.reservationDiscountid ?? '',
              approvedby: i.approvedby,
              approvedDate: i.approvedDate,
              discounttype: i.discounttype,
              comments: i.comments,
              reason: i.reason,
              status: i.status,
              reservationUkey: i.applicationnumber,
              name: i.studentname,
              type: i.type,
              studentname: i.studentname,
              applicationnumber: i.applicationnumber,
              commentreason: i.commentreason);
          update();
          fVouchersearchData.add(data);
          update();
        }
      } else {
        if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
            i.reservationUkey
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase())) {
          FVoucherDatum data = FVoucherDatum(
              amount: i.amount,
              amount1: i.amount1,
              reservationDiscountid: i.reservationDiscountid ?? '',
              approvedby: i.approvedby,
              approvedDate: i.approvedDate,
              discounttype: i.discounttype,
              comments: i.comments,
              reason: i.reason,
              status: i.status,
              reservationUkey: i.reservationUkey,
              name: i.name,
              type: i.type,
              studentname: i.studentname,
              applicationnumber: i.applicationnumber,
              commentreason: i.commentreason);
          update();
          fVouchersearchData.add(data);
          update();
        }
      }
    }
  }

  List<DiscountsDetailsDatum> discountDetailsList = [];

  Future<void> getDiscountsDetails({required dynamic reservationid}) async {
    final response = await ReservationDiscountService().getDiscountsDetails(
        reservationid: reservationid, type: selectedAddType);
    if (response != null) {
      if (response.data != null) {
        update();
        discountDetailsList = response.data ?? [];
        for (var i in response.data!) {
          rasingToNameList.add(i.name!);
        }
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    update();

    update();
  }
}
