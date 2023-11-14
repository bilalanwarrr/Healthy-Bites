//Dropdown Widget with Label
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';
import 'CustomText.dart';

class CustomDropdownWidget extends StatelessWidget {
  List dropDownItems = [];
  // VoidCallback<>? onDropDownChange;
  ValueChanged<Object?>? onDropDownChange;
  String selectedItem;

  CustomDropdownWidget({required this.dropDownItems, required this.selectedItem, this.onDropDownChange});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        border: OutlineInputBorder(borderSide: BorderSide(color: blackColor), borderRadius: BorderRadius.circular(12.r)),
      ),
      child: DropdownButton(
          padding: EdgeInsets.symmetric(vertical: 0),
          items: dropDownItems
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: CustomText(
                      txt: e,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontColor: colorThree,
                    ),
                  ))
              .toList(),
          value: selectedItem,
          underline: Container(),
          isExpanded: true,
          onChanged: onDropDownChange),
    );
  }
}
