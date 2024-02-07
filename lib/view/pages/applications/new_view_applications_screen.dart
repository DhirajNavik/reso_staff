import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/add_applications_ctrl.dart';
import 'package:attendance/controller/model_state/view_application_details_ctrl.dart';
import 'package:attendance/view/pages/applications/view_application_details_screen.dart';
import 'package:attendance/view/pages/applications/view_search.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewViewApplicationsScreen extends StatefulWidget {
  final String appID;
  const NewViewApplicationsScreen({super.key, required this.appID});

  @override
  State<NewViewApplicationsScreen> createState() =>
      _NewViewApplicationsScreenState();
}

class _NewViewApplicationsScreenState extends State<NewViewApplicationsScreen> {
  final AddAppGetx controller = Get.put(AddAppGetx(), permanent: true);
  final ViewAppDetailsGetx payController =
      Get.put(ViewAppDetailsGetx(), permanent: true);

  @override
  void initState() {
    controller.viewCreatedApplications(appID: widget.appID.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: CustomDrawer(),
          body: SingleChildScrollView(
            child: GetBuilder<AddAppGetx>(
                init: controller,
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.viewCreatedApplications(
                          appID: widget.appID.toString());
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: CustomAppBar(
                                  "${widget.appID.toString()} Applications")),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: controller.searchViewCtrl,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Strings.primaryColor),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          color: Strings.primaryColor),
                                    ),
                                    hintText: 'Search',
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Strings.primaryColor,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.getSearchResult(value);
                                    });
                                  },
                                ),

                                //       InkWell(
                                //         onTap: () {
                                //           controller.searchViewData.clear();
                                //           controller.searchViewCtrl.clear();
                                //           Navigator.of(context).push(MaterialPageRoute(
                                //             builder: (context) =>
                                //                 ApplicationViewSearchScreen(
                                //                     title: 'View Applications'),
                                //           ));
                                //         },
                                //         child: TextFormField(
                                //           enabled: false,
                                //           decoration: InputDecoration(
                                //             border: OutlineInputBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(30)),
                                //             hintText: 'Search',
                                //             prefixIcon: Icon(Icons.search),
                                //             contentPadding:
                                //                 EdgeInsets.symmetric(vertical: 8),
                                //           ),
                                //         ),
                                //       ),
                                SizedBox(height: 10),
                                controller.viewApplicationList.isEmpty
                                    ? CustomError.noData()
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final data = controller.searchViewCtrl
                                                  .text.isNotEmpty
                                              ? controller.searchViewData[index]
                                              : controller
                                                  .viewApplicationList[index];
                                          return Card(
                                            color: Colors.brown.shade50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextWidget(
                                                      title: 'Application Id',
                                                      value: data
                                                          .applicationUkey!),
                                                  CustomTextWidget(
                                                      title: 'Student Name',
                                                      value: data.name!),
                                                  CustomTextWidget(
                                                      title:
                                                          'Application Status',
                                                      value: data
                                                          .reservationstatusname!),
                                                  CustomTextWidget(
                                                      title: 'RET Status',
                                                      value:
                                                          data.retstatusname!),
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
                                                  // Text(controller.savedRoleID
                                                  //     .toString()),
                                                  // Text(data.retstatus
                                                  //     .toString()),
                                                  controller.savedRoleID ==
                                                              "3" ||
                                                          controller
                                                                  .savedRoleID ==
                                                              "1"
                                                      ? data.retstatus == '1' ||
                                                              data.retstatus ==
                                                                  '3'
                                                          ? Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors
                                                                              .deepOrange),
                                                                      onPressed:
                                                                          () {
                                                                        controller.postRetStatus(
                                                                            retstatus: data.retstatus == '1'
                                                                                ? 4
                                                                                : data.retstatus == '3'
                                                                                    ? 5
                                                                                    : 0,
                                                                            applicationid: data.applicationid.toString());
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        data.retstatus ==
                                                                                '1'
                                                                            ? 'Mark As Postpone'
                                                                            : data.retstatus == '3'
                                                                                ? 'Mark As Manually Qualified'
                                                                                : '',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                            )
                                                          : SizedBox()
                                                      : SizedBox(),
                                                  Center(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green),
                                                        onPressed: () {
                                                          payController.getPaymentDetails(
                                                              data.applicationid
                                                                  .toString(),
                                                              data.batchid
                                                                  .toString());

                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewApplicationDetailsScreen(
                                                              appID: widget
                                                                  .appID
                                                                  .toString(),
                                                              applicationid: data
                                                                  .applicationid
                                                                  .toString(),
                                                            ),
                                                          ));
                                                        },
                                                        child: Text(
                                                          'View Application Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox();
                                        },
                                        itemCount: controller
                                                .searchViewCtrl.text.isNotEmpty
                                            ? controller.searchViewData.length
                                            : controller
                                                .viewApplicationList.length,
                                      )
                              ],
                            ),
                          )
                        ]),
                  );
                }),
          )),
    );
  }

  buildDropdownButton({
    required String label,
    required String? value,
    required Function onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        height: 60,
        width: 100,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
          value: value,
          hint: Text('Select'),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an option';
            }
            return null;
          },
          items: items
              .map<DropdownMenuItem<String>>((DropdownMenuItem<String> item) {
            return DropdownMenuItem<String>(
              value: item.value,
              child: item.child,
              onTap: () {
                if (item.value != value) {
                  onChanged(item.value);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
