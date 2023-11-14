import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/controllers/profile_conftroller.dart';

import '../constant.dart';
import '../model/user_model.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomText.dart';
import '../widgets/CustomTxtFieldWidget.dart';
import '../widgets/error_message_widget.dart';

/*class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}*/

class EditProfileView extends GetView<ProfileController> {
  String gender = 'Male';
  File? _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Image.asset('assets/icons/back.png'),
            ),
          ),
          title: CustomText(
            txt: 'Edit Profile',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontColor: primaryColor,
          ),
          leadingWidth: 55.w,
          centerTitle: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 80.r,
                      backgroundImage: UserModel.loggedinUser!.profileImg.isNotEmpty || controller.profileImgURL.isNotEmpty
                          ? NetworkImage(controller.profileImgURL.isNotEmpty ? controller.profileImgURL.value : UserModel.loggedinUser!.profileImg)
                          : AssetImage('assets/images/profile.png') as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                      onTap: () async {
                        controller.showUploadImageDialog();
                      },
                      child: CustomText(
                        txt: 'Change Profile Picture',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontColor: primaryColor,
                      ))
                ]),
                SizedBox(
                  height: 30.h,
                ),
                CustomTxtFieldWidget2(
                  hintTxt: 'Joan Kemp',
                  focusNode: controller.fnFullName,
                  txt: controller.tecFullName,
                  onChanged: (value) {
                    controller.fullNameValidation();
                  },
                  labelTxt: 'Full Name',
                ),
                Obx(() => ErrorMessageWidget(
                      errorMsg: controller.fullNameErrorMessage.value,
                      visibility: controller.fullNameErrorVisible.value,
                    )),
                SizedBox(
                  height: 25.h,
                ),
                CustomTxtFieldWidget2(
                  hintTxt: 'joankemp@gmail.com',
                  labelTxt: 'Email',
                  txt: controller.tecEmail,
                  focusNode: controller.fnEmail,
                  onChanged: (value) {
                    controller.emailValidation();
                  },
                  isReadOnly: true,
                ),
                Obx(() => ErrorMessageWidget(
                      errorMsg: controller.emailErrorMessage.value,
                      visibility: controller.emailErrorVisible.value,
                    )),
                SizedBox(
                  height: 25.h,
                ),
                CustomTxtFieldWidget2(
                  hintTxt: '**********',
                  labelTxt: 'Password',
                  txt: controller.tecPassword,
                  suffixIcon: 'key',
                  focusNode: controller.fnPassword,
                  onChanged: (value) {
                    controller.passwordValidation();
                  },
                  isReadOnly: true,
                ),
                Obx(() => ErrorMessageWidget(
                      errorMsg: controller.passwordErrorMessage.value,
                      visibility: controller.passwordErrorVisible.value,
                    )),
                SizedBox(
                  height: 50.h,
                ),
                CustomButton(
                  txt: 'Update Profile',
                  height: 85.h,
                  borderRadius: 20,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  txtColor: whiteColor,
                  onTap: () {
                    controller.checkDataValues();
                  },
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ));
  }
}
