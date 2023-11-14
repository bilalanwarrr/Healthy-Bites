import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/widgets/CustomButton.dart';
import 'package:healthy/widgets/CustomText.dart';

class BoardingView extends StatefulWidget {
  const BoardingView({Key? key}) : super(key: key);

  @override
  State<BoardingView> createState() => _BoardingViewState();
}

class _BoardingViewState extends State<BoardingView> {
  int boardingStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/onboard_back.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 420.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                    color: whiteColor.withOpacity(0.35),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.r), topLeft: Radius.circular(40.r))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomText(
                      txt: 'Welcome to Healthy Bites!',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText(
                      txt: 'Explore the tastiest and nutritious food for your kids',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontColor: colorThree,
                    ),
                    Spacer(),
                    CustomButtonIcon(
                        txt: 'Get Started',
                        height: 75,
                        fontSize: 26,
                        borderRadius: 20,
                        txtColor: whiteColor,
                        onTap: () {
                          Get.offAndToNamed(kLoginRoute);
                        }),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
