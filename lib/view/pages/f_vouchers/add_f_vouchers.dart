import 'dart:developer';
import 'package:attendance/controller/model_state/f_voucher_ctrl.dart';
import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_create_dropdown.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_dropbutton2.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/new_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFVouchersScreen extends StatefulWidget {
  const AddFVouchersScreen({super.key});

  @override
  State<AddFVouchersScreen> createState() => _AddFVouchersScreenState();
}

class _AddFVouchersScreenState extends State<AddFVouchersScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> FVoucherkey = GlobalKey<FormState>();
  final ReimbursementGetx controller = Get.put(ReimbursementGetx());
  String _select = 'Follow';
  @override
  void initState() {
    controller.dropdownvalue = 'Select Type';

    var controllerr = Get.put(FVoucherGetx());
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
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<FVoucherGetx>(
            init: FVoucherGetx(),
            builder: (controller) {
              return Form(
                key: FVoucherkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar('Add F - Vouchers'),
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
                                controller.dropdownList.clear();
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
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                              keyboardtype: TextInputType.number,
                              validator: (value) =>
                                  controller.fVoucherValidation(value),
                              leftandrightpadding: 0.0,
                              ctrl: controller.amountController,
                              hinttext: " Amount",
                              textStyle: TextStyle(),
                              borderSide: BorderSide(
                                  color: Strings.primaryColor, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                            ),
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
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Strings.primaryColor,
                                      minimumSize: Size(150, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  onPressed: () async {
                                    if (FVoucherkey.currentState!.validate()) {
                                      controller.sendFVouchers(
                                        context: context,
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: Styles.poppinsBold
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
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
