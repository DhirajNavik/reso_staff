import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/resignation_ctrl.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ResignationFormSearchScreen extends StatefulWidget {
  final String title;
  const ResignationFormSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<ResignationFormSearchScreen> createState() =>
      _ResignationFormSearchScreenState();
}

class _ResignationFormSearchScreenState
    extends State<ResignationFormSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ResignationGetx>(
        init: ResignationGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.resignationFormsearchData.clear();
                  controller.resignationFormSearchCtrl.clear();
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
                    controller: controller.resignationFormSearchCtrl,
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
                        controller.getSearchResultResignationForm(value);
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final dataa =
                              controller.resignationFormsearchData[index];
                          return dataa.name.toLowerCase().contains(controller
                                  .resignationFormSearchCtrl.text
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
                                            CustomRichText.customRichText(
                                                "Name: ",
                                                dataa.name.toString()),
                                            CustomRichText.customRichText(
                                                "Employee Id: ",
                                                dataa.employeeid.toString()),

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
                                                    dataa.reportingApprovedBy
                                                        .toString())
                                                : SizedBox(),
                                            //-- F

                                            dataa.isReportingApproved
                                                        .toString() ==
                                                    '1'
                                                ? CustomRichText.customRichText(
                                                    "Finance Status: ",
                                                    dataa.financeApproved
                                                                .toString() ==
                                                            'null'
                                                        ? 'Pending'
                                                        : dataa.financeApproved
                                                                    .toString() ==
                                                                '1'
                                                            ? 'Approved'
                                                            : dataa.financeApproved
                                                                        .toString() ==
                                                                    '0'
                                                                ? 'Rejected'
                                                                : '')
                                                : SizedBox(),
                                            dataa.financeApproved.toString() ==
                                                    '1'
                                                ? CustomRichText.customRichText(
                                                    "Finance Approved By: ",
                                                    dataa.financeApprovedBy
                                                        .toString())
                                                : SizedBox(),
                                            //--
                                            dataa.financeApproved.toString() ==
                                                    '1'
                                                ? CustomRichText.customRichText(
                                                    "HR Status: ",
                                                    dataa.hrApproved
                                                                .toString() ==
                                                            'null'
                                                        ? 'Pending'
                                                        : dataa.hrApproved
                                                                    .toString() ==
                                                                '1'
                                                            ? 'Approved'
                                                            : dataa.hrApproved
                                                                        .toString() ==
                                                                    '0'
                                                                ? 'Rejected'
                                                                : '')
                                                : SizedBox(),
                                            dataa.financeApproved.toString() ==
                                                    '1'
                                                ? CustomRichText.customRichText(
                                                    "HR Approved By: ",
                                                    dataa.hrApprovedBy
                                                        .toString())
                                                : SizedBox(),
                                            SizedBox(height: 5.0),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .resignationFormApproveOrReject(
                                                              context: context,
                                                              resignationid:
                                                                  controller
                                                                      .resignationFormList[
                                                                          index]
                                                                      .id,
                                                              status: '1');
                                                    },
                                                    child: Text('Approve')),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    onPressed: () {
                                                      controller
                                                          .resignationFormApproveOrReject(
                                                              context: context,
                                                              resignationid:
                                                                  controller
                                                                      .resignationFormList[
                                                                          index]
                                                                      .id,
                                                              status: '0');
                                                    },
                                                    child: Text('Reject')),
                                              ],
                                            )
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
                        itemCount: controller.resignationFormsearchData.length),
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
