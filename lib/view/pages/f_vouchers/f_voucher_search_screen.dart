import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/f_voucher_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_text_widget.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class FVoucherSearchScreen extends StatefulWidget {
  final String title;
  const FVoucherSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<FVoucherSearchScreen> createState() => _FVoucherSearchScreenState();
}

class _FVoucherSearchScreenState extends State<FVoucherSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<FVoucherGetx>(
        init: FVoucherGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.fVouchersearchCtrl.clear();
                  controller.fVouchersearchData.clear();
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
                    controller: controller.fVouchersearchCtrl,
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
                        controller.getSearchResultHR(value);
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final dataa = controller.fVouchersearchData[index];
                          return dataa.name!.toLowerCase().contains(controller
                                      .fVouchersearchCtrl.text
                                      .toLowerCase()) ||
                                  dataa.reservationUkey!.toLowerCase().contains(
                                      controller.fVouchersearchCtrl.text
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
                                                title: "Type",
                                                value: dataa.type == '2'
                                                    ? 'Student'
                                                    : 'Reservation'),
                                            CustomTextWidget(
                                                title: "Name",
                                                value: dataa.type == '2'
                                                    ? dataa.studentname
                                                        .toString()
                                                    : dataa.name.toString()),
                                            CustomTextWidget(
                                                title: "Application No",
                                                value: dataa.type == '2'
                                                    ? dataa.applicationnumber
                                                        .toString()
                                                    : dataa.reservationUkey
                                                        .toString()),
                                            CustomTextWidget(
                                                title: "F-Voucher Discount ID",
                                                value: dataa
                                                    .reservationDiscountid
                                                    .toString()),
                                            CustomRichText.customRichText(
                                                "Discount Type: ",
                                                dataa.discounttype.toString()),
                                            CustomTextWidget(
                                                title: "First Year Amount: ",
                                                value: dataa.amount.toString()),
                                            CustomTextWidget(
                                                title: "Second Year Amount: ",
                                                value:
                                                    dataa.amount1.toString()),
                                            CustomTextWidget(
                                                title: "Comments: ",
                                                value:
                                                    dataa.comments.toString()),
                                            CustomTextWidget(
                                                title: "Reason",
                                                value: dataa.reason.toString()),
                                            CustomTextWidget(
                                                title: "Status",
                                                value: dataa.status
                                                            .toString() ==
                                                        '0'
                                                    ? 'Pending'
                                                    : dataa.status.toString() ==
                                                            '1'
                                                        ? 'Approved'
                                                        : dataa.status
                                                                    .toString() ==
                                                                '2'
                                                            ? 'Rejected'
                                                            : ''),
                                            dataa.status.toString() == '1'
                                                ? CustomTextWidget(
                                                    title: "Comment Reason",
                                                    value: dataa.commentreason
                                                        .toString())
                                                : SizedBox(),
                                            CustomTextWidget(
                                                title: "Requested To",
                                                value: dataa.approvedby
                                                    .toString()),
                                            dataa.status.toString() != '0'
                                                ? CustomTextWidget(
                                                    title: "Approved by",
                                                    value: dataa.approvedby
                                                        .toString())
                                                : SizedBox(),
                                            SizedBox(height: 5.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: controller.fVouchersearchData.length),
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
