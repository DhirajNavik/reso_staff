import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constant/strings.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  final Widget? widget;
  final double? size;

  CustomAppBar(this.title, {super.key, this.widget, this.size});
  @override
  Widget build(BuildContext context) {
    double width = Strings.width(context);
    double height = Strings.width(context);
    return Container(
        width: double.infinity,
        height: height / 2.8,
        decoration: BoxDecoration(
            color: Strings.primaryColor,
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(80, 60))),
        child: Column(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: widget ??
                  GestureDetector(
                      onTap: () {
                        log('hi');
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                          size: width / 10,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          Icons.menu)),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
                top: 35,
              ),
              child: Text(
                title,
                style: Styles.poppinsRegular
                    .copyWith(color: Colors.white, fontSize: size ?? 24),
              ),
            ),
          ),
        ]));
  }
}
