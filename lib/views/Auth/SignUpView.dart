import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/auth/auth_controller.dart';
import 'package:healthy/widgets/CustomButton.dart';
import 'package:healthy/widgets/CustomTxtFieldWidget.dart';

import '../../widgets/CustomText.dart';
import '../../widgets/error_message_widget.dart';

class SignUpView extends GetView<AuthController> {
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/im2.png',
                height: 400.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          txt: 'Create\nAccount!',
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          fontColor: primaryColor,
                          maxLines: 2,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Already have an account',
                                style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: blackColor))),
                            TextSpan(
                                text: ' Login',
                                style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: colorThree)))
                          ])),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomTxtFieldWidget(
                      focusNode: controller.fnFullName,
                      hintTxt: 'Full Name',
                      txt: controller.tecFullName,
                      leadingIcon: 'email',
                      onChanged: (value) {
                        controller.fullNameValidation();
                      },
                    ),
                    Obx(() => ErrorMessageWidget(
                          errorMsg: controller.fullNameErrorMessage.value,
                          visibility: controller.fullNameErrorVisible.value,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTxtFieldWidget(
                      focusNode: controller.fnEmail,
                      hintTxt: 'Enter',
                      txt: controller.tecEmail,
                      leadingIcon: 'email',
                      onChanged: (value) {
                        controller.emailValidation();
                      },
                    ),
                    Obx(() => ErrorMessageWidget(
                          errorMsg: controller.emailErrorMessage.value,
                          visibility: controller.emailErrorVisible.value,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTxtFieldWidget(
                      focusNode: controller.fnPassword,
                      hintTxt: 'Password',
                      txt: controller.tecPassword,
                      leadingIcon: 'key',
                      onChanged: (value) {
                        controller.passwordValidation();
                      },
                    ),
                    Obx(() => ErrorMessageWidget(
                          errorMsg: controller.passwordErrorMessage.value,
                          visibility: controller.passwordErrorVisible.value,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTxtFieldWidget(
                      focusNode: controller.fnConfirmPassword,
                      hintTxt: 'Confirm Password',
                      txt: controller.tecConfirmPassword,
                      leadingIcon: 'key',
                      onChanged: (value) {
                        controller.confirmPasswordValidation();
                      },
                    ),
                    Obx(() => ErrorMessageWidget(
                          errorMsg: controller.confirmPasswordErrorMessage.value,
                          visibility: controller.confirmPasswordErrorVisible.value,
                        )),
                    SizedBox(
                      height: 50.h,
                    ),
                    controller.isLoading.isFalse
                        ? CustomButton(
                            txt: 'Create Account',
                            height: 80.h,
                            borderRadius: 15,
                            txtColor: whiteColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            onTap: () {
                              //Navigator.pop(context);
                              controller.checkValues(isSignUp: true);
                            },
                          )
                        : const Center(
                            child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                )),
                          ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
