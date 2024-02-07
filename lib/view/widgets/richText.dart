import 'package:attendance/constant/strings.dart';
import 'package:flutter/material.dart';

class CustomRichText {
  static Widget customRichText(
    String text1,
    String text2, {
    TextAlign textAlign = TextAlign.left,
    colorindex,
  }) {
    return RichText(
        //softWrap:false,
        textAlign: textAlign,
        text: TextSpan(
            text: text1,
            style: Styles.poppinsRegular
                .copyWith(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: text2,
                style: Styles.poppinsBold.copyWith(
                  fontSize: 16,
                  color: colorindex == 1 ? Colors.white : Colors.black,
                ),
              ),
            ]));
  }
}

richTextApplication(
    {Color? color, required String title, required String value}) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: '$title: ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              // color:  Colors.grey.shade600,
              color: Colors.black),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
