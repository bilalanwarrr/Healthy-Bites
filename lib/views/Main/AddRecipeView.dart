import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/controllers/recipe_controller.dart';
import 'package:healthy/widgets/CustomTxtFieldWidget.dart';
import 'package:healthy/widgets/custom_dropdown_widget.dart';

import '../../constant.dart';
import '../../main.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/CustomText.dart';

/*class AddRecipeView extends StatefulWidget {
  const AddRecipeView({Key? key}) : super(key: key);

  @override
  State<AddRecipeView> createState() => _AddRecipeViewState();
}*/

class AddRecipeView extends GetView<RecipeController> {
  MainViewController mainViewController;

  AddRecipeView({required this.mainViewController});

  @override
  Widget build(BuildContext context) {
    controller.resetAllData();
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => CustomText(
                      txt: controller.step.value == 1
                          ? 'Add Your Recipe'
                          : controller.step.value == 2
                              ? 'Ingredients'
                              : 'How to do it?',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      fontColor: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            CustomText(
              txt: 'Add a pinch of passion to our culinary community by sharing your secret recipe masterpiece.',
              maxLines: 2,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 28.h,
                  width: 28.w,
                  margin: EdgeInsets.only(bottom: 5.h),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                  child: Center(
                    child: CustomText(
                      txt: '1',
                      fontColor: whiteColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    height: 3.h,
                    width: 120.w,
                    color: controller.step.value > 1 ? primaryColor : colorSix,
                  ),
                ),
                Obx(
                  () => Container(
                    height: 28.h,
                    width: 28.w,
                    margin: EdgeInsets.only(bottom: 5.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.step.value > 1 ? primaryColor : whiteColor,
                        border: Border.all(color: controller.step.value < 2 ? colorSix : primaryColor, width: 2.5.w)),
                    child: Center(
                      child: CustomText(
                        txt: '2',
                        fontColor: controller.step.value > 1 ? whiteColor : colorSix,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    height: 3.h,
                    width: 120.w,
                    color: controller.step.value > 2 ? primaryColor : colorSix,
                  ),
                ),
                Obx(
                  () => Container(
                    height: 28.h,
                    width: 28.w,
                    margin: EdgeInsets.only(bottom: 5.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.step.value > 2 ? primaryColor : whiteColor,
                        border: Border.all(color: controller.step.value < 3 ? colorSix : primaryColor, width: 2.5.w)),
                    child: Center(
                      child: CustomText(
                        txt: '3',
                        fontColor: controller.step.value > 2 ? whiteColor : colorSix,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    txt: 'Details',
                    fontColor: primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  Obx(
                    () => CustomText(
                      txt: '  Ingredients',
                      fontColor: controller.step.value > 1 ? primaryColor : colorSix,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => CustomText(
                      txt: 'Method',
                      fontColor: controller.step.value > 2 ? primaryColor : colorSix,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => Container(
                child: controller.step.value == 1
                    ? _stepOne()
                    : controller.step.value == 2
                        ? _stepTwo()
                        : _stepThree(),
              ),
            )
          ],
        )));
  }

  Widget _stepOne() {
    return Column(
      children: [
        CustomTxtFieldWidget2(
          hintTxt: 'Steak and Corn',
          labelTxt: 'Recipe Name',
          txt: controller.tecRecipeName,
          focusNode: controller.fnRecipeName,
        ),
        SizedBox(
          height: 25.h,
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
              txt: controller.step.value != 3 ? 'Next' : 'Add Recipe',
              height: 85.h,
              borderRadius: 20,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              txtColor: whiteColor,
              onTap: () {
                if (controller.step.value != 3) {
                  controller.step.value++;
                } else {
                  controller.step.value = 1;
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  Widget _stepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Row(
          children: [
            Expanded(
                flex: 2,
                child: CustomTxtFieldWidget2(
                  hintTxt: 'Steak',
                  labelTxt: 'Name',
                  txt: controller.tecIngredientName,
                  focusNode: controller.fnRecipeName,
                )),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Quantity',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(
                    () => SizedBox(
                      height: 60.h,
                      child: CustomDropdownWidget(
                        dropDownItems: quantities,
                        selectedItem: controller.quantity.value.isEmpty ? quantities.first : controller.quantity.value,
                        onDropDownChange: controller.onQuantityDropDownChange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),*/
        ListView.builder(
            itemCount: controller.moreIngList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return controller.moreIngList[index];
            }),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: GestureDetector(
            onTap: () {
              controller.tecIngredientsList.add(TextEditingController());
              controller.tecQuantitiesList.add(TextEditingController());
              controller.quantityList.add("");
              controller.fnIngredientsList.add(FocusNode());
              controller.moreIngList.add(IngredientsWidget(
                controller: controller,
                index: controller.moreIngList.length,
              ));
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/add2.png',
                  height: 25.h,
                  width: 25.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomText(
                  txt: 'Add more',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              txt: controller.step.value != 3 ? 'Next' : 'Add Recipe',
              height: 85.h,
              borderRadius: 20,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              txtColor: whiteColor,
              onTap: () {
                if (controller.step.value != 3) {
                  controller.step.value++;
                } else {
                  controller.step.value = 1;
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }

  Widget _stepThree() {
    /*
    controller.moreHowList.add(StepsTextWidget(controller: controller));
    controller.moreHowList.add(StepsTextWidget(controller: controller));
    controller.moreHowList.add(StepsTextWidget(controller: controller));*/

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListView.builder(
          itemCount: controller.moreHowList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return controller.moreHowList[index];
          }),
      Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: GestureDetector(
          onTap: () {
            controller.tecStepsList.add(TextEditingController());
            controller.fnStepsList.add(FocusNode());
            controller.moreHowList.add(StepsTextWidget(
              controller: controller,
              index: controller.moreHowList.length,
            ));
          },
          child: Row(
            children: [
              Image.asset(
                'assets/icons/add2.png',
                height: 25.h,
                width: 25.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomText(
                txt: 'Add more',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 50.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controller.isLoading.isFalse
              ? CustomButton(
                  txt: controller.step.value != 3 ? 'Next' : 'Add Recipe',
                  height: 85.h,
                  borderRadius: 20,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  txtColor: whiteColor,
                  onTap: () {
                    if (controller.step.value != 3) {
                      controller.step.value++;
                    } else {
                      // controller.step.value = 1;
                      controller.addData(mainViewController);
                    }
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
        ],
      ),
      SizedBox(
        height: 20.h,
      )
    ]);
  }
}

class IngredientsWidget extends StatelessWidget {
  const IngredientsWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final RecipeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
        ),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: CustomTxtFieldWidget2(
                  hintTxt: 'Steak',
                  labelTxt: 'Name',
                  txt: controller.tecIngredientsList[index],
                  focusNode: controller.fnIngredientsList[index],
                )),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    txt: 'Quantity',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                      border: OutlineInputBorder(borderSide: BorderSide(color: blackColor), borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55.h,
                            child: TextField(
                              controller: controller.tecQuantitiesList[index],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                hintText: '1',
                                hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: colorThree, fontFamily: 'Gotham'),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        // Spacer(),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: Obx(
                              () => DropdownButton(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  items: quantities
                                      .map((e) => DropdownMenuItem(
                                            child: CustomText(
                                              txt: e,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontColor: colorThree,
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  value: controller.quantityList[index].isEmpty ? quantities.first : controller.quantityList[index],
                                  underline: Container(),
                                  isExpanded: true,
                                  onChanged: (val) {
                                    controller.quantityList[index] = val!;
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Obx(
                    () => Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        height: 62.h,
                        child: CustomDropdownWidget(
                          dropDownItems: quantities,
                          selectedItem: controller.quantity.value.isEmpty ? quantities.first : controller.quantity.value,
                          onDropDownChange: controller.onQuantityDropDownChange,
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StepsTextWidget extends StatelessWidget {
  const StepsTextWidget({super.key, required this.controller, required this.index});

  final RecipeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25.h,
        ),
        CustomTxtFieldWidget2(
            hintTxt: 'Step ${index + 1}',
            labelTxt: 'Step-${index + 1}',
            txt: controller.tecStepsList[index],
            focusNode: controller.fnStepsList[index]),
      ],
    );
  }
}
