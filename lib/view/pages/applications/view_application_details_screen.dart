import 'dart:developer';

import 'package:attendance/controller/model_state/view_application_details_ctrl.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_textediting_widget.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewApplicationDetailsScreen extends StatefulWidget {
  final String appID;
  final String applicationid;
  const ViewApplicationDetailsScreen({
    super.key,
    required this.applicationid,
    required this.appID,
  });
  @override
  State<ViewApplicationDetailsScreen> createState() =>
      _ViewApplicationDetailsScreenState();
}

class _ViewApplicationDetailsScreenState
    extends State<ViewApplicationDetailsScreen> {
  final ViewAppDetailsGetx controller =
      Get.put(ViewAppDetailsGetx(), permanent: true);

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    controller.selectedButton = "Application Details";
    controller.getViewApplicationDetails(applicationid: widget.applicationid);
    controller.getRollID();

    super.initState();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // dynamic savedbatchid = prefs.getString('batchid');
    // final userud = GetUserData().getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          controller: scrollController,
          child: GetBuilder<ViewAppDetailsGetx>(
              init: controller,
              builder: (controller) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.getViewApplicationDetails(
                        applicationid: widget.applicationid);
                  },
                  child: controller.responseData == null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              CustomAppBar('View Application Details'),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextWidget(
                                              title: 'Application Id',
                                              value: controller.responseData!
                                                  .applicationUkey!),
                                          CustomTextWidget(
                                              title: 'Student Name',
                                              value: controller
                                                  .responseData!.name!),
                                          CustomTextWidget(
                                              title: 'Application Status',
                                              value: controller.responseData!
                                                  .reservationstatusname!),
                                          CustomTextWidget(
                                              title: 'RET Status',
                                              value: controller.responseData!
                                                  .retstatusname!),
                                          CustomTextWidget(
                                              title: 'Gender',
                                              value: controller
                                                  .responseData!.gendername!),
                                          CustomTextWidget(
                                              title:
                                                  'Branch - Course - Admission Type',
                                              value:
                                                  '${controller.responseData!.branchname!} - ${controller.responseData!.coursename!} - ${controller.responseData!.admissiontypename!}'),
                                          CustomTextWidget(
                                              title: 'Mobile',
                                              value: controller
                                                  .responseData!.mobile1!),
                                          CustomTextWidget(
                                              title: 'Comments',
                                              value: controller
                                                  .responseData!.comments!),
                                          SizedBox(height: 20),
                                          Text('Fee Details',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          SizedBox(height: 5),
                                          CustomTextWidget(
                                              title: controller
                                                  .responseData!.coursename
                                                  .toString(),
                                              value: controller
                                                  .responseData!.fee
                                                  .toString()),
                                          controller.responseData!.nextid != '0'
                                              ? CustomTextWidget(
                                                  title: controller
                                                      .responseData!.nextcourse
                                                      .toString(),
                                                  value: controller
                                                      .responseData!.fee1
                                                      .toString())
                                              : SizedBox(),
                                          controller.roleID == "1" ||
                                                  controller.roleID == "3" ||
                                                  controller.roleID == "6" ||
                                                  controller.roleID == "16"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Stack(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        children: [
                                                          CustomTextWidget(
                                                              heading: true,
                                                              title:
                                                                  "Payment Link",
                                                              value: controller
                                                                      .paymentList
                                                                      .isEmpty
                                                                  ? ""
                                                                  : controller
                                                                      .paymentList[
                                                                          0]
                                                                      .url
                                                                      .toString()),
                                                          IconButton(
                                                              onPressed: () {
                                                                Clipboard.setData(ClipboardData(
                                                                    text: controller
                                                                        .paymentList[
                                                                            0]
                                                                        .url
                                                                        .toString()));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Text copied to clipboard',
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              icon: Icon(Icons
                                                                  .copy_rounded))
                                                        ]),
                                                    Text(
                                                      '*Note : The Above Mentioned course fee does not include Miscellaneous Charges Which Is Rs. ${controller.responseData!.admissiontypeid == '1' ? controller.responseData!.studentkitResdential : controller.responseData!.studentkitDayscholar}/- (Student Kit). This Fee Need to be paid Separately to the stores department at the time of Reporting to avail Miscellaneous Kit which is mandatory. Additional Mess Charges @ Rs 35000 Towards (Lunch + Evening Snacks) for Semi residential Day Scholar Students.For Foundation Courses total fees need to be paid at the time of Reporting',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    CustomTextEditingWidget(
                                                        title: 'Comments',
                                                        controller: controller
                                                            .commentboxController,
                                                        hinttext: 'comments'),
                                                    TextWidgetApplication(
                                                        title:
                                                            'APPLICATION STATUS'),
                                                    buildDropdownButton(
                                                      label:
                                                          'Application Status',
                                                      value: controller
                                                                  .responseData!
                                                                  .reservationstatusname ==
                                                              ""
                                                          ? null
                                                          : controller
                                                              .responseData!
                                                              .reservationstatusname!,
                                                      onChanged:
                                                          (String? value) {
                                                        controller
                                                                .selectedApplicationStatus =
                                                            value!;
                                                      },
                                                      items: controller
                                                          .statusNameList
                                                          .toSet()
                                                          .map((item) =>
                                                              DropdownMenuItem(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                    controller.responseData!
                                                                    .retstatus ==
                                                                '2' ||
                                                            controller
                                                                    .responseData!
                                                                    .retstatus ==
                                                                '4' ||
                                                            controller
                                                                    .responseData!
                                                                    .retstatus ==
                                                                '5'
                                                        ? Container(
                                                            height: 50,
                                                            child:
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .green),
                                                                    onPressed:
                                                                        () {
                                                                      controller.confirmStatus(
                                                                          applicationid:
                                                                              widget.appID);
                                                                    },
                                                                    child: Text(
                                                                      'Update Status',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                          ).paddingOnly(top: 15)
                                                        : SizedBox()
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //-----
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     buildButton('Application Details'),
                              //     SizedBox(width: 20),
                              //     buildButton('Basic Details'),
                              //   ],
                              // ),
                              // SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     buildButton('Course Total Fee'),
                              //     SizedBox(width: 20),
                              //     buildButton('Preview & Create'),
                              //   ],
                              // ),
                              // SizedBox(height: 20),
                              // Padding(
                              //     padding: const EdgeInsets.all(12.0),
                              //     child: controller.selectedButton ==
                              //             "Application Details"
                              //         ? applicationDetailWidget(
                              //             controller: controller,
                              //           )
                              //         : controller.selectedButton ==
                              //                 "Basic Details"
                              //             ? basicDetailWidget(
                              //                 controller: controller,
                              //               )
                              //             : controller.selectedButton ==
                              //                     "Course Total Fee"
                              //                 ? courseTotalfeeWidget()
                              //                 : controller.selectedButton ==
                              //                         "Preview & Create"
                              //                     ? previewWidget(
                              //                         controller: controller)
                              //                     : null)
                            ]),
                );
              }),
        ),
      ),
    );
  }

  previewWidget({
    required ViewAppDetailsGetx controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextWidgetApplication(title: 'Application Details', notOptional: true),
        richTextApplication(
            title: 'Application Id', value: controller.selectedApplicationType),
        richTextApplication(
            title: 'Admission Type', value: controller.selectedAdmissionType),
        richTextApplication(title: 'Course', value: controller.selectedCourse),
        richTextApplication(title: 'Branch', value: controller.selectedBranch),
        richTextApplication(
            title: 'Batch', value: controller.selectedAcademicYear),
        TextWidgetApplication(title: 'Basic Details', notOptional: true),
        richTextApplication(
            title: 'Student Name',
            value: controller.studentnameController.text),
        richTextApplication(
            title: 'Aadhaar Number', value: controller.aadhaarController.text),
        richTextApplication(
            title: 'Date Of Birth', value: controller.dobController.text),
        richTextApplication(
            title: 'Mobile1', value: controller.mobileController.text),
        richTextApplication(title: 'Gender', value: controller.selectedGender),
        richTextApplication(
            title: 'Email Address', value: controller.emailController.text),
        TextWidgetApplication(title: 'Fee Details', notOptional: true),
        richTextApplication(
            title: 'Total Fee', value: controller.coursefeesController.text),
        richTextApplication(
            title: 'Comments', value: controller.commentsController.text),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    controller.selectedButton = 'Course Total Fee';
                  });
                },
                child: Text('Previous')),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  controller.createApplicationCallback(context);
                },
                child: Text('Create Application')),
          ],
        )
      ],
    );
  }

  Column courseTotalfeeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextWidgetApplication(title: 'COURSE FEES', notOptional: true),
        TextFieldApplication(
          textTitle: 'Course Fees',
          controller: controller.coursefeesController,
        ),
        TextWidgetApplication(title: 'COMMENTS', notOptional: true),
        TextFieldApplication(
          textTitle: 'Comments',
          controller: controller.commentsController,
        ),
        SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  scrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  controller.selectedButton = 'Basic Details';
                });
              },
              child: Text('Previous')),
          SizedBox(width: 10),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  scrollController.animateTo(
                    0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  controller.selectedButton = 'Preview & Create';
                });
              },
              child: Text('Next')),
        ])
      ],
    );
  }

  basicDetailWidget({
    required ViewAppDetailsGetx controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextWidgetApplication(title: 'STUDENT NAME'),
        TextFieldApplication(
          textTitle: 'Name',
          controller: controller.studentnameController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'DATE OF BIRTH'),
        InkWell(
          onTap: () {
            controller.selectDob(context);
          },
          child: TextFieldApplication(
            enabled: false,
            textTitle: 'dd/mm/yy',
            controller: controller.dobController,
            validator: (value) => controller.textFormValidation(value),
          ),
        ),
        TextWidgetApplication(title: 'FATHER NAME/GUARDIAN NAME'),
        TextFieldApplication(
          textTitle: 'Father Name',
          controller: controller.fatherController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'MOTHER NAME'),
        TextFieldApplication(
          textTitle: 'Mother Name',
          controller: controller.motherController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'SCHOOL/COLLEGE'),
        TextFieldApplication(
          textTitle: 'School Name',
          controller: controller.schoolController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'PLACE'),
        TextFieldApplication(
          textTitle: 'Place',
          controller: controller.placeController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'BOARD'),
        buildDropdownButton(
          label: 'Select Board',
          value: controller.selectedBoard.isEmpty
              ? null
              : controller.selectedBoard,
          onChanged: (String? value) {
            controller.selectedBoard = value!;
          },
          items: controller.board
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'DOOR No./STREET NAME'),
        TextFieldApplication(
          textTitle: 'Door No./Street Name',
          controller: controller.streetController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'STATE'),
        buildDropdownButton(
          label: 'Select State',
          value: controller.selectedState.isEmpty
              ? null
              : controller.selectedState,
          onChanged: (String? value) {
            controller.selectedState = value!;
          },
          items: controller.state
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'DISTRICT'),
        buildDropdownButton(
          label: 'Select District',
          value: controller.selectedDistrict.isEmpty
              ? null
              : controller.selectedDistrict,
          onChanged: (String? value) {
            controller.selectedDistrict = value!;
          },
          items: controller.district
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'CITY/TOWN'),
        TextFieldApplication(
          textTitle: 'City/Town',
          controller: controller.cityController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'VILLAGE/MANDAL'),
        TextFieldApplication(
          textTitle: 'Village/Mandal',
          controller: controller.villageController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'PIN'),
        TextFieldApplication(
          textTitle: 'Pin',
          controller: controller.pinController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'LANDMARK'),
        TextFieldApplication(
          textTitle: 'Landmark',
          controller: controller.landmarkController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'MOBILE'),
        TextFieldApplication(
          textTitle: 'Mobile',
          controller: controller.mobileController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'ALTERNATE MOBILE', notOptional: true),
        TextFieldApplication(
          textTitle: 'Mobile',
          controller: controller.alternateController,
        ),
        TextWidgetApplication(title: 'EMAIL ADDRESS', notOptional: true),
        TextFieldApplication(
          textTitle: 'Email Address',
          controller: controller.emailController,
        ),
        TextWidgetApplication(title: 'AADHAAR NUMBER'),
        TextFieldApplication(
          textTitle: 'Aadhaar Number',
          controller: controller.aadhaarController,
          validator: (value) => controller.textFormValidation(value),
        ),
        TextWidgetApplication(title: 'SELECT GENDER'),
        buildDropdownButton(
          label: 'Select Gender',
          value: controller.selectedGender.isEmpty
              ? null
              : controller.selectedGender,
          onChanged: (String? value) {
            controller.selectedGender = value!;
          },
          items: controller.gender
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    controller.selectedButton = 'Application Details';
                  });
                },
                child: Text('Previous')),
            SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    controller.selectedButton = 'Course Total Fee';
                  });
                },
                child: Text('Next')),
          ],
        )
      ],
    );
  }

  applicationDetailWidget({
    required ViewAppDetailsGetx controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TextWidgetApplication(title: 'SELECT APPLICATION TYPE'),
        // buildDropdownButton(
        //   label: 'Select Application Type',
        //   value: controller.selectedApplicationType.isEmpty
        //       ? null
        //       : controller.selectedApplicationType,
        //   onChanged: (String? value) {
        //     controller.selectedApplicationType = value!;
        //   },
        //   items: controller.applicationType
        //       .toSet()
        //       .map((item) => DropdownMenuItem(
        //             value: item,
        //             child: Text(
        //               item,
        //               style: const TextStyle(
        //                 fontSize: 14,
        //               ),
        //             ),
        //           ))
        //       .toList(),
        // ),
        // TextWidgetApplication(title: 'COURSE TYPE'),
        // buildDropdownButton(
        //   label: 'Select Course Type',
        //   value: controller.selectedCourseType.isEmpty
        //       ? null
        //       : controller.selectedCourseType,
        //   onChanged: (String? value) {
        //     controller.selectedCourseType = value!;
        //   },
        //   items: controller.courseType
        //       .toSet()
        //       .map((item) => DropdownMenuItem(
        //             value: item,
        //             child: Text(
        //               item,
        //               style: const TextStyle(
        //                 fontSize: 14,
        //               ),
        //             ),
        //           ))
        //       .toList(),
        // ),
        TextWidgetApplication(title: 'ADMISSION TYPE'),
        buildDropdownButton(
          label: 'Select Admission Type',
          value: controller.selectedAdmissionType.isEmpty
              ? null
              : controller.selectedAdmissionType,
          onChanged: (String? value) {
            controller.selectedAdmissionType = value!;
          },
          items: controller.admissionType
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'COURSE'),
        buildDropdownButton(
          label: 'Select Course',
          value: controller.selectedCourse.isEmpty
              ? null
              : controller.selectedCourse,
          onChanged: (String? value) {
            controller.selectedCourse = value!;
          },
          items: controller.course
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'SELECT ACADEMIC YEAR'),
        buildDropdownButton(
          label: 'Select Academic Year',
          value: controller.selectedAcademicYear.isEmpty
              ? null
              : controller.selectedAcademicYear,
          onChanged: (String? value) {
            controller.selectedAcademicYear = value!;
          },
          items: controller.batch
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(title: 'SELECT BRANCH'),
        buildDropdownButton(
          label: 'Select Branch',
          value: controller.selectedBranch.isEmpty
              ? null
              : controller.selectedBranch,
          onChanged: (String? value) {
            controller.selectedBranch = value!;
          },
          items: controller.branch
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
        TextWidgetApplication(
            title: 'UPLOAD PROFILE PICTURE', notOptional: true),
        SizedBox(
          child: ElevatedButton(
            onPressed: () async {
              controller.pickImage();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                fixedSize: Size(MediaQuery.of(context).size.width, 60),
                backgroundColor: Colors.green),
            child: Text(
              'Upload Profile Picture',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        Text(controller.image == null ? 'No File Choosen' : 'File Choosen'),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 3, 50),
                    backgroundColor: Colors.green),
                onPressed: () {
                  setState(() {
                    scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    controller.selectedButton = 'Basic Details';
                  });
                },
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  buildButton(String buttonText) {
    return GetBuilder<ViewAppDetailsGetx>(
        init: controller,
        builder: (controller) {
          return ElevatedButton(
            onPressed: () {
              controller.selectedButtonn = buttonText;
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              fixedSize: Size(MediaQuery.of(context).size.width / 2.2, 70),
              primary: buttonText == controller.selectedButton
                  ? Colors.blue
                  : Colors.grey,
            ),
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          );
        });
  }

  buildDropdownButton({
    required String label,
    required String? value,
    required Function onChanged,
    required List<DropdownMenuItem<String>> items,
  }) {
    return SizedBox(
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
    );
  }
}

TextWidgetApplication({required String title, bool? notOptional}) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        notOptional != true
            ? Text(
                '*',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              )
            : SizedBox(),
      ],
    ),
  );
}

TextFieldApplication({
  required String textTitle,
  required TextEditingController controller,
  String? Function(String?)? validator,
  bool? enabled,
}) {
  return TextFormField(
    enabled: enabled,
    controller: controller,
    decoration: InputDecoration(
      labelText: textTitle,
      border: OutlineInputBorder(),
    ),
    validator: validator,
  );
}

// richTextApplication(
//     {Color? color, required String title, required String value}) {
//   return RichText(
//     text: TextSpan(
//       children: <TextSpan>[
//         TextSpan(
//           text: '$title: ',
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               // color:  Colors.grey.shade600,
//               color: Colors.black),
//         ),
//         TextSpan(
//           text: value,
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ],
//     ),
//   );
// }
