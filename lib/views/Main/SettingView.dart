import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/helpers/firebase_helper.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/views/PrivacyView.dart';
import 'package:healthy/views/SubscriptionView.dart';
import 'package:healthy/views/TermsView.dart';
import 'package:healthy/widgets/CustomText.dart';

import '../../constant.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool notification = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/setting_back.png'))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    txt: 'Setting',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontColor: primaryColor,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset('assets/icons/edit.png'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: colorThree,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: CustomText(
                txt: 'Edit Profile',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontColor: colorThree,
              ),
              onTap: () {
                Get.toNamed(kEditProfileRoute);
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/subscription.png'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: colorThree,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: CustomText(
                txt: 'Subscription',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontColor: colorThree,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionView()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/privacy.png'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: colorThree,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: CustomText(
                txt: 'Privacy Policy',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontColor: colorThree,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyView()));
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/terms.png'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: colorThree,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              title: CustomText(
                txt: 'Terms and Conditions',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontColor: colorThree,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsView()));
              },
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 120.h),
              child: ListTile(
                leading: Image.asset('assets/icons/signout.png'),
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: CustomText(
                  txt: 'Sign Out',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontColor: colorThree,
                ),
                onTap: () {
                  FirebaseHelper.logout();
                },
              ),
            ),
          ],
        ));
  }
}
