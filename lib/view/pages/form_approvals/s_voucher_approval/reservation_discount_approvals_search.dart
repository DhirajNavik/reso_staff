import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_text_widget.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_textediting_widget.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/discount_details_popup.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReservationDiscountSearchScreen extends StatefulWidget {
  final String title;
  const ReservationDiscountSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<ReservationDiscountSearchScreen> createState() =>
      _ReservationDiscountSearchScreenState();
}

class _ReservationDiscountSearchScreenState
    extends State<ReservationDiscountSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ReservationDiscountGetx>(
        init: ReservationDiscountGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.rdsearchCtrl.clear();
                  controller.rdsearchData.clear();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                widget.title,
              ),
              backgroundColor: Strings.primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: controller.rdsearchCtrl,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Strings.primaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        controller.getSearchResult(value);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final dataa = controller.rdsearchData[index];
                          return dataa.name.toLowerCase().contains(controller
                                      .rdsearchCtrl.text
                                      .toLowerCase()) ||
                                  dataa.reservationUkey.toLowerCase().contains(
                                      controller.rdsearchCtrl.text
                                          .toLowerCase())
                              ? AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: Card(
                                        color: Color.fromRGBO(246, 244, 238, 1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextWidget(
                                                  title: 'Name',
                                                  value: dataa.name!),
                                              CustomTextWidget(
                                                  title: 'Application No.',
                                                  value:
                                                      dataa.reservationUkey!),
                                              CustomTextWidget(
                                                  title: 'Discount Id',
                                                  value: dataa
                                                      .reservationDiscountid!),
                                              CustomTextWidget(
                                                  title: 'Discount Type',
                                                  value: dataa.discounttype
                                                      .toString()
                                                      .split(' ')[0]),

                                              dataa.status == '1' ||
                                                      dataa.status == '2'
                                                  ? CustomTextWidget(
                                                      title:
                                                          'First Year Amount',
                                                      value: dataa.amount!)
                                                  : CustomTextEditingWidget(
                                                      fullBox: false,
                                                      title:
                                                          'First Year Amount',
                                                      controller: controller
                                                              .formamountControllers[
                                                          index],
                                                      hinttext:
                                                          'First Year Amount'),
                                              controller.selectedAddType ==
                                                      'Reservation'
                                                  ? dataa.status == '1' ||
                                                          dataa.status == '2'
                                                      ? richTextApplication(
                                                          title:
                                                              'Second Year Amount',
                                                          value: dataa.amount1!)
                                                      : CustomTextEditingWidget(
                                                          fullBox: false,
                                                          title:
                                                              'Second Year Amount',
                                                          controller: controller
                                                                  .formamount2Controllers[
                                                              index],
                                                          hinttext:
                                                              'Second Year Amount')
                                                  : SizedBox(),
                                              CustomTextWidget(
                                                  title: 'Branch Name',
                                                  value: dataa.branchname!),
                                              CustomTextWidget(
                                                  title: 'Course Name',
                                                  value: dataa.coursename!),
                                              CustomTextWidget(
                                                  title: 'Admission Type Name',
                                                  value:
                                                      dataa.admissiontypename!),
                                              CustomTextWidget(
                                                  title: 'Total Fee',
                                                  value: dataa.totalfee!),
                                              //---

                                              Stack(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  CustomTextWidget(
                                                      title: 'Discounts',
                                                      value: dataa.discounts ==
                                                              null
                                                          ? '0'
                                                          : dataa.discounts!),
                                                  SizedBox(width: 10),
                                                  dataa.discounts != null
                                                      ? InkWell(
                                                          onTap: () {
                                                            controller
                                                                .getDiscountsDetails(
                                                              reservationid: dataa
                                                                  .reservationid,
                                                            )
                                                                .then((value) {
                                                              showDiscountDetailsPopup(
                                                                  context);
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .error_outline_outlined,
                                                            color: Colors.blue,
                                                          ),
                                                        )
                                                      : SizedBox()
                                                ],
                                              ),
                                              CustomTextWidget(
                                                  title: 'Paid Amount',
                                                  value:
                                                      dataa.paidamount ?? "0"),
                                              CustomTextWidget(
                                                  title: 'Reason',
                                                  value: dataa.reason!),
                                              CustomTextWidget(
                                                  title: 'Comments',
                                                  value: dataa.comments!),
                                              CustomTextWidget(
                                                  title: 'Created By',
                                                  value: dataa.createdby!),

                                              dataa.status != '0'
                                                  ? richTextApplication(
                                                      title: 'Status',
                                                      value: dataa.status == '1'
                                                          ? 'Approved'
                                                          : 'Rejected')
                                                  : SizedBox(),
                                              dataa.status == '1'
                                                  ? richTextApplication(
                                                      title: 'Approved By',
                                                      value: dataa.approvedby ??
                                                          "")
                                                  : SizedBox(),

                                              CustomTextEditingWidget(
                                                  title: 'Comments',
                                                  controller: controller
                                                          .allcommentsControllers[
                                                      index],
                                                  hinttext: 'comments'),
                                              SizedBox(height: 15),
                                              dataa.status == '0'
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              if (int.parse(controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text) >
                                                                      0 ||
                                                                  int.parse(controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text) !=
                                                                      0) {
                                                                controller
                                                                    .reservationApproveOrReject(
                                                                  data: controller
                                                                      .rdsearchData,
                                                                  amount1: controller
                                                                              .selectedAddType ==
                                                                          'Reservation'
                                                                      ? controller
                                                                          .formamount2Controllers[
                                                                              index]
                                                                          .text
                                                                      : '',
                                                                  amount: controller
                                                                      .formamountControllers[
                                                                          index]
                                                                      .text,
                                                                  comments: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .comments,
                                                                  context:
                                                                      context,
                                                                  discounttype: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .discounttype,
                                                                  status: '1',
                                                                  reservationid: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .reservationid,
                                                                  id: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .id,
                                                                  voucherid: dataa
                                                                      .reservationDiscountid,
                                                                  commentreason:
                                                                      controller
                                                                          .allcommentsControllers[
                                                                              index]
                                                                          .text,
                                                                );
                                                              } else {
                                                                CustomSnackBar.atBottom(
                                                                    title:
                                                                        'Amount',
                                                                    body:
                                                                        'Enter value greater than zero.',
                                                                    status:
                                                                        false);
                                                              }
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green),
                                                            child: Text(
                                                              'Approve',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                            onPressed: () {
                                                              if (int.parse(controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text) >
                                                                      0 ||
                                                                  int.parse(controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text) !=
                                                                      0) {
                                                                controller
                                                                    .reservationApproveOrReject(
                                                                  data: controller
                                                                      .rdsearchData,
                                                                  amount1: controller
                                                                              .selectedAddType ==
                                                                          'Reservation'
                                                                      ? controller
                                                                          .formamount2Controllers[
                                                                              index]
                                                                          .text
                                                                      : '',
                                                                  amount: controller
                                                                      .formamountControllers[
                                                                          index]
                                                                      .text,
                                                                  comments: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .comments,
                                                                  context:
                                                                      context,
                                                                  discounttype: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .discounttype,
                                                                  status: '2',
                                                                  reservationid: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .reservationid,
                                                                  id: controller
                                                                      .reservationFormList[
                                                                          index]
                                                                      .id,
                                                                  commentreason:
                                                                      controller
                                                                          .allcommentsControllers[
                                                                              index]
                                                                          .text,
                                                                );
                                                              } else {
                                                                CustomSnackBar.atBottom(
                                                                    title:
                                                                        'Amount',
                                                                    body:
                                                                        'Enter value greater than zero.',
                                                                    status:
                                                                        false);
                                                              }
                                                            },
                                                            child: Text(
                                                              'Reject',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ],
                                                    )
                                                  : SizedBox()
                                            ],
                                          ).paddingAll(10),
                                        ),
                                      )))
                              : SizedBox();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: controller.rdsearchData.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
