import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/Insurance_ctrl.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<InsuranceGetx>(
          init: InsuranceGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.loadresources();
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar("Insurance"),
                    controller.isloader
                        ? Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : controller.insuranceList.isEmpty
                            ? Expanded(
                                child: Center(child: CustomError.noData()),
                              )
                            : AnimationLimiter(
                                child: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.insuranceList.length,
                                      itemBuilder: (context, index) {
                                        final data =
                                            controller.insuranceList[index];
                                        return Card(
                                          color:
                                              Color.fromRGBO(246, 244, 238, 1),
                                          elevation: 0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomRichText
                                                          .customRichText(
                                                              "Provider: ",
                                                              data.provider!),
                                                      CustomRichText
                                                          .customRichText(
                                                              "Policy No.: ",
                                                              data.policyNo!),
                                                    ]),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await launchUrl(Uri.parse(
                                                      controller
                                                          .insuranceList[index]
                                                          .url!));
                                                },
                                                style: Styles.RoundButton,
                                                child: Text(
                                                  "Download",
                                                  style: Styles.latoButtonText
                                                      .copyWith(fontSize: 13.0),
                                                ),
                                              ),
                                            ]),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
