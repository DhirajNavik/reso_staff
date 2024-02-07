import 'dart:developer';

import 'package:attendance/model/view_application_dashboard.dart';
import 'package:attendance/service/view_dashboard_services.dart';
import 'package:get/get.dart';

class ViewDashboardController extends GetxController {
  List<DashBoardDatum> viewDashboardList = [];
  Future<void> viewDashboard() async {
    final response = await ViewDashBoardService().getDashboardDetails();
    if (response != null && response.data != null) {
      viewDashboardList.clear();
      viewDashboardList = response.data ?? [];
      log("${viewDashboardList[0].total}");
      update();
    }
    update();
  }
}
