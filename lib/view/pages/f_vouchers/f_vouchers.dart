import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/f_voucher_ctrl.dart';
import 'package:attendance/view/pages/f_vouchers/add_f_vouchers.dart';
import 'package:attendance/view/pages/f_vouchers/f_voucher_search_screen.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_text_widget.dart';
import 'package:attendance/view/pages/s_vouchers/s_voucher_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class FVouchersScreen extends StatelessWidget {
  const FVouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(FVoucherGetx());
      controller.getFVoucherList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<FVoucherGetx>(
          init: FVoucherGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getFVoucherList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("F - Vouchers"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        controller.fVouchersearchCtrl.clear();
                        controller.fVouchersearchData.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FVoucherSearchScreen(title: "F - Vouchers"),
                        ));
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Strings.primaryColor,
                              minimumSize: Size(180, 50)),
                          onPressed: () async {
                            controller.clearfields();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddFVouchersScreen(),
                            ));
                            // await controller.getDropdownListSibling();
                          },
                          child: Text(
                            'Add F-Vouchers',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  controller.showLoader == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.reservationList.isEmpty
                          // ||
                          //         GetUserData().getUserId() == '2244'
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.reservationList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.reservationList[index];
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
                                                      title: "Type",
                                                      value: dataa.type == '2'
                                                          ? 'Student'
                                                          : 'Reservation'),
                                                  CustomTextWidget(
                                                      title: "Name",
                                                      value: dataa.type == '2'
                                                          ? dataa.studentname
                                                              .toString()
                                                          : dataa.name
                                                              .toString()),
                                                  CustomTextWidget(
                                                      title: "Application No",
                                                      value: dataa.type == '2'
                                                          ? dataa
                                                              .applicationnumber
                                                              .toString()
                                                          : dataa
                                                              .reservationUkey
                                                              .toString()),
                                                  CustomTextWidget(
                                                      title:
                                                          "F-Voucher Discount ID",
                                                      value: dataa
                                                          .reservationDiscountid
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Amount",
                                                      value: dataa.amount
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Reason",
                                                      value: dataa.reason
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Status",
                                                      value: dataa.status
                                                                  .toString() ==
                                                              '0'
                                                          ? 'Pending'
                                                          : dataa.status
                                                                      .toString() ==
                                                                  '1'
                                                              ? 'Approved'
                                                              : dataa.status
                                                                          .toString() ==
                                                                      '2'
                                                                  ? 'Rejected'
                                                                  : ''),
                                                  dataa.status.toString() == '1'
                                                      ? CustomTextWidget(
                                                          title:
                                                              "Comment Reason",
                                                          value: dataa
                                                              .commentreason
                                                              .toString())
                                                      : SizedBox(),
                                                  CustomTextWidget(
                                                      title: "Requested To",
                                                      value: dataa.approvedby
                                                          .toString()),
                                                  dataa.status.toString() != '0'
                                                      ? CustomTextWidget(
                                                          title: "Approved by",
                                                          value: dataa
                                                              .approvedby
                                                              .toString())
                                                      : SizedBox(),
                                                  SizedBox(height: 5.0),
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
