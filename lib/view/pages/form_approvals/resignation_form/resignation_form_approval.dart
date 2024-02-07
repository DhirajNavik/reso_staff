import 'package:attendance/controller/model_state/resignation_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/resignation_form/resignation_form_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ResignationApprovalScreen extends StatelessWidget {
  const ResignationApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ResignationGetx());
      controller.getResignationFormList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ResignationGetx>(
          init: ResignationGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getResignationFormList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Resignation Approvals"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        controller.resignationFormsearchData.clear();
                        controller.resignationFormSearchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResignationFormSearchScreen(
                              title: "Resignation Approvals"),
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
                      : controller.resignationFormList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.resignationFormList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.resignationFormList[index];
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
                                                      "Last Working Day: ",
                                                      dataa.lastWorkingDay
                                                          .toString()
                                                          .split(' ')[0]),
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
                                                  //-- F

                                                  dataa.isReportingApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Finance Status: ",
                                                              dataa.financeApproved
                                                                          .toString() ==
                                                                      'null'
                                                                  ? 'Pending'
                                                                  : dataa.financeApproved
                                                                              .toString() ==
                                                                          '1'
                                                                      ? 'Approved'
                                                                      : dataa.financeApproved.toString() ==
                                                                              '0'
                                                                          ? 'Rejected'
                                                                          : '')
                                                      : SizedBox(),
                                                  dataa.financeApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText.customRichText(
                                                          "Finance Approved By: ",
                                                          dataa
                                                              .financeApprovedBy
                                                              .toString())
                                                      : SizedBox(),
                                                  //--
                                                  dataa.financeApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "HR Status: ",
                                                              dataa.hrApproved
                                                                          .toString() ==
                                                                      'null'
                                                                  ? 'Pending'
                                                                  : dataa.hrApproved
                                                                              .toString() ==
                                                                          '1'
                                                                      ? 'Approved'
                                                                      : dataa.hrApproved.toString() ==
                                                                              '0'
                                                                          ? 'Rejected'
                                                                          : '')
                                                      : SizedBox(),
                                                  dataa.financeApproved
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
                                                            controller.resignationFormApproveOrReject(
                                                                context:
                                                                    context,
                                                                resignationid:
                                                                    controller
                                                                        .resignationFormList[
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
                                                            controller.resignationFormApproveOrReject(
                                                                context:
                                                                    context,
                                                                resignationid:
                                                                    controller
                                                                        .resignationFormList[
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
