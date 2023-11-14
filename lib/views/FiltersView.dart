import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/controllers/recipe_controller.dart';
import 'package:healthy/widgets/CustomButton.dart';

import '../constant.dart';
import '../main.dart';
import '../widgets/CustomText.dart';
import '../widgets/custom_dropdown_widget.dart';

/*class FiltersView extends StatefulWidget {
  const FiltersView({Key? key}) : super(key: key);

  @override
  State<FiltersView> createState() => _FiltersViewState();
}*/

class FiltersView extends GetView<RecipeController> {
  /*var selectedList = [];
  String dailyReg = '', healthyStyle = '', cookingTime = '';
  String calLevel = '', fibLevel = '', protLevel = '', fatLevel = '', sugLevel = '', carbLevel = '';
*/
  @override
  Widget build(BuildContext context) {
    controller.resetAllData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomTextM(
          txt: 'Filter Recipes',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontColor: primaryColor,
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        leadingWidth: 55.w,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                txt: 'What kind of recipes do you want to see?',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 30.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Daily Regimen',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => CustomDropdownWidget(
                      dropDownItems: dailyRegimens,
                      selectedItem: controller.dailyReg.value.isEmpty ? dailyRegimens.first : controller.dailyReg.value,
                      onDropDownChange: controller.onDailyRegimenDropDownChange,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Health Style',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => CustomDropdownWidget(
                      dropDownItems: healthyStyles,
                      selectedItem: controller.healthyStyle.value.isEmpty ? healthyStyles.first : controller.healthyStyle.value,
                      onDropDownChange: controller.onHealthStyleDropDownChange,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Cooking Times',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => CustomDropdownWidget(
                      dropDownItems: cookingTimes,
                      selectedItem: controller.cookingTime.value.isEmpty ? cookingTimes.first : controller.cookingTime.value,
                      onDropDownChange: controller.onCookingTimeDropDownChange,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Calories',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.calLevel.value.isEmpty ? levels.first : controller.calLevel.value,
                            onDropDownChange: controller.onCaloriesDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Fiber',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.fibLevel.value.isEmpty ? levels.first : controller.fibLevel.value,
                            onDropDownChange: controller.onFibersDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Proteins',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.protLevel.value.isEmpty ? levels.first : controller.protLevel.value,
                            onDropDownChange: controller.onProteinDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Fat',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.fatLevel.value.isEmpty ? levels.first : controller.fatLevel.value,
                            onDropDownChange: controller.onFatsDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Sugar',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.sugLevel.value.isEmpty ? levels.first : controller.sugLevel.value,
                            onDropDownChange: controller.onSugarDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          txt: 'Carbohydrates',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => CustomDropdownWidget(
                            dropDownItems: levels,
                            selectedItem: controller.carbLevel.value.isEmpty ? levels.first : controller.carbLevel.value,
                            onDropDownChange: controller.onCarbohydratesDropDownChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    txt: 'Apply Filter',
                    height: 85.h,
                    borderRadius: 20,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    txtColor: whiteColor,
                    onTap: () {
                      controller.applyFilters();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

const dailyRegs = ['Dinner', 'Launch', 'Breakfast'];
const cookingTimes = ['30 minutes', '1 hour', '2 hour'];
const levels = ['Low', 'High', 'Medium'];
