import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/f_voucher_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_text_widget.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_textediting_widget.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/custom_snackbar.dart';
import 'package:attendance/view/widgets/discount_details_popup.dart';
import 'package:attendance/view/widgets/new_custom_dropdown.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class FVouchApprovalScreen extends StatelessWidget {
  const FVouchApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(FVoucherGetx());
      controller.getFVoucherApprovalList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<FVoucherGetx>(
          init: FVoucherGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getFVoucherApprovalList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("F - Voucher Approvals", size: 19.0),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       controller.rdsearchCtrl.clear();
                  //       controller.rdsearchData.clear();

                  //       Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => ReservationDiscountSearchScreen(
                  //             title: "Reservation Discount Approvals"),
                  //       ));
                  //     },
                  //     child: TextFormField(
                  //       enabled: false,
                  //       decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(30)),
                  //         hintText: 'Search',
                  //         prefixIcon: Icon(Icons.search),
                  //         contentPadding: EdgeInsets.symmetric(vertical: 8),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
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
                              controller.reservationList.clear();
                              controller.selectedAddType = value!;
                              if (controller.selectedAddType == 'Student') {
                                controller.getFVoucherApprovalList();
                              }
                              if (controller.selectedAddType == 'Reservation') {
                                controller.getFVoucherApprovalList();
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
                  controller.showLoader == true ||
                          controller.isResponding == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.reservationApprovalList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .reservationApprovalList.length,
                                    itemBuilder: (context, index) {
                                      final dataa = controller
                                          .reservationApprovalList[index];

                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: Card(
                                            color: Color.fromRGBO(
                                                246, 244, 238, 1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextWidget(
                                                      title: 'Name',
                                                      value: dataa.name!),
                                                  CustomTextWidget(
                                                      title: 'Application No.',
                                                      value: dataa
                                                          .reservationUkey!),
                                                  CustomTextWidget(
                                                      title: 'Discount Id',
                                                      value: dataa
                                                          .reservationDiscountid!),
                                                  CustomTextEditingWidget(
                                                      fullBox: false,
                                                      title: 'Amount',
                                                      controller: controller
                                                              .formamountControllers[
                                                          index],
                                                      hinttext: 'Amount'),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           top: 5, bottom: 5),
                                                  //   child: Stack(children: [
                                                  //     CustomTextWidget(
                                                  //         title: 'Amount',
                                                  //         value: ''),

                                                  //     //--textfield
                                                  //     SizedBox(
                                                  //       width: 100,
                                                  //       height: 40,
                                                  //       child: TextFormField(
                                                  //         onChanged: (value) {},
                                                  //         controller: controller
                                                  //                 .formamountControllers[
                                                  //             index],
                                                  //         decoration:
                                                  //             InputDecoration(
                                                  //           border:
                                                  //               OutlineInputBorder(),
                                                  //           hintText: 'Amount',
                                                  //           contentPadding:
                                                  //               EdgeInsets.all(
                                                  //                   10.0),
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //   ]),
                                                  // ),
                                                  CustomTextWidget(
                                                      title: 'Branch Name',
                                                      value: dataa.branchname!),
                                                  CustomTextWidget(
                                                      title: 'Course Name',
                                                      value: dataa.coursename!),
                                                  CustomTextWidget(
                                                      title:
                                                          'Admission Type Name',
                                                      value: dataa
                                                          .admissiontypename!),
                                                  CustomTextWidget(
                                                      title: 'Total Fee',
                                                      value: dataa.totalfee!),
                                                  Stack(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    children: [
                                                      CustomTextWidget(
                                                          title: 'Discounts',
                                                          value: dataa.discounts ==
                                                                  null
                                                              ? '0'
                                                              : dataa
                                                                  .discounts!),
                                                      SizedBox(width: 10),
                                                      dataa.discounts != null
                                                          ? InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .getDiscountsDetails(
                                                                        reservationid:
                                                                            dataa
                                                                                .reservationid)
                                                                    .then(
                                                                        (value) {
                                                                  showDiscountDetailsFPopup(
                                                                      context);
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .error_outline_outlined,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                  CustomTextWidget(
                                                      title: 'Paid Amount',
                                                      value: dataa.paidamount ??
                                                          "0"),
                                                  CustomTextWidget(
                                                      title: 'Reason',
                                                      value: dataa.reason!),
                                                  CustomTextWidget(
                                                      title: 'Created By',
                                                      value: dataa.createdby!),
                                                  dataa.status != '0'
                                                      ? CustomTextWidget(
                                                          title: 'Status',
                                                          value: dataa.status ==
                                                                  '1'
                                                              ? 'Approved'
                                                              : 'Rejected')
                                                      : SizedBox(),
                                                  dataa.status == '1'
                                                      ? CustomTextWidget(
                                                          title: 'Approved By',
                                                          value: dataa
                                                                  .approvedby ??
                                                              "")
                                                      : SizedBox(),
                                                  CustomTextEditingWidget(
                                                      title: 'Comments',
                                                      controller: controller
                                                              .allcommentsControllers[
                                                          index],
                                                      hinttext: 'Comments'),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           top: 5, bottom: 5),
                                                  //   child: Stack(children: [
                                                  //     CustomTextWidget(
                                                  //         title: 'Comments',
                                                  //         value: ''),
                                                  //     //--textfield
                                                  //     Expanded(
                                                  //       child: TextFormField(
                                                  //         onChanged: (value) {},
                                                  //         controller: controller
                                                  //                 .allcommentsControllers[
                                                  //             index],
                                                  //         decoration:
                                                  //             InputDecoration(
                                                  //           border:
                                                  //               OutlineInputBorder(),
                                                  //           hintText:
                                                  //               'comments',
                                                  //           contentPadding:
                                                  //               EdgeInsets.all(
                                                  //                   10.0),
                                                  //         ),
                                                  //       ),
                                                  //     )
                                                  //   ]),
                                                  // ),
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
                                                                  // log(controller
                                                                  //     .formamountControllers[
                                                                  //         index]
                                                                  //     .text);
                                                                  if (int.parse(controller
                                                                              .formamountControllers[
                                                                                  index]
                                                                              .text) >
                                                                          0 ||
                                                                      int.parse(controller
                                                                              .formamountControllers[index]
                                                                              .text) !=
                                                                          0) {
                                                                    controller
                                                                        .fVoucherApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      amount: controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text,
                                                                      status:
                                                                          '1',
                                                                      reason: dataa
                                                                          .reason,
                                                                      reservationid:
                                                                          dataa
                                                                              .reservationid,
                                                                      id: dataa
                                                                          .id,
                                                                      voucherid:
                                                                          dataa
                                                                              .reservationDiscountid,
                                                                      commentreason: controller
                                                                          .allcommentsControllers[
                                                                              index]
                                                                          .text,
                                                                      comments:
                                                                          dataa
                                                                              .comments,
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
                                                                            Colors.green),
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
                                                                            Colors.red),
                                                                onPressed: () {
                                                                  if (int.parse(controller
                                                                              .formamountControllers[
                                                                                  index]
                                                                              .text) >
                                                                          0 ||
                                                                      int.parse(controller
                                                                              .formamountControllers[index]
                                                                              .text) !=
                                                                          0) {
                                                                    controller
                                                                        .fVoucherApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      amount: controller
                                                                          .formamountControllers[
                                                                              index]
                                                                          .text,
                                                                      status:
                                                                          '2',
                                                                      reason: dataa
                                                                          .reason,
                                                                      reservationid:
                                                                          dataa
                                                                              .reservationid,
                                                                      id: dataa
                                                                          .id,
                                                                      commentreason: controller
                                                                          .allcommentsControllers[
                                                                              index]
                                                                          .text,
                                                                      comments:
                                                                          dataa
                                                                              .comments,
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
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
