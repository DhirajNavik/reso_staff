import 'dart:developer';
import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/getotp_controller.dart';
import 'package:attendance/controller/widget_state/sharedprefs_controller.dart';
import 'package:attendance/controller/widget_state/selected_page.dart';
import 'package:attendance/routes/getRoutes.dart';
import 'package:attendance/utils/get_user_id.dart';
import 'package:attendance/utils/get_widget_state.dart';
import 'package:attendance/view/pages/applications/new_add_application_screen.dart';
import 'package:attendance/view/pages/applications/new_view_applications_screen.dart';
import 'package:attendance/view/pages/applications/ret_eligible.dart';
import 'package:attendance/view/pages/applications/view_application_dashboard.dart';
import 'package:attendance/view/pages/approve_leaves/approve_leaves.dart';
import 'package:attendance/view/pages/approve_leaves/student_screen.dart';
import 'package:attendance/view/pages/e_vouchers/e_vouchers.dart';
import 'package:attendance/view/pages/f_vouchers/f_vouchers.dart';
import 'package:attendance/view/pages/finances/bank/bank_details_screen.dart';
import 'package:attendance/view/pages/authenthication/login.dart';
import 'package:attendance/view/pages/finances/insurance.dart';
import 'package:attendance/view/pages/form_approvals/branch_transfer_form/branch_transfer_form.dart';
import 'package:attendance/view/pages/form_approvals/discount_form/discount_form.dart';
import 'package:attendance/view/pages/form_approvals/e_voucher_from_approvals.dart/e_voucher_approval.dart';
import 'package:attendance/view/pages/form_approvals/f_voucher_form_approvals.dart/f_voucher_approval.dart';
import 'package:attendance/view/pages/form_approvals/refund_form/refund_form.dart';
import 'package:attendance/view/pages/form_approvals/reimburse_hr_approval/reimburse_hr.dart';
import 'package:attendance/view/pages/form_approvals/resignation_finances/resignation_finance.dart';
import 'package:attendance/view/pages/form_approvals/resignation_hr_approval/resignation_hr.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/reservation_discount_approval.dart';
import 'package:attendance/view/pages/regularisation/absent_regularise.dart';
import 'package:attendance/view/pages/finances/payslip.dart';
import 'package:attendance/view/pages/regularisation/regularisation.dart';
import 'package:attendance/view/pages/reimbursement/reimbursement.dart';
import 'package:attendance/view/pages/form_approvals/reimbursement_form_approvals/reimbursement_form_approval.dart';
import 'package:attendance/view/pages/reservation_discount/reservation_discount.dart';
import 'package:attendance/view/pages/resignation/resignation.dart';
import 'package:attendance/view/pages/form_approvals/resignation_form/resignation_form_approval.dart';
import 'package:attendance/view/pages/s_vouchers/s_vouchers.dart';
import 'package:attendance/view/widgets/buttons.dart';
import 'package:attendance/view/widgets/clippp.dart';
import 'package:attendance/view/widgets/custom_dialog.dart';
import 'package:attendance/view/widgets/delete_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isVisibleRegularise = false;
  bool isVisibleFinances = false;
  bool isVisibleApplications = false;
  bool isVisibleApproveLeaves = false;
  bool isFormApproval = false;
  SelectedPage selectedPageCtrl = Get.put(SelectedPage());
  ProvGetnSet roleid = Get.put(ProvGetnSet());

  @override
  void initState() {
    roleid.getSavedResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userid = GetUserData().getUserId();
    log(selectedPageCtrl.stateSelectedPage.value.toString());
    dynamic drawerItems = Strings().getDrawerRoute(roleid.savedResponse);
    dynamic iconList = Strings().drawerIconList;
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Strings.primaryColor,
      child: SingleChildScrollView(
        child: Container(
          width: width / 1.5,
          color: Strings.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 38.0, bottom: 50, top: 50),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, GetRoutes.pageProfile),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          // foregroundImage:
                          //       NetworkImage(
                          //         "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-icon%2Fuser-profile-icon_750909.htm&psig=AOvVaw03wWDp7jf9LU7o-UxCMTtk&ust=1671600971251000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKDd-oK9h_wCFQAAAAAdAAAAABAE"
                          //         ),
                          radius: 60,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          GetUserData().getUserName(),
                          style: Styles.poppinsBold
                              .copyWith(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Text(
                        GetUserData().getCurrentUser().designation,
                        style:
                            Styles.poppinsRegular.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 40),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemExtent: 60,
                      itemCount: drawerItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        List newList = drawerItems[index].keys.toList();
                        var title = newList[0];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, drawerItems[index][title]);
                            setState(() {
                              WidgetState().updateSelectedPage(index);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 0),
                            child: Obx(
                              () => Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50)),
                                  color: selectedPageCtrl
                                              .stateSelectedPage.value ==
                                          -1
                                      ? Strings.primaryColor
                                      : selectedPageCtrl
                                                  .stateSelectedPage.value ==
                                              index
                                          ? Colors.white
                                          : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: ListTile(
                                    leading: Image.asset(
                                      iconList[index],
                                      width: MediaQuery.of(context).size.width /
                                          13,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                    ),
                                    title: Text(
                                      title,
                                      style: Styles.latoButtonText.copyWith(
                                          color: selectedPageCtrl
                                                      .stateSelectedPage
                                                      .value ==
                                                  index
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //--------- *FORM APPROVAL* ---------
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isFormApproval = !isFormApproval;
                        });
                        setState(() {
                          selectedPageCtrl.stateSelectedPage.value = -1;
                          print(selectedPageCtrl.stateSelectedPage.value
                              .toString());
                        });
                      },
                      child: DefaultdropdownDrawerOption(
                        visibility: isFormApproval,
                        iconList: Strings().drawerIconList2[0],
                        label: 'Form Approval',
                        padenum: -1,
                        stateSelectedPage:
                            selectedPageCtrl.stateSelectedPage.value,
                        isdrop: true,
                      ),
                    ),
                  ),
                  userid == '1' || userid == '62' || userid == '6766'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: BranchFormScreen(),
                          label: 'Branch Transfer Form',
                        )
                      : SizedBox(),
                  userid == '1' || userid == '62' || userid == '6766'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: DiscountFormScreen(),
                          label: 'Discount Approval Form',
                        )
                      : SizedBox(),
                  userid == '1' || userid == '62' || userid == '6766'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: RefundFormScreen(),
                          label: 'Refund Approval Form',
                        )
                      : SizedBox(),
                  SubWidgets(
                    visibility: isFormApproval,
                    screen: ReimbursementApprovalScreen(),
                    label: 'Reimbursement Approvals',
                  ),
                  SubWidgets(
                    visibility: isFormApproval,
                    screen: ResignationApprovalScreen(),
                    label: 'Resignation Approvals',
                  ),
                  roleid.savedResponse == '6'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: ResignationFinanceScreen(),
                          label: 'Resignation Finance\nApproval',
                        )
                      : SizedBox(),
                  // roleid.savedResponse == '6'
                  roleid.savedResponse == '14'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: ReimburseHRScreen(),
                          label: 'Reimbursement HR\nApproval',
                        )
                      : SizedBox(),
                  roleid.savedResponse == '14'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: ResignationHRScreen(),
                          label: 'Resignation HR\nApproval',
                        )
                      : SizedBox(),

                  roleid.savedResponse == '6' ||
                          userid == '6766' ||
                          userid == '62'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: ReservationApprovalScreen(),
                          label: 'S - Voucher Approvals',
                        )
                      : SizedBox(),

                  roleid.savedResponse == '6' ||
                          userid == '6766' ||
                          userid == '62'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: FVouchApprovalScreen(),
                          label: 'F - Voucher Approvals',
                        )
                      : SizedBox(),
                  roleid.savedResponse == '6' ||
                          userid == '6766' ||
                          userid == '62'
                      ? SubWidgets(
                          visibility: isFormApproval,
                          screen: EVouchApprovalScreen(),
                          label: 'E - Voucher Approvals',
                        )
                      : SizedBox(),
                  // SizedBox(height: 15.0),

                  //--------- *APPROVE LEAVES* ---------
                  roleid.savedResponse == '3' || roleid.savedResponse == '16'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isVisibleApproveLeaves =
                                    !isVisibleApproveLeaves;
                              });
                              setState(() {
                                selectedPageCtrl.stateSelectedPage.value = -2;
                                print(selectedPageCtrl.stateSelectedPage.value
                                    .toString());
                              });
                            },
                            child: DefaultdropdownDrawerOption(
                              visibility: isVisibleApproveLeaves,
                              iconList: Strings().drawerIconList2[1],
                              label: 'Approve Leaves',
                              padenum: -2,
                              stateSelectedPage:
                                  selectedPageCtrl.stateSelectedPage.value,
                              isdrop: true,
                            ),
                          ),
                        )
                      : SizedBox(),
                  SubWidgets(
                    visibility: isVisibleApproveLeaves,
                    screen: ApproveLeaves(),
                    label: 'Employee',
                  ),
                  SubWidgets(
                    visibility: isVisibleApproveLeaves,
                    screen: StudentScreen(),
                    label: 'Student',
                  ),
                  // roleid.savedResponse == '3' || roleid.savedResponse == '16'
                  SizedBox(height: 8.0),
                  //     : userid == '1' || userid == '62' || userid == '6766'
                  //         ? SizedBox(
                  //             height: 10,
                  //           )
                  //         : SizedBox(),
                  //--------- *Regularisation* ---------
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisibleRegularise = !isVisibleRegularise;
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -3;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleRegularise,
                      iconList: Strings().drawerIconList2[2],
                      label: 'Regularisation',
                      padenum: -3,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                      isdrop: true,
                    ),
                  ),
                  SubWidgets(
                    visibility: isVisibleRegularise,
                    screen: Regulaization(),
                    label: 'Late/Early Regularisation',
                  ),
                  SubWidgets(
                    visibility: isVisibleRegularise,
                    screen: AbsentorOutsideWorkScreen(),
                    label: 'Absent/Outside Work\n Regularisation',
                  ),
                  //--------- *Finances* ---------
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisibleFinances = !isVisibleFinances;
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -4;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleFinances,
                      iconList: Strings().drawerIconList2[3],
                      label: 'Finances',
                      padenum: -4,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                      isdrop: true,
                    ),
                  ),
                  SubWidgets(
                    visibility: isVisibleFinances,
                    screen: PaySlip(),
                    label: 'Pay Slip',
                  ),
                  SubWidgets(
                    visibility: isVisibleFinances,
                    screen: BankDetailsScreen(),
                    label: 'Bank Details',
                  ),
                  SubWidgets(
                    visibility: isVisibleFinances,
                    screen: InsuranceScreen(),
                    label: 'Insurance',
                  ),

                  //--------- *Applications* ---------
                  roleid.savedResponse == '1' ||
                          roleid.savedResponse == '2' ||
                          roleid.savedResponse == '3' ||
                          roleid.savedResponse == '6' ||
                          roleid.savedResponse == '15'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = !isVisibleApplications;
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -5;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[4],
                            label: 'Applications',
                            padenum: -5,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                            isdrop: true,
                          ),
                        )
                      : SizedBox(),
                  roleid.savedResponse == '15'
                      ? SubWidgets(
                          visibility: isVisibleApplications,
                          screen: RETScreen(),
                          label: 'View RET Eligible\nLeads',
                        )
                      : SizedBox(),
                  // SubWidgets(
                  //   visibility: isVisibleApplications,
                  //   screen: ViewApplication(),
                  //   label: 'Old View Applications',
                  // ),
                  SubWidgets(
                    visibility: isVisibleApplications,
                    // screen: NewViewApplicationsScreen(),

                    screen: NewApplicationDashBoard(),
                    label: 'View Applications',
                  ),
                  // SubWidgets(
                  //   visibility: isVisibleApplications,
                  //   screen: NewAddApplicationScreen(),
                  //   label: 'Add Applications',
                  // ),

                  //--------- *Reimbursement* ---------
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReimbursementScreen(),
                        ));
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -6;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleApplications,
                      iconList: Strings().drawerIconList2[5],
                      label: 'Reimbursement',
                      padenum: -6,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                      isdrop: false,
                    ),
                  ),
                  //--------- *Resignation* ---------
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResignationScreen(),
                        ));
                      });
                      setState(() {
                        selectedPageCtrl.stateSelectedPage.value = -7;
                        print(selectedPageCtrl.stateSelectedPage.value
                            .toString());
                      });
                    },
                    child: DefaultdropdownDrawerOption(
                      visibility: isVisibleApplications,
                      iconList: Strings().drawerIconList2[6],
                      label: 'Resignation',
                      padenum: -7,
                      stateSelectedPage:
                          selectedPageCtrl.stateSelectedPage.value,
                      isdrop: false,
                    ),
                  ),
                  //--------- *S - Vouchers* ---------
                  userid == '62' ||
                          userid == '6766' ||
                          userid == '38' ||
                          userid == '37' ||
                          userid == '2151' ||
                          userid == '2231'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SVouchersScreen(),
                              ));
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -8;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[6],
                            label: 'S - Vouchers',
                            padenum: -8,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                            isdrop: false,
                          ),
                        )
                      : SizedBox(),
