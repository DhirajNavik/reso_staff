import 'package:attendance/controller/model_state/add_applications_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAddApplicationScreen extends StatefulWidget {
  const NewAddApplicationScreen({super.key});
  @override
  State<NewAddApplicationScreen> createState() =>
      _NewAddApplicationScreenState();
}

class _NewAddApplicationScreenState extends State<NewAddApplicationScreen> {
  final AddAppGetx controller = Get.put(AddAppGetx(), permanent: true);

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    controller.clearFields();
    controller.getLookUpss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          controller: scrollController,
          child: GetBuilder<AddAppGetx>(
              init: controller,
              builder: (controller) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomAppBar('Add Application'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButton('Application Details'),
                          SizedBox(width: 20),
                          buildButton('Basic Details'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildButton('Course Total Fee'),
                          SizedBox(width: 20),
                          buildButton('Preview & Create'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:
                              controller.selectedButton == "Application Details"
                                  ? applicationDetailWidget(
                                      controller: controller,
                                    )
                                  : controller.selectedButton == "Basic Details"
                                      ? basicDetailWidget(
                                          controller: controller,
                                        )
                                      : controller.selectedButton ==
                                              "Course Total Fee"
                                          ? courseTotalfeeWidget()
                                          : controller.selectedButton ==
                                                  "Preview & Create"
                                              ? previewWidget(
                                                  controller: controller)
                                              : null)
                    ]);
              }),
        ),
      ),
    );
  }

  previewWidget({
    required AddAppGetx controller,
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
    required AddAppGetx controller,
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
    required AddAppGetx controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextWidgetApplication(title: 'SELECT APPLICATION TYPE'),
        buildDropdownButton(
          label: 'Select Application Type',
          value: controller.selectedApplicationType.isEmpty
              ? null
              : controller.selectedApplicationType,
          onChanged: (String? value) {
            controller.selectedApplicationType = value!;
          },
          items: controller.applicationType
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
        TextWidgetApplication(title: 'COURSE TYPE'),
        buildDropdownButton(
          label: 'Select Course Type',
          value: controller.selectedCourseType.isEmpty
              ? null
              : controller.selectedCourseType,
          onChanged: (String? value) {
            controller.selectedCourseType = value!;
          },
          items: controller.courseType
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
                        fontSize: 14,
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
                        fontSize: 11,
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
                        fontSize: 10,
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
            child: Text('Upload Profile Picture'),
          ),
        ),
        Text(controller.image == null ? 'No File Choosen' : 'File Choosen'),
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
                    controller.selectedButton = 'Basic Details';
                  });
                },
                child: Text('Next')),
          ],
        )
      ],
    );
  }

  buildButton(String buttonText) {
    return GetBuilder<AddAppGetx>(
        init: controller,
        builder: (controller) {
          return ElevatedButton(
            onPressed: () {
              controller.selectedButtonn = buttonText;
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(150, 50),
              primary: buttonText == controller.selectedButton
                  ? Colors.blue
                  : Colors.grey,
            ),
            child: Text(buttonText),
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
