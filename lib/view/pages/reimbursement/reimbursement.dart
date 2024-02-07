import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/view/pages/reimbursement/add_reimbursement.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReimbursementScreen extends StatelessWidget {
  const ReimbursementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ReimbursementGetx());
      controller.getReimburseList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ReimbursementGetx>(
          init: ReimbursementGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getReimburseList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Reimbursement"),
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddReimbursementScreen(),
                            ));
                          },
                          child: Text(
                            'Add Reimbursement',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  controller.isLoading == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.reimburseList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.reimburseList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.reimburseList[index];
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
                                                  CustomRichText.customRichText(
                                                      "Category: ",
                                                      dataa.category
                                                          .toString()),
                                                  CustomRichText.customRichText(
                                                      "Amount: ",
                                                      dataa.amount.toString()),
                                                  CustomRichText.customRichText(
                                                      "Reason: ",
                                                      dataa.reason.toString()),
                                                  CustomRichText.customRichText(
                                                      "Applied On: ",
                                                      dataa.date.toString()),
                                                  CustomRichText.customRichText(
                                                      "Reporting Person Status: ",
                                                      dataa.isReportingApproved
                                                                  .toString() ==
                                                              'null'
                                                          ? 'Pending'
                                                          : dataa.isReportingApproved
                                                                      .toString() ==
                                                                  '1'
                                                              ? 'Approved'
                                                              : dataa.isReportingApproved
                                                                          .toString() ==
                                                                      '0'
                                                                  ? 'Rejected'
                                                                  : ''),
                                                  dataa.isReportingApproved
                                                                  .toString() ==
                                                              '1' ||
                                                          dataa.isReportingApproved
                                                                  .toString() ==
                                                              '0'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Reporting Person Approved By: ",
                                                              dataa
                                                                  .reportingname
                                                                  .toString())
                                                      : SizedBox(),
                                                  dataa.isReportingApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "HR Status: ",
                                                              dataa.isHrApproved
                                                                          .toString() ==
                                                                      'null'
                                                                  ? 'Pending'
                                                                  : dataa.isHrApproved
                                                                              .toString() ==
                                                                          '1'
                                                                      ? 'Approved'
                                                                      : dataa.isHrApproved.toString() ==
                                                                              '0'
                                                                          ? 'Rejected'
                                                                          : '')
                                                      : SizedBox(),
                                                  dataa.isHrApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Approved By: ",
                                                              dataa.hrname
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
