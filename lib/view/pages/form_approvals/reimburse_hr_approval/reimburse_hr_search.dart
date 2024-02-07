import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/reimbursement_ctrl.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ReimburseHRSearchScreen extends StatefulWidget {
  final String title;
  const ReimburseHRSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<ReimburseHRSearchScreen> createState() =>
      _ReimburseHRSearchScreenState();
}

class _ReimburseHRSearchScreenState extends State<ReimburseHRSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ReimbursementGetx>(
        init: ReimbursementGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.HRsearchData.clear();
                  controller.searchCtrl.clear();
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
                    controller: controller.searchCtrl,
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
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final dataa = controller.HRsearchData[index];
                          return dataa.name!.toLowerCase().contains(controller
                                      .searchCtrl.text
                                      .toLowerCase()) ||
                                  dataa.employeeid!.toLowerCase().contains(
                                      controller.searchCtrl.text.toLowerCase())
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
                                                    dataa.reportingname
                                                        .toString())
                                                : SizedBox(),

                                            //-- HR
                                            dataa.isReportingApproved
                                                        .toString() ==
                                                    '1'
                                                ? CustomRichText.customRichText(
                                                    "HR Status: ",
                                                    dataa.isHrApproved
                                                                .toString() ==
                                                            'null'
                                                        ? 'Pending'
                                                        : dataa.isHrApproved
                                                                    .toString() ==
                                                                '1'
                                                            ? 'Approved'
                                                            : dataa.isHrApproved
                                                                        .toString() ==
                                                                    '0'
                                                                ? 'Rejected'
                                                                : '')
                                                : SizedBox(),
                                            dataa.isHrApproved.toString() == '1'
                                                ? CustomRichText.customRichText(
                                                    "HR Approved By: ",
                                                    dataa.hrname.toString())
                                                : SizedBox(),
                                            SizedBox(height: 5.0),
                                            dataa.isHrApproved.toString() ==
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
                                                                reimbursementid:
                                                                    controller
                                                                        .reimburseHRList[
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
                                                            controller.reimbursementHRApproveOrReject(
                                                                context:
                                                                    context,
                                                                reimbursementid:
                                                                    controller
                                                                        .reimburseHRList[
                                                                            index]
                                                                        .id,
                                                                status: '0');
                                                          },
                                                          child:
                                                              Text('Reject')),
                                                    ],
                                                  )
                                                : SizedBox(),
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
                        itemCount: controller.HRsearchData.length),
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
