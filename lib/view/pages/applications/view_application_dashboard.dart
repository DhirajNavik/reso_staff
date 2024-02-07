import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/view_dashboard_controller.dart';
import 'package:attendance/view/pages/applications/new_view_applications_screen.dart';
import 'package:attendance/view/pages/form_approvals/s_voucher_approval/custom_Text_Widget.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewApplicationDashBoard extends StatefulWidget {
  const NewApplicationDashBoard({super.key});

  @override
  State<NewApplicationDashBoard> createState() =>
      _NewApplicationDashBoardScreenState();
}

class _NewApplicationDashBoardScreenState
    extends State<NewApplicationDashBoard> {
  final ViewDashboardController controller =
      Get.put(ViewDashboardController(), permanent: true);

  @override
  void initState() {
    super.initState();
    controller.viewDashboardList.clear();
    controller.viewDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ViewDashboardController>(
            init: controller,
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.viewDashboard();
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CustomAppBar("Application Dashboard")),
                      SizedBox(
                        height: 20,
                      ),
                      controller.viewDashboardList.isNotEmpty
                          ? Expanded(
                              child: Container(
                                padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: Strings.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/icon/texture1.png'),
                                    )),
                                child: GridView.count(
                                  crossAxisCount:
                                      (MediaQuery.of(context).size.width / 140)
                                          .toInt(),
                                  crossAxisSpacing: 15.0,
                                  mainAxisSpacing: 15.0,
                                  shrinkWrap: true,
                                  children: [
                                    customDBox(
                                        title: "Total",
                                        data: controller
                                            .viewDashboardList[0].total
                                            .toString()),
                                    customDBox(
                                        title: "Pending",
                                        data: controller
                                            .viewDashboardList[0].pending
                                            .toString()),
                                    customDBox(
                                        title: "Approved",
                                        data: controller
                                            .viewDashboardList[0].approved
                                            .toString()),
                                    customDBox(
                                        title: "Confirmed",
                                        data: controller
                                            .viewDashboardList[0].confirmed
                                            .toString())
                                  ],
                                ).paddingSymmetric(horizontal: 25),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                    ]),
              );
            }),
      ),
    );
  }

  Widget customDBox({required String title, required String data}) {
    return GestureDetector(
      onTap: () async {
        // final prefs = await SharedPreferences.getInstance();
        // await prefs.setString('applicationStatus', title);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NewViewApplicationsScreen(
            appID: title,
          ),
        ));
      },
      child: Container(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: Styles.poppinsRegular
                      .copyWith(fontSize: 24, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text("( $data )",
                  style: Styles.poppinsBold
                      .copyWith(color: Colors.black, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
