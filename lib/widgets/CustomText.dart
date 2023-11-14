import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/constant.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
      required this.txt,
      this.fontWeight = FontWeight.w500,
      this.fontColor = blackColor,
      this.fontFamily = 'Gotham',
      this.fontSize = 14,
      this.textAlign = TextAlign.left,
      this.textDecoration = TextDecoration.none,
      this.maxLines = 1})
      : super(key: key);

  final String txt;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final int maxLines;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(fontWeight: fontWeight, fontSize: fontSize.sp, color: fontColor, decoration: textDecoration, fontFamily: fontFamily),
    );
  }
}

class CustomTextM extends StatelessWidget {
  CustomTextM(
      {Key? key,
      required this.txt,
      this.fontWeight = FontWeight.w500,
      this.fontColor = blackColor,
      this.fontSize = 14,
      this.textAlign = TextAlign.left,
      this.textDecoration = TextDecoration.none})
      : super(key: key);

  final String txt;
  final FontWeight fontWeight;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      style: GoogleFonts.mulish(textStyle: TextStyle(fontWeight: fontWeight, fontSize: fontSize.sp, color: fontColor, decoration: textDecoration)),
    );
  }
}
