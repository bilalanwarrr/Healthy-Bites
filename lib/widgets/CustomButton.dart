import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/widgets/CustomText.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon(
      {Key? key,
      required this.txt,
      this.height = 55,
      this.width = 340,
      this.borderRadius = 18,
      this.txtColor = blackColor,
      this.fontSize = 15,
      this.fontWeight = FontWeight.w500,
      this.bColor = primaryColor, required this.onTap})
      : super(key: key);

  final double height, width, borderRadius, fontSize;
  final String txt;
  final Color txtColor, bColor;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r), color: bColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              txt: txt,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
              fontColor: txtColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Image.asset('assets/icons/arrow_right.png')
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.txt,
      this.height = 55,
      this.width = 340,
      this.borderRadius = 18,
      this.fontSize = 15,
      this.fontWeight = FontWeight.w500,
      this.txtColor = blackColor,
      this.bColor = primaryColor, this.bbColor = primaryColor, required this.onTap})
      : super(key: key);

  final double height, width, borderRadius, fontSize;
  final String txt;
  final Color txtColor, bColor, bbColor;
  final FontWeight fontWeight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius.r), color: bColor, border: Border.all(color: bbColor)),
        child: Center(
          child: CustomText(
            txt: txt,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
            fontColor: txtColor,
          ),
        ),
      ),
    );
  }
}
