import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/views/Main/AddRecipeView.dart';
import 'package:healthy/views/Main/HomeView.dart';
import 'package:healthy/views/Main/SettingView.dart';
import 'package:healthy/views/saved_recipe_meal_types.dart';

import '../../utils/custom_snackbar.dart';
/*
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}*/

class MainView extends GetView<MainViewController> {
  /*int controller.index.value = 0;
  int exitAttempts = 0, lastPress = 0;*/

  @override
  Widget build(BuildContext context) {
    final views = [
      HomeView(mainViewController: controller),
      AddRecipeView(
        mainViewController: controller,
      ),
      MealTypes(mainViewController: controller),
      // SavedRecipeView(mainViewController: controller),
      SettingView()
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: CustomText(
      //     txt: controller.index.value == 0 ? 'Hey, Joan Kemp!' : controller.index.value == 3 ? 'Setting' : 'CC',
      //     fontSize: controller.index.value == 0  ? 18 : 24,
      //     fontWeight: controller.index.value == 0 ? FontWeight.w400 : FontWeight.w500,
      //     fontColor: controller.index.value !=0 ? primaryColor : blackColor,
      //   ),
      //   // centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   leadingWidth: 60.w,
      //   centerTitle: controller.index.value == 0 ? false : true,
      //   leading: controller.index.value == 0 ? Padding(
      //     padding: EdgeInsets.only(left: 20.w),
      //     child: CircleAvatar(
      //       backgroundImage: AssetImage('assets/images/2.png'),
      //     ),
      //   ) : Container(),
      //   actions: [
      //     GestureDetector(onTap: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationView()));
      //     }, child: Image.asset('assets/icons/notifications.png', height: 32.h, width: 32.w,),),
      //     SizedBox(width: 15.w,)
      //   ],
      // ),
      body: WillPopScope(
          onWillPop: controller.index.value > 0
              ? () async {
                  // setState(() {
                  controller.index.value = controller.index.value > 0 ? controller.index.value - 1 : 0;
                  //});

                  return false;
                }
              : onBackPressed,
          child: Obx(() => views[controller.index.value])),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.index.value,
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          selectedLabelStyle: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          unselectedLabelStyle: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          onTap: (val) {
            //setState(() {
            controller.index.value = val;
            //});
          },
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    'assets/icons/home.png',
                    color: controller.index.value == 0 ? primaryColor : secondaryColor,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    'assets/icons/add.png',
                    color: controller.index.value == 1 ? primaryColor : secondaryColor,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                label: 'Add Recipe'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    'assets/icons/saved.png',
                    color: controller.index.value == 2 ? primaryColor : secondaryColor,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                label: 'Saved Recipes'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Image.asset(
                    'assets/icons/setting.png',
                    color: controller.index.value == 3 ? primaryColor : secondaryColor,
                    height: 30.h,
                    width: 30.w,
                  ),
                ),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }

  /*_createNewPlaylist() {
    showDialog(
        context: context,
        builder: (context) {
          return Wrap(
            runAlignment: WrapAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: whiteColor,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Spacer(),
                        CustomText(
                          txt: 'Create New Playlist',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.close))
                      ],
                    ),
                    Material(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter the name of playlist',
                            hintStyle: GoogleFonts.nunito(textStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.sp, color: secondaryColor)),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor))),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CustomButton(txt: 'Create', txtColor: whiteColor, bColor: primaryColor, height: 65.h, borderRadius: 30.r, onTap: () {})
                  ],
                ),
              )
            ],
          );
        });
  }*/

  Future<bool> onBackPressed() {
    print('=========inedx ${controller.index.value}');
    DateTime _now = DateTime.now();
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    print('================time out ${currentTime - controller.lastPress.value > 5000}');
    if (controller.index.value > 0) {
      controller.index.value = 0;
    } else if (currentTime - controller.lastPress.value > 5000) {
      showCustomSnackBar(content: "Press back button again to exit the app");
      controller.lastPress.value = currentTime;
    } else {
      exit(0);
    }
    return Future.value(false);
  }
}
