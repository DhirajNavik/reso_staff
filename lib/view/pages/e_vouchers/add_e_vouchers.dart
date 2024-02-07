import 'dart:developer';
import 'package:attendance/controller/model_state/e_voucher_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_create_dropdown.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_dropbutton2.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/new_custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEVouchersScreen extends StatefulWidget {
  const AddEVouchersScreen({super.key});

  @override
  State<AddEVouchersScreen> createState() => _AddEVouchersScreenState();
}

class _AddEVouchersScreenState extends State<AddEVouchersScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> EVoucherkey = GlobalKey<FormState>();
  final EVoucherGetx controller = Get.put(EVoucherGetx());
  String _select = 'Follow';
  @override
  void initState() {
    controller.getDropdownList();
    controller.dropdownvalue = 'Select Type';
    var controllerr = Get.put(EVoucherGetx());
    controllerr.employeeNameController.clear();
    controllerr.getDropdownList();
    controllerr.getRaisingTo();
    controllerr.dropdownList;
    controllerr.rasingToList = [];
    controllerr.selectedRaisedTo = null;
    controllerr.selectedEmployeeName = null;
    controller.getEmployeeList();
    // controllerr.selectedEmployeeName = '';
    super.initState();
  }

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<EVoucherGetx>(
            init: EVoucherGetx(),
            builder: (controller) {
              return Form(
                key: EVoucherkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar('Add E - Vouchers'),
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
                                  controller.eVoucherValidation(value),
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
                            Text("Employee Name", style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            customSearchDropDown(
                              title: 'Employee Name',
                              prefix: true,
                              context: context,
                              items: controller.employeeNameList,
                              textEditingController:
                                  controller.employeeNameController,
                              selectedValue: controller.selectedEmployeeName,
                              onChanged: (String? newValue) {
                                controller.selEmployeeName(newValue!);
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
                                    if (EVoucherkey.currentState!.validate()) {
                                      controller.sendEVouchers(
                                          context: context);
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