// - - - - - - - - - - - - - - - - - - - - - - - -
                  // --------- *F - Vouchers* ---------
                  userid == '2244'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FVouchersScreen(),
                              ));
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -9;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[6],
                            label: 'F - Vouchers',
                            padenum: -9,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                            isdrop: false,
                          ),
                        )
                      : SizedBox(),

// - - - - - - - - - - - - - - - - - - - - - - - -
                  //--------- *E - Vouchers* ---------
                  userid == '11859'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EVouchersScreen(),
                              ));
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -10;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[6],
                            label: 'E - Vouchers',
                            padenum: -10,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                            isdrop: false,
                          ),
                        )
                      : SizedBox(),
// - - - - - - - - - - - - - - - - - - - - - - - -
                  //--------- *Reservation Discount* ---------
                  roleid.savedResponse == '3'
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ReservationDiscountScreen(),
                              ));
                            });
                            setState(() {
                              selectedPageCtrl.stateSelectedPage.value = -9;
                              print(selectedPageCtrl.stateSelectedPage.value
                                  .toString());
                            });
                          },
                          child: DefaultdropdownDrawerOption(
                            visibility: isVisibleApplications,
                            iconList: Strings().drawerIconList2[6],
                            label: 'S - Vouchers',
                            padenum: -7,
                            stateSelectedPage:
                                selectedPageCtrl.stateSelectedPage.value,
                            isdrop: false,
                          ),
                        )
                      : SizedBox(),
                  //-------Delete Account
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40.0,
                      top: 18.0,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Strings().drawerIconList2[7],
                          width: MediaQuery.of(context).size.width / 13,
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = false;
                            });

                            showDialog(
                              context: context,
                              builder: (context) {
                                return UserDeleteAlert(
                                    roleid: roleid.toString());
                              },
                            );
                          },
                          child: Text(
                            "Delete My Account",
                            style: Styles.latoButtonText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      right: 40,
                      top: 35,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          Strings().drawerIconList2[8],
                          width: MediaQuery.of(context).size.width / 13,
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisibleApplications = false;
                            });
                            CustomDialog.customDialog(
                                dialogChild(context), context, () {});
                          },
                          child: Text(
                            "Logout",
                            style: Styles.latoButtonText,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogChild(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Do you want to logout?"),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Buttons.redButtonReason("Logout", () {
                logoutFun(context);
              }),
              Spacer(),
              Buttons.blueButtonReason("Cancel", () {
                Navigator.pop(context);
              })
            ],
          ),
        )
      ],
    );
  }

  logoutFun(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences preffs = await SharedPreferences.getInstance();

    //Remove String
    prefs.remove("userModel");
    preffs.remove("apiRoleid");
    Strings().drawerRoutestonormal();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}

