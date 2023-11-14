import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/controllers/recipe_controller.dart';
import 'package:healthy/model/user_model.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/views/NotificationView.dart';
import 'package:healthy/widgets/CustomText.dart';
/*
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}*/

class HomeView extends GetView<RecipeController> {
  String searchTxt = '';
  MainViewController mainViewController;

  HomeView({required this.mainViewController});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundImage: UserModel.loggedinUser!.profileImg.isNotEmpty
                            ? NetworkImage(UserModel.loggedinUser!.profileImg)
                            : const AssetImage('assets/images/1.png') as ImageProvider,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      CustomText(
                        txt: UserModel.loggedinUser!.fullName,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationView()));
                    },
                    child: Image.asset(
                      'assets/icons/notifications.png',
                      height: 35.h,
                      width: 35.w,
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/images/recomended_food.png',
              height: 220.h,
              width: Get.width,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txt: 'Recommended For You',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                GestureDetector(
                  onTap: () async {
                    var result = await Get.toNamed(kFiltersRoute);
                    // if (result) {}
                  },
                  child: Image.asset(
                    'assets/icons/filter.png',
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ],
            ),
            Expanded(
              child: StatefulBuilder(builder: (context, setListState) {
                return FutureBuilder(
                    future: controller.getAllRecipes(),
                    builder: (BuildContext context, loadingStatus) {
                      if (loadingStatus.connectionState == ConnectionState.done) {
                        return controller.recipesListAllTemp.isNotEmpty
                            ? Obx(
                                () => ListView.builder(
                                    itemCount: controller.recipesListAllTemp.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 15.h),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          var result = await Get.toNamed(kRecipeDetailsRoute, arguments: {
                                            "recipeModel": controller.recipesListAllTemp[index],
                                            "mainViewController": mainViewController
                                          });
                                          if (result) {
                                            setListState(() {});
                                          }
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailView()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: index == controller.recipesListAllTemp.length - 1 ? 20.0 : 10.0),
                                          width: Get.width,
                                          margin: EdgeInsets.only(bottom: index == (controller.recipesListAllTemp.length - 1) ? 0 : 12.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                controller.recipesListAllTemp[index].recipeImg,
                                                fit: BoxFit.fill,
                                                height: 240.h,
                                                width: double.infinity,
                                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                                  return child;
                                                },
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    height: 100.h,
                                                    child: const Center(
                                                      child: CircularProgressIndicator(
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, url, error) => SizedBox(
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Center(
                                                    child: CustomText(
                                                      txt: "Unable to load Image",
                                                      fontWeight: FontWeight.w300,
                                                      fontColor: whiteColor,
                                                    ),
                                                  ),
                                                ),
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
                                                        txt: controller.recipesListAllTemp[index].recipeName,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      controller.recipesListAllTemp[index].bookmarkedBy.contains(UserModel.loggedinUser?.uid)
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
                                                          txt: controller.recipesListAllTemp[index].nutrition[0].calories == "Low"
                                                              ? "958 kcal"
                                                              : controller.recipesListAllTemp[index].nutrition[0].calories == "Medium"
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
                                                          txt: '${controller.recipesListAllTemp[index].cookingTime}',
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
                                    }),
                              )
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
        ));
  }
}

const itemsList = [
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img3.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img4.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img3.png'},
  {'title': 'Achard de papaye', 'loc': 'Lorem ipsum dolor augue amet', 'img': 'assets/images/img4.png'}
];
