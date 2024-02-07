import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool heading;

  const CustomTextWidget({
    required this.title,
    required this.value,
    this.heading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: heading
              ? Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              : Text(
                  title,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
        ),
        Text(':',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(
                color: heading ? Colors.blue : Colors.black,
                height: 1.1,
                fontSize: heading ? 10 : 13,
                fontWeight: FontWeight.w400,
              ),
            ).paddingOnly(left: 5))
      ],
    ).paddingOnly(bottom: 4);
  }
}
