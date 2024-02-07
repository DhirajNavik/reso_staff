import 'package:attendance/controller/model_state/resignation_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/resignation_hr_approval/resignation_hr_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ResignationHRScreen extends StatelessWidget {
  const ResignationHRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ResignationGetx());
      controller.getResignationHRList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ResignationGetx>(
          init: ResignationGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getResignationHRList();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Resignation HR Approvals"),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                    child: InkWell(
                      onTap: () {
                        controller.searchData.clear();
                        controller.searchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResignationHRSearchScreen(
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
                      : controller.resignationHRList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.resignationHRList.length,
                                    itemBuilder: (context, index) {
                                      final dataa =
                                          controller.resignationHRList[index];
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
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Reporting Person Approved By: ",
                                                              dataa
                                                                  .reportingname
                                                                  .toString())
                                                      : SizedBox(),
                                                  //--
                                                  dataa.isReportingApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Finance Status: ",
                                                              dataa.isFinanceApproved
                                                                          .toString() ==
                                                                      'null'
                                                                  ? 'Pending'
                                                                  : dataa.isFinanceApproved
                                                                              .toString() ==
                                                                          '1'
                                                                      ? 'Approved'
                                                                      : dataa.isFinanceApproved.toString() ==
                                                                              '0'
                                                                          ? 'Rejected'
                                                                          : '')
                                                      : SizedBox(),
                                                  dataa.isFinanceApproved
                                                              .toString() ==
                                                          '1'
                                                      ? CustomRichText
                                                          .customRichText(
                                                              "Finance Approved By: ",
                                                              dataa.financename
                                                                  .toString())
                                                      : SizedBox(),
                                                  //-- HR
                                                  dataa.isFinanceApproved
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
                                                  dataa.isHrApproved
                                                                  .toString() ==
                                                              'null' &&
                                                          dataa.isFinanceApproved ==
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
                                                                  controller.resignationHRApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      resignationid: controller
                                                                          .resignationHRList[
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
                                                                  controller.resignationHRApproveOrReject(
                                                                      context:
                                                                          context,
                                                                      resignationid: controller
                                                                          .resignationHRList[
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
