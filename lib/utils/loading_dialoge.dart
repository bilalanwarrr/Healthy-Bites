import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constant.dart';
/*

showLoadingDialog({required BuildContext context, required String title}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: backgroundColor,
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        primaryColor,
                        inputColor,
                        secondaryColor,
                      ],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(26)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                          //SpinKitFadingGrid(color: primaryColor)
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
*/

Future<dynamic> showLoadingDialogCustom({String title = "Please Wait..."}) {
  return Get.dialog(
      barrierDismissible: false,
      Dialog(
        //backgroundColor: Colors.transparent,
        child: Wrap(
          children: [
            Container(
              //padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(26)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: /* CircularProgressIndicator(
                        color: primaryColor,
                      ),*/
                        // SpinKitFadingGrid(color: primaryColor)
                        Container(
                      padding: const EdgeInsets.only(top: 8),
                      width: 100,
                      height: 120,
                      child: const LoadingIndicator(
                        //backgroundColor: Colors.black,
                        indicatorType: Indicator.ballGridPulse,
                        colors: [primaryColor],
                        strokeWidth: 4.0,
                        pathBackgroundColor: true ? Colors.black45 : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
}
