import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/recipe_details_controller.dart';
import 'package:healthy/model/recipe_model.dart';
import 'package:healthy/widgets/CustomText.dart';

import '../model/user_model.dart';

/*class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);
  @override
  State<DetailView> createState() => _DetailViewState();
}*/

class DetailView extends GetView<RecipeDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            if (controller.mainViewController?.index.value == 2) {
              Get.back();
            } else {
              Get.back(result: controller.refreshList.value);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        title: CustomText(
          txt: '${controller.recipeModel.recipeName}',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontColor: primaryColor,
        ),
        leadingWidth: 55.w,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/half_bg.png",
            ),
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30.h,
              ),
              Image.asset(
                'assets/images/img3.png',
                height: 250.h,
                width: Get.width,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/calories.png',
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomTextM(
                          txt: controller.recipeModel.nutrition[0].calories == "Low"
                              ? "958 kcal"
                              : controller.recipeModel.nutrition[0].calories == "Medium"
                                  ? "1458 kcal"
                                  : "2000 kcal",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        width: 15.w,
                      ),
                      Image.asset(
                        'assets/icons/time.png',
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomTextM(txt: controller.recipeModel.cookingTime, fontSize: 12, fontWeight: FontWeight.w400),
                    ],
                  ),
                  StatefulBuilder(builder: (context, setIconState) {
                    return GestureDetector(
                      onTap: () async {
                        controller.refreshList.value = true;

                        if (controller.recipeModel.bookmarkedBy.contains(UserModel.loggedinUser?.uid)) {
                          await controller.bookmarkRecipes(controller.recipeModel, "");
                          if (controller.mainViewController?.index.value == 2) {
                            Get.back(result: "refreshList");
                          } else {
                            setIconState(() {});
                          }
                        } else {
                          var result = await _saveTo(controller.recipeModel);
                          if (result == "refresh") {
                            setIconState(() {});
                          }
                          print('=================dialog result $result');
                        }
                      },
                      child: controller.recipeModel.bookmarkedBy.contains(UserModel.loggedinUser?.uid)
                          ? Icon(
                              Icons.bookmark,
                              color: primaryColor,
                              size: 30.h,
                            )
                          : Image.asset(
                              'assets/icons/bookmark.png',
                              height: 30.h,
                              width: 30.w,
                            ),
                    );
                  })
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 3.w,
                    ),
                    CircleAvatar(
                      radius: 4.r,
                      backgroundColor: primaryColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomTextM(txt: controller.recipeModel.healthStyle, fontSize: 14, fontWeight: FontWeight.w400),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              controller.tabIndex.value == 0
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            txt: 'Nutritional Value',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 90.h,
                            child: ListView.builder(
                                itemCount: 6,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 120.w,
                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                    margin: EdgeInsets.only(right: 8.w),
                                    decoration: BoxDecoration(color: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8.r)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          txt: index == 0
                                              ? 'Proteins'
                                              : index == 1
                                                  ? 'Carbs'
                                                  : index == 2
                                                      ? 'Calories'
                                                      : index == 3
                                                          ? 'Fats'
                                                          : index == 4
                                                              ? 'Sugar'
                                                              : 'Fiber',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        Divider(
                                          thickness: 1.0,
                                          color: whiteColor,
                                          indent: 10.w,
                                          endIndent: 10.w,
                                        ),
                                        CustomText(
                                          txt: index == 0
                                              ? controller.recipeModel.nutrition[0].protein
                                              : index == 1
                                                  ? controller.recipeModel.nutrition[0].carbohydrates
                                                  : index == 2
                                                      ? controller.recipeModel.nutrition[0].calories
                                                      : index == 3
                                                          ? controller.recipeModel.nutrition[0].fats
                                                          : index == 4
                                                              ? controller.recipeModel.nutrition[0].sugar
                                                              : controller.recipeModel.nutrition[0].fiber,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontColor: primaryColor,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                  : Container(),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                          labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, fontFamily: 'Gotham'),
                          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.sp, fontFamily: 'Gotham'),
                          labelColor: colorThree,
                          unselectedLabelColor: colorSix,
                          indicatorColor: colorThree,
                          indicatorWeight: 1,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.only(bottom: 5.h),
                          tabs: [Text('Ingredients'), Text('Method')]),
                      Expanded(
                        child: TabBarView(children: [
                          _ingrediants(controller.recipeModel.ingredients as List<Ingredients>),
                          _method(controller.recipeModel.steps),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget _ingrediants(List<Ingredients> ingredientsList) {
    return ListView.builder(
        itemCount: ingredientsList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 20.h),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [BoxShadow(color: colorThree.withOpacity(0.3), blurRadius: 10, spreadRadius: 0, offset: Offset(0, 0))]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/2.png'),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    CustomText(
                      txt: ingredientsList[index].ingredientName,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                CustomText(
                  txt: ingredientsList[index].quantity,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          );
        });
  }

  Widget _method(List stepsList) {
    print('=============stepsList.length ${stepsList.length}');
    return ListView.builder(
        itemCount: stepsList.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 20.h),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return GestureDetector(
            /* onTap: () {
              _saveTo();
            },*/
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: colorThree.withOpacity(0.3), blurRadius: 10, spreadRadius: 0, offset: Offset(0, 0))]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor.withOpacity(0.3)),
                    child: Center(
                      child: CustomText(
                        txt: '${index + 1}',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: CustomText(
                      txt: stepsList[index],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      maxLines: 6,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> _saveTo(RecipeModel recipeModel) {
    return Get.bottomSheet(
        ignoreSafeArea: false, //
        Wrap(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(252, 230, 211, 1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
                  image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/save_back.png'))),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomText(
                    txt: 'Save to?',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontColor: primaryColor,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookmarkRecipes(recipeModel, "Breakfast");
                              Get.back(result: "refresh");
                            },
                            child: Chip(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                backgroundColor: primaryColor.withOpacity(0.4),
                                side: BorderSide(color: Colors.transparent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r), bottomLeft: Radius.circular(30.r))),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/breakfast.png',
                                      height: 40.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      txt: 'Breakfast',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookmarkRecipes(recipeModel, "Lunch");
                              Get.back(result: "refresh");
                            },
                            child: Chip(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                backgroundColor: primaryColor.withOpacity(0.4),
                                side: BorderSide(color: Colors.transparent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r), bottomLeft: Radius.circular(30.r))),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/lunch.png',
                                      height: 40.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      txt: 'Lunch',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookmarkRecipes(recipeModel, "Dinner");
                              Get.back(result: "refresh");
                            },
                            child: Chip(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                backgroundColor: primaryColor.withOpacity(0.4),
                                side: BorderSide(color: Colors.transparent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r), bottomLeft: Radius.circular(30.r))),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/dinner.png',
                                      height: 40.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      txt: 'Dinner',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.bookmarkRecipes(recipeModel, "Snacks");
                              Get.back(result: "refresh");
                            },
                            child: Chip(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                backgroundColor: primaryColor.withOpacity(0.4),
                                side: BorderSide(color: Colors.transparent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.r), bottomLeft: Radius.circular(30.r))),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/snacks.png',
                                      height: 40.h,
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    CustomText(
                                      txt: 'Snacks',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