//---------------------------------------------------------------------------*****GUEST DRAWER
class CustomDrawer2 extends StatefulWidget {
  final String? roleid;
  const CustomDrawer2({super.key, this.roleid});

  @override
  State<CustomDrawer2> createState() => _CustomDrawer2State();
}

class _CustomDrawer2State extends State<CustomDrawer2> {
  SelectedPage SelectedPageCtrl = Get.put(SelectedPage());
  ProvGetnSet roleid = Get.put(ProvGetnSet());

  @override
  void initState() {
    roleid.getSavedResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('id in drawer -----> ${roleid.savedResponse.toString()}');
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 214, 211, 211),
                ),
              )),
          GetBuilder<OtpGetx>(
              init: OtpGetx(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 63, 63, 63),
                        side: const BorderSide(color: Colors.red, width: 2),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return GuestDeleteAlert(
                              roleid: roleid.savedResponse.toString(),
                            );
                          },
                        );
                      },
                      child: const Text(
                        'DELETE ACCOUNT',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 63, 63, 63),
                  side: const BorderSide(color: Colors.red, width: 2),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return LogoutAlertWidget();
                    },
                  );
                },
                child: const Text(
                  'LOG OUT',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutAlertWidget extends StatelessWidget {
  const LogoutAlertWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Do you want to logout?',
        style: TextStyle(
          color: Color.fromARGB(255, 78, 77, 77),
          letterSpacing: 0.1,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            children: [
              Buttons.redButtonReason('Logout', () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
              }),
              Spacer(),
              Buttons.blueButtonReason("Cancel", () {
                Navigator.pop(context);
              })
            ],
          ),
        )
      ],
    );
  }
}
