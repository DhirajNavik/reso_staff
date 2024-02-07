import 'package:attendance/controller/model_state/e_voucher_ctrl.dart';
import 'package:attendance/controller/model_state/f_voucher_ctrl.dart';
import 'package:attendance/controller/model_state/reservation_ctrl.dart';
import 'package:attendance/view/widgets/richText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDiscountDetailsPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Discount Details'),
        content: SizedBox(
          width: double.maxFinite,
          height: 350,
          child: GetBuilder<ReservationDiscountGetx>(
              init: ReservationDiscountGetx(),
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final details = controller.discountDetailsList[index];
                    return Card(
                      color: Color.fromARGB(255, 238, 238, 232),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            richTextApplication(
                                title: 'Name', value: details.name!),
                            richTextApplication(
                                title: 'Application No.',
                                value: details.reservationUkey!),
                            richTextApplication(
                                title: 'Voucher Type',
                                value: details.vouchertype ?? ''),
                            richTextApplication(
                                title: 'Discount Id',
                                value: details.reservationDiscountid!),
                            richTextApplication(
                                title: 'Discount Type',
                                value: details.discounttype!),
                            richTextApplication(
                                title: 'Amount', value: details.amount!),
                            richTextApplication(
                                title: 'Reason', value: details.reason!),
                            richTextApplication(
                                title: 'Comments',
                                value: details.comments.toString()),
                            richTextApplication(
                                title: "Requested To: ",
                                value: details.approvedby.toString()),
                            details.status == '1'
                                ? richTextApplication(
                                    title: 'Approved Date',
                                    value: details.approveddate.toString())
                                : SizedBox(),
                            richTextApplication(
                                title: 'Status',
                                value: details.status == '0'
                                    ? 'Pending'
                                    : details.status == '1'
                                        ? 'Approved'
                                        : 'Rejected'),
                            richTextApplication(
                                title: 'Created By',
                                value: details.createdby.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.discountDetailsList.length,
                );
              }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void showDiscountDetailsFPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Discount Details'),
        content: SizedBox(
          width: double.maxFinite,
          height: 350,
          child: GetBuilder<FVoucherGetx>(
              init: FVoucherGetx(),
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final details = controller.discountDetailsList[index];
                    return Card(
                      color: Color.fromARGB(255, 238, 238, 232),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            richTextApplication(
                                title: 'Name', value: details.name.toString()),
                            richTextApplication(
                                title: 'Application No.',
                                value: details.reservationUkey.toString()),
                            richTextApplication(
                                title: 'Voucher Type',
                                value: details.vouchertype.toString()),
                            richTextApplication(
                                title: 'Discount Id',
                                value:
                                    details.reservationDiscountid.toString()),
                            richTextApplication(
                                title: 'Discount Type',
                                value: details.discounttype.toString()),
                            richTextApplication(
                                title: 'Amount',
                                value: details.amount.toString()),
                            richTextApplication(
                                title: 'Reason',
                                value: details.reason.toString()),
                            richTextApplication(
                                title: 'Comments',
                                value: details.comments.toString()),
                            richTextApplication(
                                title: "Requested To: ",
                                value: details.approvedby.toString()),
                            details.status == '1'
                                ? richTextApplication(
                                    title: 'Approved Date',
                                    value: details.approveddate.toString())
                                : SizedBox(),
                            richTextApplication(
                                title: 'Status',
                                value: details.status == '0'
                                    ? 'Pending'
                                    : details.status == '1'
                                        ? 'Approved'
                                        : 'Rejected'),
                            richTextApplication(
                                title: 'Created By',
                                value: details.createdby.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.discountDetailsList.length,
                );
              }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void showDiscountDetailsEPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Discount Details'),
        content: SizedBox(
          width: double.maxFinite,
          height: 350,
          child: GetBuilder<EVoucherGetx>(
              init: EVoucherGetx(),
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final details = controller.discountDetailsList[index];
                    return Card(
                      color: Color.fromARGB(255, 238, 238, 232),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            richTextApplication(
                                title: 'Name', value: details.name!),
                            richTextApplication(
                                title: 'Application No.',
                                value: details.reservationUkey!),
                            richTextApplication(
                                title: 'Voucher Type',
                                value: details.vouchertype!),
                            richTextApplication(
                                title: 'Discount Id',
                                value: details.reservationDiscountid!),
                            richTextApplication(
                                title: 'Discount Type',
                                value: details.discounttype!),
                            richTextApplication(
                                title: 'Amount', value: details.amount!),
                            richTextApplication(
                                title: 'Reason', value: details.reason!),
                            richTextApplication(
                                title: 'Comments',
                                value: details.comments.toString()),
                            richTextApplication(
                                title: "Requested To: ",
                                value: details.approvedby.toString()),
                            details.status == '1'
                                ? richTextApplication(
                                    title: 'Approved Date',
                                    value: details.approveddate.toString())
                                : SizedBox(),
                            richTextApplication(
                                title: 'Status',
                                value: details.status == '0'
                                    ? 'Pending'
                                    : details.status == '1'
                                        ? 'Approved'
                                        : 'Rejected'),
                            richTextApplication(
                                title: 'Created By',
                                value: details.createdby.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.discountDetailsList.length,
                );
              }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
