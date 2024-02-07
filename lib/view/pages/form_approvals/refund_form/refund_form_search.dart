import 'package:attendance/constant/strings.dart';
import 'package:attendance/controller/model_state/approveform_ctrl.dart';
import 'package:attendance/view/widgets/list_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefundFormSearchScreen extends StatefulWidget {
  final String title;
  const RefundFormSearchScreen({
    super.key,
    required this.title,
  });

  @override
  State<RefundFormSearchScreen> createState() => _RefundFormSearchScreenState();
}

class _RefundFormSearchScreenState extends State<RefundFormSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ApproveFormGetx>(
        init: ApproveFormGetx(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  controller.refundSearchCtrl.clear();
                  controller.refundSearchData.clear();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                widget.title,
              ),
              backgroundColor: Strings.primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: controller.refundSearchCtrl ,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Strings.primaryColor),
                      ),
                      hintText: 'Search',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Strings.primaryColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        controller.getSearchResultRefund(value);
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = controller.refundSearchData[index];
                          return data.name.toLowerCase().contains(controller
                                      .searchCtrl.text
                                      .toLowerCase()) ||
                                  data.applicationnumber.toLowerCase().contains(
                                      controller.refundSearchCtrl.text
                                          .toLowerCase())
                              ? RefundCardWidget(
                                  index: index,
                                  controller: controller,
                                  data: data,
                                )
                              : SizedBox();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: controller.refundSearchData.length),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
