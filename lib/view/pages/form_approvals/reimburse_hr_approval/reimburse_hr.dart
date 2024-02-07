import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/reimburse_hr_approval/reimburse_hr_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReimburseHRScreen extends StatelessWidget {
  const ReimburseHRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ReimbursementGetx());
      controller.getReimburseHRList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ReimbursementGetx>(
          init: ReimbursementGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getReimburseHRList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Reimburse HR Approvals"),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                    child: InkWell(
                      onTap: () {
                        controller.HRsearchData.clear();
                        controller.searchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReimburseHRSearchScreen(
                              title: 'Resignation HR Approvals'),
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
                  controller.isLoading == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.reimburseHRList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.reimburseHRList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.reimburseHRList[index];
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
                                                      "Name: ",
                                                      dataa.name.toString()),
                                                  CustomRichText.customRichText(
                                                      "Employee Id: ",
                                                      dataa.employeeid
                                                          .toString()),

                                                  CustomRichText.customRichText(
                                                      "Reason: ",
                                                      dataa.reason.toString()),
                                                  CustomRichText.customRichText(
                                                      "Applied on: ",
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

                                                  //-- HR
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
                                                              "HR Approved By: ",
                                                              dataa.hrname
                                                                  .toString())
                                                      : SizedBox(),
                                                  SizedBox(height: 5.0),
                                                  dataa.isHrApproved
                                                                  .toString() ==
                                                              'null' &&
                                                          dataa.isReportingApproved ==
                                                              '1'
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
                                                                  controller.reimbursementHRApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      reimbursementid: controller
                                                                          .reimburseHRList[
                                                                              index]
                                                                          .id,
                                                                      status:
                                                                          '1');
                                                                },
                                                                child: Text(
                                                                    'Approve')),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red),
                                                                onPressed: () {
                                                                  controller.reimbursementHRApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      reimbursementid: controller
                                                                          .reimburseHRList[
                                                                              index]
                                                                          .id,
                                                                      status:
                                                                          '0');
                                                                },
                                                                child: Text(
                                                                    'Reject')),
                                                          ],
                                                        )
                                                      : SizedBox(),
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
