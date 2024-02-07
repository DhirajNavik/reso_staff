import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/add_applications_ctrl.dart';
import 'package:attendance/view/pages/applications/view_application_details_screen.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationViewSearchScreen extends StatefulWidget {
  final String title;
  const ApplicationViewSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<ApplicationViewSearchScreen> createState() =>
      _ApplicationViewSearchScreenState();
}

class _ApplicationViewSearchScreenState
    extends State<ApplicationViewSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AddAppGetx>(
        init: AddAppGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.searchViewData.clear();
                  controller.searchViewCtrl.clear();
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
                    controller: controller.searchViewCtrl,
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
                        controller.getSearchResult(value);
                      });
                    },
                  ),
                  Expanded(
                      child: controller.viewApplicationList.isEmpty
                          ? CustomError.noData()
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = controller.searchViewData[index];
                                return Card(
                                  color: Colors.brown.shade50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                            title: 'Application Id',
                                            value: data.applicationUkey!),
                                        CustomTextWidget(
                                            title: 'Student Name',
                                            value: data.name!),
                                        CustomTextWidget(
                                            title: 'Application Status',
                                            value: data.reservationstatusname!),
                                        CustomTextWidget(
                                            title: 'RET Status',
                                            value: data.retstatusname!),
                                        CustomTextWidget(
                                            title: 'Gender',
                                            value: data.gendername!),
                                        CustomTextWidget(
                                            title:
                                                'Branch - Course - Admission Type',
                                            value:
                                                '${data.branchname!} - ${data.coursename!} - ${data.admissiontypename!}'),
                                        CustomTextWidget(
                                            title: 'Mobile',
                                            value: data.mobile1!),
                                        CustomTextWidget(
                                            title: 'Comments',
                                            value: data.comments!),
                                        data.retstatus == '1' ||
                                                data.retstatus == '3'
                                            ? Center(
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .deepOrange),
                                                    onPressed: () {
                                                      controller.postRetStatus(
                                                          retstatus: data
                                                                      .retstatus ==
                                                                  '1'
                                                              ? 4
                                                              : data.retstatus ==
                                                                      '3'
                                                                  ? 5
                                                                  : 0,
                                                          applicationid: data
                                                              .applicationid
                                                              .toString());
                                                    },
                                                    child: Text(data
                                                                .retstatus ==
                                                            '1'
                                                        ? 'Mark As Postpone'
                                                        : data.retstatus == '3'
                                                            ? 'Mark As Manually Qualified'
                                                            : '')),
                                              )
                                            : SizedBox(),
                                        Center(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewApplicationDetailsScreen(
                                                    appID: "",
                                                    applicationid: controller
                                                        .viewApplicationList[
                                                            index]
                                                        .applicationid
                                                        .toString(),
                                                  ),
                                                ));
                                              },
                                              child: Text(
                                                  'View Application Details')),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox();
                              },
                              itemCount: controller.searchViewData.length))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
