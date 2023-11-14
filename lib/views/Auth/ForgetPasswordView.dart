import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/controllers/auth/auth_controller.dart';
import 'package:healthy/widgets/error_message_widget.dart';

import '../../constant.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/CustomText.dart';
import '../../widgets/CustomTxtFieldWidget.dart';

class ForgetPasswordView extends GetView<AuthController> {
  ForgetPasswordView({Key? key}) : super(key: key);

  final emailTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            size: 25.sp,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomText(
              txt: 'Forgot Password',
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              fontColor: primaryColor,
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomText(
              txt:
                  'Please enter the email address associated with your account',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomTxtFieldWidget(
              hintTxt: 'Enter your email ',
              txt: controller.tecEmail,
              leadingIcon: 'email',
              focusNode: FocusNode(),
              onChanged: (value) {
                controller.emailValidation();
              },
            ),
            Obx(() => ErrorMessageWidget(
                  errorMsg: controller.emailErrorMessage.value,
                  visibility: controller.emailErrorVisible.value,
                )),
            SizedBox(
              height: 60.h,
            ),
            Obx(
              () => controller.isLoading.isTrue
                  ? const Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )),
                    )
                  : CustomButton(
                      txt: 'SEND OTP',
                      height: 80.h,
                      borderRadius: 30,
                      txtColor: whiteColor,
                      onTap: () {
                        controller.sendResetEmail(
                            email: controller.tecEmail.text);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
