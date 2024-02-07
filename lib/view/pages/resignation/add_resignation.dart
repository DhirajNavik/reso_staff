import 'dart:developer';
import 'package:attendance/controller/model_state/resignation_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/custom_textformfield.dart';
import 'package:attendance/view/widgets/datePickerDialog.dart';
import 'package:attendance/view/widgets/datepicker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddResignationScreen extends StatelessWidget {
  AddResignationScreen({super.key});
  final GlobalKey<FormState> resignationkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: GetBuilder<ResignationGetx>(
            init: ResignationGetx(),
            builder: (controller) {
              return Form(
                key: resignationkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar('Add Resignation'),
                    controller.showLoader
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20.0),
                                  Text("Last Working Day",
                                      style: Styles.robotoTextFieldStyle),
                                  SizedBox(height: 10.0),
                                  DatePickerWidget(
                                    textController:
                                        controller.lastWorkingDayController,
                                    onTap: () async {
                                      log("${controller.intialDate}--//");
                                      CustomDatePickerDialog(
                                              intialDate: DateTime.now())
                                          .datePickerSingle(context,
                                              controller.nullCtrl, () {},
                                              untiltoday: false)
                                          .then((value) {
                                        if (value != null) {
                                          controller.lastWorkingDayController
                                                  .text =
                                              value.toString().split(" ")[0];
                                          controller.intialDate = value;
                                        }
                                      });
                                    },
                                    hintText: 'Select Day',
                                    iconName: Icons.timer_sharp,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text("Reason",
                                      style: Styles.robotoTextFieldStyle),
                                  SizedBox(height: 10.0),
                                  WidgetTextFormField(
                                    maxLines: true,
                                    textStyle: TextStyle(),
                                    leftandrightpadding: 0.0,
                                    keyboardtype: TextInputType.multiline,
                                    ctrl: controller.reasonController,
                                    hinttext:
                                        'Reason for resignation ${Strings.filler}',
                                    validator: (value) =>
                                        controller.textFormValidation(value),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    borderSide: BorderSide(
                                        color: Strings.primaryColor, width: 2),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Strings.primaryColor,
                                            minimumSize: Size(150, 50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        onPressed: () async {
                                          if (controller
                                              .lastWorkingDayController
                                              .text
                                              .isNotEmpty) {
                                            if (resignationkey.currentState!
                                                .validate()) {
                                              {
                                                await controller
                                                    .sendResignation(context);
                                                controller.clearTextfield();
                                              }
                                            }
                                          } else {
                                            CustomSnackBar.atBottom(
                                                title: 'Select Date',
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
