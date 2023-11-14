import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/model/saved_recipe_model.dart';

import '../constant.dart';
import '../main.dart';
import '../model/recipe_model.dart';
import '../model/user_model.dart';
import '../utils/app_strings.dart';
import '../utils/common_code.dart';
import '../utils/custom_snackbar.dart';

class RecipeDetailsController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RecipeModel recipeModel = RecipeModel.name();
  RxInt tabIndex = 0.obs;
  RxBool isLoading = false.obs, refreshList = false.obs;
  MainViewController? mainViewController;
  @override
  void onInit() {
    super.onInit();
    recipeModel = Get.arguments["recipeModel"];
    mainViewController = Get.arguments["mainViewController"];
  }

  bookmarkRecipes(RecipeModel recipeModel, String mealCategory) async {
    try {
      if (await CommonCode().isNetworkAvailable()) {
        bool isBookMarked = recipeModel.bookmarkedBy.contains(UserModel.loggedinUser?.uid);
        isBookMarked ? recipeModel.bookmarkedBy.remove(UserModel.loggedinUser?.uid) : recipeModel.bookmarkedBy.add(UserModel.loggedinUser?.uid);

        await firebaseFirestore.collection(kRecipesCollection).doc(recipeModel.recipeId).update({"bookmarkedBy": recipeModel.bookmarkedBy});

        if (!isBookMarked) {
          String savedRecipeID = "";
          savedRecipeID = "SR${uuid.v4().toString().replaceAll("-", "").substring(0, 9).toUpperCase()}";
          SavedRecipeModel savedRecipeModel = SavedRecipeModel.name();
          savedRecipeModel.savedRecipeId = savedRecipeID;
          savedRecipeModel.recipeId = recipeModel.recipeId;
          savedRecipeModel.mealCategory = mealCategory;
          savedRecipeModel.savedBy = UserModel.loggedinUser!.uid;
          await firebaseFirestore.collection(kSavedRecipesCollection).doc(savedRecipeID).set(
                savedRecipeModel.toMap(),
              );
        } else {
          QuerySnapshot snapshot = await firebaseFirestore
              .collection(kSavedRecipesCollection)
              .where(Filter.and(Filter("recipeId", isEqualTo: recipeModel.recipeId), Filter("savedBy", isEqualTo: UserModel.loggedinUser?.uid)))
              .get();
          for (var d in snapshot.docs) {
            SavedRecipeModel savedRecipeModel = SavedRecipeModel.fromMap(d.data() as Map<String, dynamic>);
            await firebaseFirestore.collection(kSavedRecipesCollection).doc(savedRecipeModel.savedRecipeId).delete();
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
