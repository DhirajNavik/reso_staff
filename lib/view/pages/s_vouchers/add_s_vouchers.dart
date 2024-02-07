import 'dart:developer';
import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_create_dropdown.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_dropbutton2.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/new_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSVouchersScreen extends StatefulWidget {
  const AddSVouchersScreen({super.key});

  @override
  State<AddSVouchersScreen> createState() => _AddSVouchersScreenState();
}

class _AddSVouchersScreenState extends State<AddSVouchersScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> SVoucherkey = GlobalKey<FormState>();
  final ReimbursementGetx controller = Get.put(ReimbursementGetx());
  String _select = 'Follow';
  @override
  void initState() {
    controller.dropdownvalue = 'Select Type';

    var controllerr = Get.put(ReservationDiscountGetx());
    controllerr.getDropdownList();
    controllerr.getRaisingTo();
    controllerr.dropdownList;
    controllerr.rasingToList = [];
    controllerr.selectedRaisedTo = null;
    super.initState();
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var userid = GetUserData().getUserId();
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<ReservationDiscountGetx>(
            init: ReservationDiscountGetx(),
            builder: (controller) {
              return Form(
                key: SVoucherkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar('Add S - Vouchers'),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: buildDropdownButton(
                              label: 'Select Type',
                              value: controller.selectedAddType.isEmpty
                                  ? null
                                  : controller.selectedAddType,
                              onChanged: (String? value) {
                                controller.selectedAddType = value!;
                                controller.selectedValue = '';
                                if (controller.selectedAddType == 'Student') {
                                  controller.getDropdownListStudent();
                                }
                                if (controller.selectedAddType ==
                                    'Reservation') {
                                  controller.getDropdownList();
                                }
                              },
                              items: controller.board
                                  .toSet()
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.selectedAddType == 'Reservation'
                                ? Text("Select ReservationNo/Name",
                                    style: Styles.poppinsRegular)
                                : Text("Select ApplicationNo/Name",
                                    style: Styles.poppinsRegular),
                            SizedBox(height: 15.0),
                            customDropButton2(
                              context: context,
                              controller: controller,
                              items: controller.dropdownList
                                  .map((item) => DropdownMenuItem<String>(
                                        onTap: () {
                                          controller.onReservationSelected(
                                            id: item.reservationid,
                                            typeid: item.admissiontypeid,
                                            context: context,
                                            batchid: item.batchid,
                                            branchid: item.branchid,
                                            courseid: item.courseid,
                                          );
                                          log('branchid --> ${item.branchid}');
                                        },
                                        value: item.reservationUkey,
                                        child: Text(
                                          '${item.name} (${item.reservationUkey})',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: controller.selectedValue == null ||
                                      controller.selectedValue!.isEmpty
                                  ? null
                                  : controller.selectedValue,
                              onChanged: (String? value) {
                                controller.onReservationchanged(value!);
                              },
                              textcontroller: controller.searchController,
                            ),
                            SizedBox(height: 15.0),
                            Text("Amount", style: Styles.poppinsRegular),
                            //  controller.selectedValue != null &&
                            //         controller.newmaxAmountList.isNotEmpty &&
                            //         controller.maxAmountList.isNotEmpty
                            //     ? Text(
                            //         'Max amount = ${controller.newmaxAmountList[0].amount.toString()} (Available limit is ${controller.maxAmountList[0].availablelimit})',
                            //         style: TextStyle(
                            //             fontSize: 10,
                            //             color:
                            //                 Color.fromARGB(255, 190, 24, 12)))
                            //     : SizedBox(),

                            userid == '2231' ||
                                    userid == '2151' ||
                                    userid == '37' ||
                                    userid == '38'
                                ? controller.selectedValue != null &&
                                        controller
                                            .maxAmountListbyuserid.isNotEmpty &&
                                        controller.maxAmountList.isNotEmpty
                                    ? Text(
                                        'Max amount = ${controller.maxAmountListbyuserid[0].amount.toString()} (Available limit is ${controller.maxAmountList[0].availablelimit})',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(
                                                255, 190, 24, 12)))
                                    : SizedBox()
                                : SizedBox(),
                            // controller.selectedAddType == 'Reservation' ||
                            //         controller.selectedAddType == 'Student'
                            //     ?
                            userid == '62' || userid == '6766'
                                ?
                                // controller.newmaxAmountList.isNotEmpty &&
                                //         controller.newmaxAmountList[0]
                                //                 .count! >
                                //             0
                                //     ? Text(
                                //         "Previous voucher request is pending for approval.",
                                //         style: TextStyle(
                                //             fontSize: 10,
                                //             color: Color.fromARGB(
                                //                 255, 190, 24, 12)))
                                //     :
                                controller.selectedValue != null &&
                                        controller
                                            .maxAmountListbyuserid.isNotEmpty
                                    ? Text(
                                        'Max amount is ${controller.maxAmountListbyuserid[0].amount}',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Color.fromARGB(
                                                255, 190, 24, 12)))
                                    : SizedBox()
                                : SizedBox(),
                            // : SizedBox(),

                            SizedBox(height: 10.0),
                            userid == '2231' ||
                                    userid == '2151' ||
                                    userid == '37' ||
                                    userid == '38'
                                ? WidgetTextFormField(
                                    keyboardtype: TextInputType.number,
                                    validator: (value) =>
                                        controller.sVoucherValidation(value),
                                    leftandrightpadding: 0.0,
                                    ctrl: controller.oneamountController,
                                    hinttext: controller.selectedAddType ==
                                            'Reservation'
                                        ? "First Year Amount"
                                        : "Amount",
                                    textStyle: TextStyle(),
                                    borderSide: BorderSide(
                                        color: Strings.primaryColor, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  )
                                : WidgetTextFormField(
                                    keyboardtype: TextInputType.number,
                                    validator: (value) => controller
                                        .textFormValidationfor62(value),
                                    leftandrightpadding: 0.0,
                                    ctrl: controller.oneamountController,
                                    hinttext: "First Year Amount",
                                    textStyle: TextStyle(),
                                    borderSide: BorderSide(
                                        color: Strings.primaryColor, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                            controller.selectedAddType == 'Reservation'
                                ? userid == '2231' ||
                                        userid == '2151' ||
                                        userid == '37' ||
                                        userid == '38'
                                    ? WidgetTextFormField(
                                        keyboardtype: TextInputType.number,
                                        validator: (value) => controller
                                            .sVoucherValidation(value),
                                        leftandrightpadding: 0.0,
                                        ctrl: controller.twoamountController,
                                        hinttext: "Second Year Amount",
                                        textStyle: TextStyle(),
                                        borderSide: BorderSide(
                                            color: Strings.primaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      )
                                    : WidgetTextFormField(
                                        keyboardtype: TextInputType.number,
                                        validator: (value) => controller
                                            .textFormValidationfor62(value),
                                        leftandrightpadding: 0.0,
                                        ctrl: controller.twoamountController,
                                        hinttext: "Second Years Amount",
                                        textStyle: TextStyle(),
                                        borderSide: BorderSide(
                                            color: Strings.primaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                      )
                                : SizedBox(),
                            Text("Request To", style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            customSearchDropDown(
                              title: 'Request To',
                              prefix: true,
                              context: context,
                              items: controller.rasingToNameList,
                              textEditingController:
                                  controller.raisingToController,
                              selectedValue: controller.selectedRaisedTo,
                              onChanged: (String? newValue) {
                                controller.raisedToValue(newValue!);
                              },
                              errorText: 'Please select',
                            ),
                            SizedBox(height: 20.0),
                            Text("Discount Type", style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: 60,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Strings.primaryColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  value: controller.dropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: controller.dropdownListDiscount
                                      .map((String item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            color: item == 'Select Type'
                                                ? Colors.grey
                                                : Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) async {
                                    if (newValue != 'Select type') {
                                      setState(() {
                                        controller.dropdownvalue =
                                            newValue!.toString();
                                      });
                                    } else {
                                      controller.dropdownvalue = 'null';
                                    }
                                  },
                                  itemHeight: 60,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            controller.dropdownvalue != 'Select Type' &&
                                    controller.dropdownvalue != 'Application'
                                ? Text(
                                    controller.dropdownvalue == 'Sibling'
                                        ? "Sibling role Number"
                                        : 'Referral Name',
                                    style: Styles.poppinsRegular)
                                : SizedBox(),
                            controller.dropdownvalue != 'Select Type'
                                ? SizedBox(height: 10.0)
                                : SizedBox(),
                            controller.dropdownvalue != 'Select Type' &&
                                    controller.dropdownvalue == "Referral"
                                ? WidgetTextFormField(
                                    validator: (value) =>
                                        controller.textFormValidation(value),
                                    leftandrightpadding: 0.0,
                                    ctrl: controller.commentsController,
                                    hinttext:
                                        controller.dropdownvalue == 'Sibling'
                                            ? "Enter sibling role number"
                                            : 'Enter referral name',
                                    textStyle: TextStyle(),
                                    borderSide: BorderSide(
                                        color: Strings.primaryColor, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)))
                                : SizedBox(),
                            controller.dropdownvalue != 'Select Type' &&
                                    controller.dropdownvalue == "Sibling"
                                ? customDropButton2(
                                    context: context,
                                    controller: controller,
                                    items: controller.dropdownListSiblings
                                        .map((item) => DropdownMenuItem<String>(
                                              onTap: () {
                                                controller.onSiblingsSelected(
                                                    applicationNumber: item
                                                        .applicationnumber
                                                        .toString());
                                              },
                                              value: item.applicationnumber,
                                              child: Text(
                                                '${item.name} (${item.applicationnumber})',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectedValue2,
                                    onChanged: (String? value) {
                                      controller.onSiblingschanged(value!);
                                    },
                                    textcontroller:
                                        controller.commentsController,
                                  )
                                : SizedBox(),
                            SizedBox(height: 15.0),
                            Text('Reason', style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.reasonController,
                                hinttext: 'Reason',
                                textStyle: TextStyle(),
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            SizedBox(height: 10.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // controller.newmaxAmountList.isEmpty ||
                                //         controller
                                //                 .newmaxAmountList.isNotEmpty &&
                                //             controller.newmaxAmountList[0]
                                //                     .count! ==
                                //                 0
                                //     ?
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Strings.primaryColor,
                                      minimumSize: Size(150, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () async {
                                    if (SVoucherkey.currentState!.validate()) {
                                      controller.sendReservationn(
                                        context: context,
                                        from: true,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: Styles.poppinsBold
                                        .copyWith(fontSize: 18),
                                  ),
                                )
                                // : ElevatedButton(
                                //     style: ElevatedButton.styleFrom(
                                //         minimumSize: Size(150, 50),
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(50))),
                                //     onPressed: null,
                                //     child: Text(
                                //       "Submit",
                                //       style: Styles.poppinsBold
                                //           .copyWith(fontSize: 18),
                                //     ),
                                //   )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
