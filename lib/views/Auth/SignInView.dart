import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/auth/auth_controller.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/views/Auth/ForgetPasswordView.dart';
import 'package:healthy/widgets/CustomButton.dart';
import 'package:healthy/widgets/CustomTxtFieldWidget.dart';
import 'package:healthy/widgets/error_message_widget.dart';

import '../../utils/common_code.dart';
import '../../widgets/CustomText.dart';

class SignInView extends GetView<AuthController> {
  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: CommonCode().removeTextFieldFocus,
        child: NotificationListener(
          onNotification: (notificationInfo) {
            if (notificationInfo.runtimeType == UserScrollNotification) {
              CommonCode().removeTextFieldFocus();
            }
            return false;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: CustomText(
                            txt: 'Login\nHere!',
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            fontColor: primaryColor,
                            maxLines: 2,
                          ),
                        ),
                        Expanded(
                            child: Image.asset(
                          'assets/images/img1.png',
                          height: 450.h,
                          fit: BoxFit.fill,
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          CustomTxtFieldWidget(
                            hintTxt: 'Email',
                            txt: controller.tecEmail,
                            leadingIcon: 'email',
                            focusNode: controller.fnEmail,
                            isFocused: controller.fnEmail.hasFocus,
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
                            hintTxt: 'Password',
                            txt: controller.tecPassword,
                            focusNode: controller.fnPassword,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: controller.isLoading.isTrue
                                      ? null
                                      : () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordView()));
                                        },
                                  child: CustomText(
                                    txt: 'Forgot Password?',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontColor: colorThree,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Obx(
                            () => Container(
                              width: Get.width,
                              child: controller.isLoading.isFalse
                                  ? CustomButton(
                                      txt: 'SIGN IN',
                                      height: 80.h,
                                      borderRadius: 15,
                                      txtColor: whiteColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      onTap: () {
                                        //Get.toNamed(kMainRoute);
                                        controller.checkValues();
                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainView()));
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
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: controller.isLoading.isTrue
                                ? null
                                : () {
                                    /*Get.toNamed(kSignupRoute)?.then((value) {
                                      print('============value $value');
                                      return Get.delete<LoginController>();
                                    });*/
                                    Get.toNamed(kSignupRoute);
                                  },
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Don\'t have an account?',
                                  style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: blackColor))),
                              TextSpan(
                                  text: ' Sign Up',
                                  style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: colorThree)))
                            ])),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
