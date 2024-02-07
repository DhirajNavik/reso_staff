import 'package:attendance/controller/model_state/outside_work_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class OutsideWorkScreen extends StatelessWidget {
  const OutsideWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<OutsideWorkGetx>(
          init: OutsideWorkGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                // await controller.loadresources();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Outside Work"),
                  Center(
                    child: CustomError.noData(),
                  )
                  // controller.showLoader == true
                  //     ? Expanded(
                  //         child: Center(
                  //           child: CircularProgressIndicator(),
                  //         ),
                  //       )
                  //     : controller.bankList.isEmpty
                  //         ? Expanded(child: Center(child: CustomError.noData()))
                  //         :
                  // AnimationLimiter(
                  //   child: Expanded(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(12.0),
                  //       child: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 6,
                  //         itemBuilder: (context, index) {
                  //           // return Text('data');
                  //           return OutsideWorkCardWidget(index: index);
                  //           // final data = controller.bankList[index];
                  //           // return BankDetailsCardWidget(
                  //           //   index: index,
                  //           //   controller: controller,
                  //           //   data: data,
                  //           // );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
