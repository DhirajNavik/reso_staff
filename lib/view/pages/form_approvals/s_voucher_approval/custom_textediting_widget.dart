import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextEditingWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hinttext;
  final bool fullBox;

  const CustomTextEditingWidget(
      {required this.title,
      required this.controller,
      required this.hinttext,
      this.fullBox = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: fullBox ? 4 : 10,
          child: Text(
            title,
            style: TextStyle(
                height: 1, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Flexible(
            flex: fullBox ? 7 : 6,
            child: Container(
              height: 30,
              child: TextFormField(
                  style: TextStyle(fontSize: 13),
                  onChanged: (value) {},
                  controller: controller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: hinttext,
                      contentPadding: EdgeInsets.only(left: 10))),
            )),
        !fullBox
            ? Container(
                width: MediaQuery.of(context).size.width / 3,
              )
            : Container()
      ],
    ).paddingOnly(top: 5, bottom: 5);
  }
}
