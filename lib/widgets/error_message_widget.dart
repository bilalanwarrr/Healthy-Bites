import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorMessageWidget extends StatelessWidget {
  final bool visibility;
  final String errorMsg;
  final double leftPadding, rightPadding;
  const ErrorMessageWidget({super.key, this.visibility = false, this.errorMsg = '', this.leftPadding = 5.0, this.rightPadding = 5.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
      child: Visibility(
        visible: visibility,
        child: Text(
          errorMsg,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.red,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}
