import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/utils/app_strings.dart';

import '../constant.dart';
import '../controllers/main_view_controller.dart';
import '../widgets/CustomText.dart';

class MealTypes extends StatelessWidget {
  MealTypes({super.key, required this.mainViewController});
  MainViewController mainViewController;

  List<String> mealImages = ["breakfast_bg.png", "lunch_bg.png", "dinner_bg.png", "snacks_bg.png"];
  List<String> mealNames = ["Breakfast", "Lunch", "Dinner", "Snacks"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            mainViewController.index.value = 0;
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        title: CustomText(
          txt: 'Saved Recipes',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontColor: primaryColor,
        ),
        leadingWidth: 55.w,
        centerTitle: true,
        foregroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/saved_recipes_bg.png"), fit: BoxFit.fill)),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: SafeArea(
            child: GridView.builder(
              itemCount: mealNames.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0.0,
              ),
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return GridviewItemWidget(
                  mealImageName: mealImages[index],
                  mealName: mealNames[index],
                  mainViewController: mainViewController,
                );
              },
            ),
          )),
    );
  }
}

class GridviewItemWidget extends StatelessWidget {
  final String mealImageName, mealName;
  final MainViewController mainViewController;
  GridviewItemWidget({super.key, required this.mealImageName, required this.mealName, required this.mainViewController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('============meal Name $mealName');
        Get.toNamed(kSavedRecipesListRoute, arguments: {"mealCategory": mealName, "mainViewController": mainViewController});
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/images/$mealImageName",
            height: 400,
            width: 250,
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 8,
            child: Container(
              width: Get.width * 0.45,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColorContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: CustomText(
                    txt: mealName,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
