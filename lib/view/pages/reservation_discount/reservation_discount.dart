import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
import 'package:attendance/view/pages/reservation_discount/add_reservation_discount.dart';
import 'package:attendance/view/pages/s_vouchers/s_voucher_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReservationDiscountScreen extends StatelessWidget {
  const ReservationDiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ReservationDiscountGetx());
      controller.getReservationList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ReservationDiscountGetx>(
          init: ReservationDiscountGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getReservationList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("S - Vouchers"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        controller.sVouchersearchCtrl.clear();
                        controller.sVouchersearchData.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SVoucherSearchScreen(title: "S - Vouchers"),
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
                              builder: (context) =>
                                  AddReservationDiscountScreen(),
                            ));
                            await controller.getDropdownListSibling();
                          },
                          child: Text(
                            'Add S - Vouchers',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
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
                                                      title: "Type ",
                                                      value: dataa.type == '1'
                                                          ? 'Reservation'
                                                          : 'Student'),
                                                  CustomTextWidget(
                                                      title: "Name ",
                                                      value: dataa.type == '2'
                                                          ? dataa.studentname
                                                              .toString()
                                                          : dataa.name
                                                              .toString()),
                                                  CustomTextWidget(
                                                      title: "Application No ",
                                                      value: dataa.type == '2'
                                                          ? dataa
                                                              .applicationnumber
                                                              .toString()
                                                          : dataa
                                                              .reservationUkey
                                                              .toString()),
                                                  CustomTextWidget(
                                                      title: "Discount Id: ",
                                                      value: dataa
                                                          .reservationDiscountid
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Discount Type: ",
                                                      value: dataa.discounttype
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: dataa.type == '2'
                                                          ? "Amount: "
                                                          : "First Year Amount: ",
                                                      value: dataa.amount
                                                          .toString()),
                                                  dataa.type == '1'
                                                      ? CustomTextWidget(
                                                          title:
                                                              "Second Year Amount: ",
                                                          value: dataa.amount1
                                                              .toString())
                                                      : SizedBox(),
                                                  CustomTextWidget(
                                                      title: "Comments: ",
                                                      value: dataa.comments
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Reason: ",
                                                      value: dataa.reason
                                                          .toString()),
                                                  CustomTextWidget(
                                                      title: "Status: ",
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
                                                          title: "Reason: ",
                                                          value: dataa
                                                              .commentreason
                                                              .toString())
                                                      : SizedBox(),
                                                  CustomTextWidget(
                                                      title: "Requested To: ",
                                                      value: dataa.approvedby
                                                          .toString()),
                                                  dataa.status.toString() != '0'
                                                      ? CustomTextWidget(
                                                          title:
                                                              "Approved by: ",
                                                          value: dataa
                                                              .approvedby
                                                              .toString())
                                                      : SizedBox(),
                                                  dataa.status.toString() == '1'
                                                      ? CustomTextWidget(
                                                          title:
                                                              "Approved Date: ",
                                                          value: dataa
                                                              .approvedDate
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
