import 'dart:developer';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/model/discount_details_model.dart';
import 'package:attendance/model/reservation/reservation_approval_model.dart';
import 'package:attendance/model/reservation/reservation_discount/raising_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_discount_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_dropdown_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_max_amt_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservationlist_model.dart';
import 'package:attendance/model/reservation/reservation_discount/reservation_sibling_model.dart';
import 'package:attendance/model/reservation/reservation_max_by_userid_model.dart';
import 'package:attendance/service/reservation_services.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationDiscountGetx extends GetxController {
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
    searchController.text = "";

    clearTextfield();
  }

  final GlobalKey<FormState> addReservationDiscountformKey =
      GlobalKey<FormState>();

  TextEditingController commentsController = TextEditingController();
  TextEditingController oneamountController = TextEditingController();
  TextEditingController twoamountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  List<TextEditingController> allcommentsControllers = [];
  List<TextEditingController> formamountControllers = [];
  List<TextEditingController> formamount2Controllers = [];
  List<TextEditingController> formamountControllers2 = [];
  List<TextEditingController> formamount2Controllers2 = [];

  List<String> dropdownListDiscount = ['Select Type'];
  String dropdownvalue = 'Select Type';
  bool showLoader = false;

  List<Datum> dropdownList = [];
  List<StudentDatum> dropdownListStudent = [];
  List<SiblingListDatum> dropdownListSiblings = [];
  List<ReservationListDatum> reservationList = [];
  List<ReservationApprovalDatum> reservationFormList = [];

  String selectedId = '';
  String selectedadmissiontypeid = '';
  String? selectedukey;
  String? selectedValue;
  String? selectedValue2;
  String? siblingapplication;
  TextEditingController searchController = TextEditingController();

  void clearfields() {
    searchController.clear();
    commentsController.clear();
    oneamountController.clear();
    twoamountController.clear();
    reasonController.clear();
    selectedValue2 = null;
    selectedValue = null;
    dropdownvalue = 'Select Type';
    selectedId = '';
    selectedadmissiontypeid = '0';
  }

  sendReservationn({required BuildContext context, required bool from}) async {
    String amountText = oneamountController.text;
    String amountText2 = twoamountController.text;
    int? intValue = int.tryParse(amountText);
    log(oneamountController.text);

    if (dropdownvalue != 'Select Type') {
      if (int.parse(oneamountController.text) > 0 ||
          int.parse(twoamountController.text) > 0) {
        if (dropdownvalue == 'Application' ||
            dropdownvalue == 'Sibling' && selectedValue2 != null ||
            dropdownvalue == 'Referral' && commentsController.text.isNotEmpty) {
          //---
          await sendReservation(context,
              branchid: branchidItem,
              reason: reasonController.text,
              reservationid: selectedId.toString(),
              from: from);
          log('passed');
          //----
        } else {
          CustomSnackBar.atBottom(
            title: 'Sibling role Number',
            body: 'Select Sibling role Number',
            status: false,
          );
        }
      } else {
        CustomSnackBar.atBottom(
          title: 'Amount',
          body: 'Amount should be greater than zero',
          status: false,
        );
      }
    } else {
      CustomSnackBar.atBottom(
        title: 'Select Discount Type',
        body: 'This is required',
        status: false,
      );
    }
  }

  dynamic bid;
  dynamic branchidItem;

  Future<void> onReservationSelected({
    dynamic id,
    dynamic typeid,
    dynamic branchid,
    dynamic courseid,
    dynamic batchid,
    required BuildContext context,
  }) async {
    selectedId = id;
    selectedadmissiontypeid = typeid;
    log('batch --> ${batchid.toString()}');
    bid = batchid;
    branchidItem = branchid;
    update();
    getReservationmaxdiscountbyuserid(batchid: batchid);
    getMaxAmount();
    if (context.mounted) {
      postMaxAmountNew(
          context: context,
          reservationid: id,
          batchid: batchid,
          branchidd: branchid,
          courseid: courseid);
    }
  }

  List<MaxByUserIDDatum> maxAmountListbyuserid = [];
  Future<void> getReservationmaxdiscountbyuserid(
      {required dynamic batchid}) async {
    update();
    final response = await ReservationDiscountService()
        .getReservationmaxdiscountbyuserid(batchid: batchid);
    if (response != null) {
      if (response.data != null) {
        update();
        maxAmountListbyuserid = response.data ?? [];
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    update();
  }

  List<MaxAmtDatum> maxAmountList = [];
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
        reservationid: reservationid);

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

  Future<void> getDropdownListSibling() async {
    showLoader = true;
    final response =
        await ReservationDiscountService().getSiblingDropdownList();
    if (response != null) {
      if (response.data != null) {
        update();
        dropdownListSiblings = response.data ?? [];

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
    dropdownList.clear();
    showLoader = true;
    ReservationStudentDropdown? response =
        await ReservationDiscountService().getDropdownStudentList();
    if (response != null) {
      if (response.data != null) {
        update();
        // selectedAddType = 'Student';
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
    dropdownList.clear();
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

  Future<void> sendReservation(
    BuildContext context, {
    required String reservationid,
    required String branchid,
    required String reason,
    required bool from,
  }) async {
    CustomDialog.showDialogTransperent(context);
    await ReservationDiscountService().sendReservation(
        comments:
            selectedValue2 != null ? selectedValue2! : commentsController.text,
        discounttype: dropdownvalue,
        amount: oneamountController.text,
        reservationid: reservationid,
        context: context,
        branchid: branchid,
        reason: reason,
        batchid: bid,
        amount1: twoamountController.text,
        rasingto: raisedUserID!,
        from: from,
        type: selectedAddType);
    clearfields();
    log('checks --> ${raisedUserID.toString()}');

    update();
  }

  Future<void> getReservationList() async {
    showLoader = true;
    ReservationListModel? response =
        await ReservationDiscountService().getReservationList();
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

  Future<void> getReservationFormList({required String type}) async {
    rdsearchCtrl.clear();
    allcommentsControllers.clear();
    reservationFormList.clear();
    formamountControllers.clear();
    formamount2Controllers.clear();
    showLoader = true;
    ReservationApprovalModel? response =
        await ReservationDiscountService().getReservationFormList(type: type);
    if (response != null) {
      if (response.data != null) {
        update();
        reservationFormList = response.data ?? [];
        for (int i = 0; i < reservationFormList.length; i++) {
          allcommentsControllers.add(TextEditingController());
          formamountControllers
              .add(TextEditingController(text: reservationFormList[i].amount));
          if (type == 'Reservation') {
            formamount2Controllers.add(
                TextEditingController(text: reservationFormList[i].amount1));
          }
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
  Future<void> reservationApproveOrReject({
    required List<dynamic> data,
    required dynamic context,
    required dynamic amount,
    required dynamic amount1,
    required dynamic status,
    required dynamic comments,
    required dynamic discounttype,
    required dynamic reservationid,
    required dynamic commentreason,
    dynamic voucherid,
    required dynamic id,
  }) async {
    isResponding = true;
    update();
    await ReservationDiscountService().reservationApproveOrReject(
      context,
      amount: amount,
      status: status,
      comments: comments,
      discounttype: discounttype,
      id: id,
      amount1: amount1,
      reservationid: reservationid,
      voucherid: voucherid,
      commentreason: commentreason,
      type: selectedAddType,
    );
    log("-1211313-----------------$data");
    allcommentsControllers.clear();
    await getReservationFormList(type: selectedAddType);
    isResponding = false;
    update();
  }

  String? textFormValidationfor62(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount';
    }

    double lesserLimit;
    double enteredAmount;

    try {
      enteredAmount = double.parse(value);
      lesserLimit = double.parse(maxAmountListbyuserid[0].amount!);
    } catch (e) {
      return 'Please enter a valid number';
    }

    if (enteredAmount > lesserLimit) {
      return 'Amount cannot exceed $lesserLimit';
    }
    return null;
  }

  void clearTextfield() {
    dropdownvalue = 'Select Type';
    commentsController.clear();
    oneamountController.clear();
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

  TextEditingController rdsearchCtrl = TextEditingController();
  List<dynamic> rdsearchData = [];
  getSearchResult(String value) {
    rdsearchData.clear();
    formamountControllers.clear();
    formamount2Controllers.clear();
    allcommentsControllers.clear();
    for (var i in reservationFormList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.reservationUkey
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        ReservationApprovalDatum data = ReservationApprovalDatum(
          id: i.id,
          amount: i.amount,
          amount1: i.amount1,
          discounttype: i.discounttype,
          comments: i.comments,
          status: i.status,
          reservationUkey: i.reservationUkey,
          name: i.name,
          reservationDiscountid: i.reservationDiscountid,
          reason: i.reason,
          approvedby: i.approvedby,
          branchname: i.branchname,
          coursename: i.coursename,
          admissiontypename: i.admissiontypename,
          discounts: i.discounts,
          totalfee: i.totalfee,
          paidamount: i.paidamount,
          reservationid: i.reservationid,
          batchid: i.batchid,
          requestedTo: i.requestedTo,
          createdby: i.createdby,
        );

        update();
        rdsearchData.add(data);
        allcommentsControllers.add(TextEditingController());
        formamount2Controllers.add(TextEditingController(text: data.amount1));
        formamountControllers.add(TextEditingController(text: data.amount));
        update();
      }
    }

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
        // log(i.userid.toString());
      }
    }

    // notifyListeners();
  }

  //-------------------------------*** S - Voucher
  TextEditingController s1amountController = TextEditingController();
  TextEditingController s2amountController = TextEditingController();

  //----Validation
  // String? sVoucherValidation(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter an amount';
  //   }

  //   double availableLimit;
  //   double enteredAmount;

  //   try {
  //     enteredAmount = double.parse(value);
  //     availableLimit = double.parse(maxAmountList[0].availablelimit!);
  //   } catch (e) {
  //     return 'Please enter a valid number';
  //   }

  //   if (enteredAmount > availableLimit) {
  //     return 'Amount cannot exceed $availableLimit';
  //   }
  //   return null;
  // }

  String? sVoucherValidation(String? value) {
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
          double.parse(maxAmountListbyuserid[0].amount!)) {
        lesserLimit = double.parse(maxAmountList[0].availablelimit!);
      } else {
        lesserLimit = double.parse(maxAmountListbyuserid[0].amount!);
      }
    }

    if (enteredAmount > lesserLimit) {
      return 'Amount cannot exceed $lesserLimit';
    }
    return null;
  }

  //-----S Voucher Search
  TextEditingController sVouchersearchCtrl = TextEditingController();
  List<dynamic> sVouchersearchData = [];
  getSearchResultHR(String value) {
    sVouchersearchData.clear();
    for (var i in reservationList) {
      if (i.name.toString().toLowerCase().contains(value.toLowerCase()) ||
          i.reservationUkey
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase())) {
        ReservationListDatum data = ReservationListDatum(
          amount: i.amount,
          amount1: i.amount1,
          reservationDiscountid: i.reservationDiscountid,
          approvedby: i.approvedby,
          approvedDate: i.approvedDate,
          discounttype: i.discounttype,
          comments: i.comments,
          reason: i.reason,
          status: i.status,
          reservationUkey: i.reservationUkey,
          name: i.name,
          studentname: i.studentname,
          applicationnumber: i.applicationnumber,
          type: i.type,
          commentreason: i.commentreason,
        );
        update();
        sVouchersearchData.add(data);
        update();
      }
      // Populate formamountControllers and formamount2Controllers
    }
  }

  List<DiscountsDetailsDatum> discountDetailsList = [];

  Future<void> getDiscountsDetails(
      {required dynamic reservationid, dynamic type}) async {
    final response = await ReservationDiscountService().getDiscountsDetails(
      reservationid: reservationid,
      type: selectedAddType,
    );
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
