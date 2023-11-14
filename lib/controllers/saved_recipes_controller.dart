import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../model/recipe_model.dart';
import '../model/saved_recipe_model.dart';
import '../model/user_model.dart';
import '../utils/app_strings.dart';
import '../utils/common_code.dart';
import '../utils/custom_snackbar.dart';
import 'main_view_controller.dart';

class SavedRecipesController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<RecipeModel> savedRecipesList = RxList();

  RxBool isLoading = false.obs;
  RxString mealCategory = "".obs;
  MainViewController? mainViewController;

  @override
  void onInit() {
    mealCategory.value = Get.arguments["mealCategory"];
    mainViewController = Get.arguments["mainViewController"];
  }

  /*  @override
  void update([List<Object>? ids, bool condition = true]) {
    print('=================is in update ');
    getSavedRecipes();
  }*/

  getSavedRecipes() async {
    savedRecipesList.clear();
    try {
      if (await CommonCode().isNetworkAvailable()) {
        QuerySnapshot snapshot = await firebaseFirestore
            .collection(kRecipesCollection)
            .where((Filter.and(Filter("bookmarkedBy", arrayContainsAny: [UserModel.loggedinUser!.uid]), Filter("isActive", isEqualTo: true))))
            .get();
        for (var d in snapshot.docs) {
          RecipeModel model = RecipeModel.fromMap(d.data() as Map<String, dynamic>);
          print('===============recipe model ${model}');
          print('===============favouriteSpecialistsList model ${model.bookmarkedBy}');

          savedRecipesList.add(model);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar(content: kInternetNotAvailable);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      Get.back();
      showCustomSnackBar(content: "Service is not responding, please try again");
    }
  }

  getSavedRecipesByCategory() async {
    savedRecipesList.clear();
    try {
      if (await CommonCode().isNetworkAvailable()) {
        QuerySnapshot savedRecipesSnapshot = await firebaseFirestore
            .collection(kSavedRecipesCollection)
            .where(Filter.and(Filter("mealCategory", isEqualTo: mealCategory.value), Filter("savedBy", isEqualTo: UserModel.loggedinUser?.uid),
                Filter("isActive", isEqualTo: true)))
            .get();
        for (var d in savedRecipesSnapshot.docs) {
          SavedRecipeModel savedRecipeModel = SavedRecipeModel.fromMap(d.data() as Map<String, dynamic>);
          QuerySnapshot snapshot = await firebaseFirestore
              .collection(kRecipesCollection)
              .where((Filter.and(Filter("recipeId", isEqualTo: savedRecipeModel.recipeId),
                  Filter("bookmarkedBy", arrayContainsAny: [UserModel.loggedinUser!.uid]), Filter("isActive", isEqualTo: true))))
              .get();
          for (var d in snapshot.docs) {
            RecipeModel model = RecipeModel.fromMap(d.data() as Map<String, dynamic>);
            print('===============recipe model ${model}');
            print('===============favouriteSpecialistsList model ${model.bookmarkedBy}');

            savedRecipesList.add(model);
          }
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar(content: kInternetNotAvailable);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      Get.back();
      showCustomSnackBar(content: "Service is not responding, please try again");
    }
  }
}
