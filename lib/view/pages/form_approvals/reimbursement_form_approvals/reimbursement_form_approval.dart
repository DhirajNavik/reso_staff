import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/form_approvals/reimbursement_form_approvals/reimburse_form_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReimbursementApprovalScreen extends StatelessWidget {
  const ReimbursementApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userPhone = GetUserData().getUserPhone();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ReimbursementGetx());
      controller.getReimburseFormList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ReimbursementGetx>(
          init: ReimbursementGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getReimburseFormList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Reimbursement Approvals"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        controller.reimburseFormSearchCtrl.clear();
                        controller.reimburseFormSearchData.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReimburseFormSearchScreen(
                            title: "Reimbursement Approvals",
                            userPhone: userPhone,
                          ),
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
                  controller.showLoader == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.reimburseFormList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.reimburseFormList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.reimburseFormList[index];
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
                                                      ? CustomRichText.customRichText(
                                                          "Reporting Person Approved By: ",
                                                          dataa
                                                              .reportingApprovedBy
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
                                                              "HR Approved By: ",
                                                              dataa.hrApprovedBy
                                                                  .toString())
                                                      : SizedBox(),
                                                  SizedBox(height: 5.0),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            controller.reimbursementformApproveReject(
                                                                context:
                                                                    context,
                                                                reimbursementid:
                                                                    controller
                                                                        .reimburseFormList[
                                                                            index]
                                                                        .id,
                                                                status: '1');
                                                          },
                                                          child:
                                                              Text('Approve')),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red),
                                                          onPressed: () {
                                                            controller.reimbursementformApproveReject(
                                                                context:
                                                                    context,
                                                                reimbursementid:
                                                                    controller
                                                                        .reimburseFormList[
                                                                            index]
                                                                        .id,
                                                                status: '0');
                                                          },
                                                          child:
                                                              Text('Reject')),
                                                    ],
                                                  )
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
