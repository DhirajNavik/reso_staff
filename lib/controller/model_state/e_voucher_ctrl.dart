import 'dart:developer';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/model/discount_details_model.dart';
import 'package:attendance/model/evoucher_employee_model.dart';
import 'package:attendance/model/vouchers_approvals/e_voucher_approval_models.dart';
import 'package:attendance/model/vouchers/e_vouchers_model.dart';
import 'package:attendance/model/vouchers/f_voucher_model.dart';
import 'package:attendance/model/reservation/reservation_discount/raising_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_discount_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_dropdown_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_max_amt_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_sibling_model.dart';
import 'package:attendance/service/e_vouchers_services.dart';
import 'package:attendance/service/reservation_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EVoucherGetx extends GetxController {
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

  final GlobalKey<FormState> addEVoucherDiscountformKey =
      GlobalKey<FormState>();
  List<TextEditingController> allcommentsControllers = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
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

//---------------------------------E - Voucher List
  List<EVoucherDatum> reservationList = [];
  Future<void> getEVouchersList() async {
    showLoader = true;
    final response = await EVouchersService().getEVouchersList();
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

//---------------------------------E - Voucher Send
  Future<void> sendEVouchers({
    required BuildContext context,
  }) async {
    if (selectedId.isNotEmpty && selectedEmployeeName!.isNotEmpty) {
      await EVouchersService().sendEVouchers(
          amount: amountController.text,
          branchid: branchidItem,
          reservationid: selectedId,
          reason: reasonController.text,
          batchid: studentbatchid,
          rasingto: raisedUserID!,
          context: context,
          comments: selectedEmployeeName!,
          type: selectedAddType);
      // selectedEmployeeName = '';
    } else {
      Map<String, dynamic> data = {
        "amount": amountController.text,
        "branchid": branchidItem,
        "reservationid": selectedId,
        "reason": reasonController.text,
        "batchid": studentbatchid,
        "rasingto": raisedUserID!,
        "context": context,
        "comments": selectedEmployeeName!,
        "type": selectedAddType
      };
      log(data.toString());
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
  List<EVoucherApprovalDatum> reservationApprovalList = [];
  Future<void> getEVoucherApprovalList() async {
    formamountControllers.clear();
    showLoader = true;
    final response = await EVouchersService()
        .getEVouchersApprovalList(type: selectedAddType);
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
  Future<void> eVoucherApproveOrReject({
    required dynamic context,
    required dynamic amount,
    required dynamic status,
    required dynamic reason,
    required dynamic reservationid,
    required dynamic commentreason,
    required String comments,
    dynamic voucherid,
    required dynamic id,
  }) async {
    isResponding = true;
    update();
    await EVouchersService().eVoucherApproveOrReject(
      context,
      amount: amount,
      status: status,
      id: id,
      reservationid: reservationid,
      reason: reason,
      voucherid: voucherid ?? '',
      branchid: branchidItem,
      commentreason: commentreason,
      type: selectedAddType,
      comments: comments,
    );
    await getEVoucherApprovalList();
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

  Future<void> getDropdownList() async {
    showLoader = true;
    ReservationDropdown? response =
        await ReservationDiscountService().getDropdownList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownList = response.data ?? [];
        log('dropdown  List --> ${dropdownList.toString()}');
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

  Future<void> getDropdownListStudent() async {
    dropdownList.clear();
    showLoader = true;
    ReservationStudentDropdown? response =
        await ReservationDiscountService().getDropdownStudentList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownList = response.data ?? [];
        log('Student  List --> ${dropdownList.toString()}');
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

  //employeeName

  List<EmployeeNameDatum> employeeList = [];
  List<String> employeeNameList = [];
  TextEditingController employeeNameController = TextEditingController();
  Future<void> getEmployeeList() async {
    showLoader = true;
    final response = await EVouchersService().getEmployeeNameList();
    if (response != null) {
      if (response.data != null) {
        employeeNameList.clear();
        update();
        employeeList = response.data ?? [];
        for (var i in response.data!) {
          employeeNameList.add(i.name!);
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

  String? selectedEmployeeName;
  // String? raisedUserID;
  selEmployeeName(String newValue) {
    selectedEmployeeName = newValue;
    update();
    log('ctrl pro -->${raisingToController.text}');
    update();
    // for (var i in rasingToList) {
    //   if (i.name == selectedEmployeeName) {
    //     raisedUserID = i.userid.toString();
    //   }
    // }
  }

  //-------------------------------*** F - Voucher
  TextEditingController s1amountController = TextEditingController();
  TextEditingController s2amountController = TextEditingController();

  //----Validation
  String? eVoucherValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    return null;
  }

  //-----E Voucher Search
  TextEditingController sVouchersearchCtrl = TextEditingController();
  List<dynamic> sVouchersearchData = [];
  getSearchResultHR(String value) {
    sVouchersearchData.clear();
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
          EVoucherDatum data = EVoucherDatum(
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
          sVouchersearchData.add(data);
          update();
        }
      } else {
        if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
            i.reservationUkey
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase())) {
          EVoucherDatum data = EVoucherDatum(
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
          sVouchersearchData.add(data);
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
