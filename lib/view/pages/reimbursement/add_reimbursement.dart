import 'dart:developer';

import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReimbursementScreen extends StatefulWidget {
  const AddReimbursementScreen({super.key});

  @override
  State<AddReimbursementScreen> createState() => _AddReimbursementScreenState();
}

class _AddReimbursementScreenState extends State<AddReimbursementScreen> {
  final GlobalKey<FormState> reimbursementkey = GlobalKey<FormState>();
  final ReimbursementGetx controller = Get.put(ReimbursementGetx());

  @override
  void initState() {
    controller.dropdownvalue = 'Select Type';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<ReimbursementGetx>(
            init: ReimbursementGetx(),
            builder: (controller) {
              return Form(
                key: reimbursementkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar('Add Reimbursement'),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Text("Category", style: Styles.poppinsRegular),
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
                                  items: controller.dropdownList
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
                                  onChanged: (newValue) {
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
                            Text("Amount", style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                                validator: (value) =>
                                    controller.textFormValidation(value),
                                leftandrightpadding: 0.0,
                                ctrl: controller.amountController,
                                hinttext: "Amount",
                                textStyle: TextStyle(),
                                borderSide: BorderSide(
                                    color: Strings.primaryColor, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0))),
                            Text("Reason", style: Styles.poppinsRegular),
                            SizedBox(height: 10.0),
                            WidgetTextFormField(
                              maxLines: true,
                              textStyle: TextStyle(),
                              leftandrightpadding: 0.0,
                              keyboardtype: TextInputType.multiline,
                              ctrl: controller.reasonController,
                              hinttext:
                                  'Enter the reason ${Strings.filler}',
                              validator: (value) =>
                                  controller.textFormValidation(value),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)),
                              borderSide: BorderSide(
                                  color: Strings.primaryColor, width: 2),
                            ),
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
                                    log(controller.dropdownvalue);
                                    if (controller.dropdownvalue !=
                                        'Select Type') {
                                      if (reimbursementkey.currentState!
                                          .validate()) {
                                        await controller
                                            .sendReimbursement(context);
                                        controller.clearTextfield();
                                      }
                                    } else {
                                      CustomSnackBar.atBottom(
                                          title: 'Select Category',
                                          body: 'This is required',
                                          status: false);
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
