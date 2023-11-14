import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/saved_recipes_controller.dart';
import 'package:healthy/widgets/CustomText.dart';

import '../../utils/app_strings.dart';

/*class SavedRecipeView extends StatefulWidget {
  const SavedRecipeView({Key? key}) : super(key: key);

  @override
  State<SavedRecipeView> createState() => _SavedRecipeViewState();
}*/

class SavedRecipeView extends GetView<SavedRecipesController> {
  //SavedRecipeView({required this.mainViewController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
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
      body: SafeArea(
        child: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              children: [
                Expanded(
                  child: StatefulBuilder(builder: (context, setListState) {
                    return FutureBuilder(
                        future: controller.getSavedRecipesByCategory(),
                        builder: (BuildContext context, loadingStatus) {
                          if (loadingStatus.connectionState == ConnectionState.done) {
                            return controller.savedRecipesList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: controller.savedRecipesList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 15.h),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          var result = await Get.toNamed(kRecipeDetailsRoute, arguments: {
                                            "recipeModel": controller.savedRecipesList[index],
                                            "mainViewController": controller.mainViewController
                                          });
                                          print('==============result $result');
                                          if (result == "refreshList") {
                                            setListState(() {});
                                          }
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: index == controller.savedRecipesList.length - 1 ? 20.0 : 10.0),
                                          width: Get.width,
                                          margin: EdgeInsets.only(bottom: index == (itemsList.length - 1) ? 0 : 12.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                itemsList[index]['img']!,
                                                fit: BoxFit.fill,
                                                height: 240.h,
                                                width: double.infinity,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        txt: controller.savedRecipesList[index].recipeName,
                                                        fontSize: 20,
                                                        fontFamily: "Gothm-Medium",
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
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
                                                          txt: controller.savedRecipesList[index].nutrition[0].calories == "Low"
                                                              ? "958 kcal"
                                                              : controller.savedRecipesList[index].nutrition[0].calories == "Medium"
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
                                                      CustomTextM(
                                                          txt: '${controller.savedRecipesList[index].cookingTime}',
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: CustomText(
                                        txt: "Recipes not found",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                          ;
                        });
                  }),
                ),
              ],
            )),
      ),
    );
  }
}

const itemsList = [
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img3.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img4.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img3.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img4.png'}
];
