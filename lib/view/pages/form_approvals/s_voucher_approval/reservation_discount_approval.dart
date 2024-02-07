import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_TextEditing_Widget.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
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

class ReservationApprovalScreen extends StatelessWidget {
  const ReservationApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ReservationDiscountGetx());
      controller.reservationFormList.clear();
      controller.getReservationFormList(type: controller.selectedAddType);
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ReservationDiscountGetx>(
          init: ReservationDiscountGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getReservationFormList(
                    type: controller.selectedAddType);
              },
              child:
                  controller.showLoader == true ||
                          controller.isResponding == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomAppBar("S - Voucher Approvals", size: 19.0),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 12.0, left: 12.0, right: 12.0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       controller.rdsearchCtrl.clear();
                            //       controller.rdsearchData.clear();

                            //       Navigator.of(context).push(MaterialPageRoute(
                            //         builder: (context) => ReservationDiscountSearchScreen(
                            //             title: "S - Voucher Approvals"),
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
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                // autofocus: true,
                                controller: controller.rdsearchCtrl,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Strings.primaryColor),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Strings.primaryColor),
                                  ),
                                  hintText: 'Search',
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Strings.primaryColor,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 8),
                                ),
                                onChanged: (value) {
                                  controller.getSearchResult(value);
                                },
                              ),
                            ),
                            controller.rdsearchCtrl.text.isNotEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: buildDropdownButton(
                                            label: 'Select Type',
                                            value: controller
                                                    .selectedAddType.isEmpty
                                                ? null
                                                : controller.selectedAddType,
                                            onChanged: (String? value) {
                                              controller.reservationFormList
                                                  .clear();
                                              controller.selectedAddType =
                                                  value!;
                                              if (controller.selectedAddType ==
                                                  'Student') {
                                                controller
                                                    .getReservationFormList(
                                                        type: 'Student');
                                              }
                                              if (controller.selectedAddType ==
                                                  'Reservation') {
                                                controller
                                                    .getReservationFormList(
                                                        type: 'Reservation');
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
                            controller.reservationFormList.isEmpty
                                ? Expanded(
                                    child: Center(child: CustomError.noData()))
                                : AnimationLimiter(
                                    child: Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                                .rdsearchCtrl.text.isNotEmpty
                                            ? controller.rdsearchData.length
                                            : controller
                                                .reservationFormList.length,
                                        itemBuilder: (context, index) {
                                          final dataa = controller
                                                  .rdsearchCtrl.text.isNotEmpty
                                              ? controller.rdsearchData[index]
                                              : controller
                                                  .reservationFormList[index];
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 375),
                                            child: SlideAnimation(
                                              verticalOffset: 50.0,
                                              child: Card(
                                                color: Color.fromRGBO(
                                                    246, 244, 238, 1),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextWidget(
                                                        title: 'Name',
                                                        value: dataa.name!),
                                                    CustomTextWidget(
                                                        title:
                                                            'Application No.',
                                                        value: dataa
                                                            .reservationUkey!),
                                                    CustomTextWidget(
                                                        title: 'Discount Id',
                                                        value: dataa
                                                            .reservationDiscountid!),
                                                    CustomTextWidget(
                                                        title: 'Discount Type',
                                                        value: dataa
                                                            .discounttype
                                                            .toString()
                                                            .split(' ')[0]),

                                                    dataa.status == '1' ||
                                                            dataa.status == '2'
                                                        ? CustomTextWidget(
                                                            title: controller
                                                                        .selectedAddType ==
                                                                    'Student'
                                                                ? 'Amount'
                                                                : 'First Year Amount',
                                                            value:
                                                                dataa.amount!)
                                                        : CustomTextEditingWidget(
                                                            fullBox: false,
                                                            title: controller
                                                                        .selectedAddType ==
                                                                    'Student'
                                                                ? 'Amount'
                                                                : 'First Year Amount',
                                                            controller: controller
                                                                    .formamountControllers[
                                                                index],
                                                            hinttext:
                                                                'First Year Amount'),
                                                    controller.selectedAddType ==
                                                            'Reservation'
                                                        ? dataa.status == '1' ||
                                                                dataa.status ==
                                                                    '2'
                                                            ? richTextApplication(
                                                                title:
                                                                    'Second Year Amount',
                                                                value: dataa
                                                                    .amount1!)
                                                            : CustomTextEditingWidget(
                                                                fullBox: false,
                                                                title:
                                                                    'Second Year Amount',
                                                                controller:
                                                                    controller
                                                                            .formamount2Controllers[
                                                                        index],
                                                                hinttext:
                                                                    'Second Year Amount')
                                                        : SizedBox(),
                                                    CustomTextWidget(
                                                        title: 'Branch Name',
                                                        value:
                                                            dataa.branchname!),
                                                    CustomTextWidget(
                                                        title: 'Course Name',
                                                        value:
                                                            dataa.coursename!),
                                                    CustomTextWidget(
                                                        title:
                                                            'Admission Type Name',
                                                        value: dataa
                                                            .admissiontypename!),
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
                                                                            .reservationid,
                                                                  )
                                                                      .then(
                                                                          (value) {
                                                                    showDiscountDetailsPopup(
                                                                        context);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .error_outline_outlined,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                    CustomTextWidget(
                                                        title: 'Paid Amount',
                                                        value:
                                                            dataa.paidamount ??
                                                                "0"),
                                                    CustomTextWidget(
                                                        title: 'Reason',
                                                        value: dataa.reason!),
                                                    CustomTextWidget(
                                                        title: 'Comments',
                                                        value: dataa.comments!),
                                                    CustomTextWidget(
                                                        title: 'Created By',
                                                        value:
                                                            dataa.createdby!),

                                                    dataa.status != '0'
                                                        ? richTextApplication(
                                                            title: 'Status',
                                                            value:
                                                                dataa.status ==
                                                                        '1'
                                                                    ? 'Approved'
                                                                    : 'Rejected')
                                                        : SizedBox(),
                                                    dataa.status == '1'
                                                        ? richTextApplication(
                                                            title:
                                                                'Approved By',
                                                            value: dataa
                                                                    .approvedby ??
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
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green),
                                                                  onPressed:
                                                                      () {
                                                                    if (int.parse(controller.formamountControllers[index].text) >
                                                                            0 ||
                                                                        int.parse(controller.formamountControllers[index].text) !=
                                                                            0) {
                                                                      controller
                                                                          .reservationApproveOrReject(
                                                                        data: controller
                                                                            .rdsearchData,
                                                                        amount1: controller.selectedAddType ==
                                                                                'Reservation'
                                                                            ? controller.formamount2Controllers[index].text
                                                                            : '',
                                                                        amount: controller
                                                                            .formamountControllers[index]
                                                                            .text,
                                                                        comments:
                                                                            dataa.comments,
                                                                        context:
                                                                            context,
                                                                        discounttype:
                                                                            dataa.discounttype,
                                                                        status:
                                                                            '1',
                                                                        reservationid:
                                                                            dataa.reservationid,
                                                                        id: dataa
                                                                            .id,
                                                                        voucherid:
                                                                            dataa.reservationDiscountid,
                                                                        commentreason: controller
                                                                            .allcommentsControllers[index]
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
                                                                    'Approve',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                              ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red),
                                                                  onPressed:
                                                                      () {
                                                                    if (int.parse(controller.formamountControllers[index].text) >
                                                                            0 ||
                                                                        int.parse(controller.formamountControllers[index].text) !=
                                                                            0) {
                                                                      controller
                                                                          .reservationApproveOrReject(
                                                                        data: controller
                                                                            .rdsearchData,
                                                                        amount1: controller.selectedAddType ==
                                                                                'Reservation'
                                                                            ? controller.formamount2Controllers[index].text
                                                                            : '',
                                                                        amount: controller
                                                                            .formamountControllers[index]
                                                                            .text,
                                                                        comments:
                                                                            dataa.comments,
                                                                        context:
                                                                            context,
                                                                        discounttype:
                                                                            dataa.discounttype,
                                                                        status:
                                                                            '2',
                                                                        reservationid:
                                                                            dataa.reservationid,
                                                                        id: dataa
                                                                            .id,
                                                                        voucherid:
                                                                            dataa.reservationDiscountid,
                                                                        commentreason: controller
                                                                            .allcommentsControllers[index]
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
                                            ),
                                          );
                                        },
                                      ).paddingAll(12),
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
