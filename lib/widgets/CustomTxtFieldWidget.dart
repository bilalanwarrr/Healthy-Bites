import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/widgets/CustomText.dart';

class CustomTxtFieldWidget extends StatelessWidget {
  CustomTxtFieldWidget({
    Key? key,
    required this.hintTxt,
    required this.txt,
    this.leadingIcon = '',
    this.suffixIcon = '',
    this.maxLines = 1,
    this.isFocused = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.focusNode,
    this.onChanged,
  }) : super(key: key);

  final String hintTxt, leadingIcon, suffixIcon;
  final TextEditingController txt;
  final int maxLines;
  final bool isFocused;
  TextInputType textInputType = TextInputType.text;
  TextInputAction textInputAction = TextInputAction.next;
  FocusNode focusNode;

  ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.h,
      child: TextField(
        controller: txt,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
            filled: true,
            fillColor: whiteColor,
            labelText: hintTxt,
            labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: blackColor, fontFamily: 'Gotham'),
            //prefixIconColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? primaryColor : secondaryColor),
            prefixIcon: leadingIcon.isNotEmpty
                ? Image.asset(
                    'assets/icons/$leadingIcon.png',
                    //color: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? primaryColor : secondaryColor),
                    color: focusNode.hasFocus ? primaryColor : Colors.grey,
                    // color: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.focused) ? Colors.black : Colors.grey)
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            suffixIcon: suffixIcon.isNotEmpty
                ? Image.asset('assets/icons/$suffixIcon.png')
                : Container(
                    height: 0,
                    width: 0,
                  ),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide(color: colorOne)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide(color: colorOne))),
      ),
    );
  }
}

class CustomTxtFieldWidget2 extends StatelessWidget {
  CustomTxtFieldWidget2(
      {Key? key,
      required this.hintTxt,
      required this.labelTxt,
      required this.txt,
      this.suffixIcon = '',
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      required this.focusNode,
      this.onChanged,
      this.isReadOnly = false})
      : super(key: key);

  final String hintTxt, labelTxt, suffixIcon;
  final TextEditingController txt;

  TextInputType textInputType = TextInputType.text;
  TextInputAction textInputAction = TextInputAction.next;
  FocusNode focusNode;
  bool isReadOnly;

  ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txt: labelTxt,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 80.h,
          child: TextField(
            controller: txt,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16.sp, color: blackColor, fontFamily: 'Gotham'),
            decoration: InputDecoration(
                enabled: !isReadOnly,
                filled: true,
                fillColor: isReadOnly ? disableColor : whiteColor,
                hintText: hintTxt,
                hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: colorThree, fontFamily: 'Gotham'),
                suffixIcon: suffixIcon.isNotEmpty
                    ? Image.asset('assets/icons/$suffixIcon.png')
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide(color: blackColor)),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide(color: blackColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r), borderSide: BorderSide(color: blackColor))),
          ),
        ),
      ],
    );
  }
}
