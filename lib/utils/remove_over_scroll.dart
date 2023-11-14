import 'package:flutter/material.dart';

/*
* @Author Sadaf Khowaja
* */
class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}