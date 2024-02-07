import 'dart:developer';
import 'package:attendance/model/insurance_model.dart';
import 'package:attendance/service/insurance_services.dart';
import 'package:get/get.dart';

class InsuranceGetx extends GetxController {
  @override
  Future<void> onInit() async {
    await getInsuranceList();
    super.onInit();
  }

  List<InsuranceDatum> insuranceList = [];

  bool isloader = true;

  Future<void> getInsuranceList() async {
    Insurance? response = await InsuranceService().insuranceList();
    if (response != null) {
      if (response.data != null) {
        update();
        insuranceList = response.data ?? [];
        isloader = false;
        update();
      } else {
        log('null');
      }
    } else {
      log('null');
    }
    isloader = false;
    update();
  }

  Future<void> loadresources() async {
    await getInsuranceList();
  }
}
