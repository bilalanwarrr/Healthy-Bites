import 'package:flutter/material.dart';
import 'package:get/get.dart';

showCustomSnackBar(
    {required String content, Function()? onTap, Duration duration = const Duration(seconds: 2), Color backgroundColor = Colors.black87}) {
  Get.showSnackbar(
    GetSnackBar(
      backgroundColor: backgroundColor,
      duration: duration,
      message: content,
      /* titleText: GestureDetector(
        onTap: onTap,
        child: Text(
          content,
          style: TextStyle(color: Colors.white70),
        ),
      ),*/
    ),
  );
}
