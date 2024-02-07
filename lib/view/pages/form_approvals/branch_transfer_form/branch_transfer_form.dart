import 'package:attendance/controller/model_state/approveform_ctrl.dart';
import 'package:attendance/view/pages/form_approvals/branch_transfer_form/branch_transform_search.dart';
import 'package:attendance/view/widgets/custom_appbar.dart';
import 'package:attendance/view/widgets/custom_drawer.dart';
import 'package:attendance/view/widgets/custom_error.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class BranchFormScreen extends StatelessWidget {
  const BranchFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var controller = Get.put(ApproveFormGetx());
      controller.getBranchTransferList();
    });
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: GetBuilder<ApproveFormGetx>(
          init: ApproveFormGetx(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.loadresources('branch');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar("Branch Transfer Form"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, left: 12.0, right: 12.0),
                    child: InkWell(
                      onTap: () {
                        controller.branchSearchData.clear();
                        controller.branchSearchCtrl.clear();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BranchTransferSearchScreen(
                              title: "Branch Transfer Form"),
                        ));
                      },
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  controller.showLoader == true
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.branchTransferList.isEmpty
                          ? Expanded(child: Center(child: CustomError.noData()))
                          : AnimationLimiter(
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      final data =
                                          controller.branchTransferList[index];
                                      return BranchCardWidget(
                                        index: index,
                                        data: data,
                                        controller: controller!,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
