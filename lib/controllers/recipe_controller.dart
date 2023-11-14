import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/model/recipe_model.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../utils/app_strings.dart';
import '../utils/common_code.dart';
import '../utils/custom_snackbar.dart';
import '../utils/loading_dialoge.dart';
import '../views/Main/AddRecipeView.dart';

class RecipeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxInt step = 1.obs;
  TextEditingController tecRecipeName = TextEditingController(), tecIngredientName = TextEditingController();

  FocusNode fnRecipeName = FocusNode(), tfnIngredientName = FocusNode();

  RxList<TextEditingController> tecStepsList = RxList(), tecIngredientsList = RxList(), tecQuantitiesList = RxList();
  RxList<FocusNode> fnStepsList = RxList(), fnIngredientsList = RxList();
  RxString dailyReg = ''.obs, healthyStyle = ''.obs, cookingTime = ''.obs;
  RxString calLevel = ''.obs, fibLevel = ''.obs, protLevel = ''.obs, fatLevel = ''.obs, sugLevel = ''.obs, carbLevel = ''.obs, quantity = ''.obs;

  RxList moreIngList = <Widget>[].obs;
  RxList moreHowList = <Widget>[].obs;
  RxList<String> quantityList = RxList();

  RecipeModel recipeModel = RecipeModel.name();
  RxList<RecipeModel> recipesListAll = RxList(), recipesListAllTemp = RxList();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('==============on init');
    resetAllData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('------++++-------I am disposing');
  }

  @override
  void onReady() {
    super.onReady();
    print('-----------hey I am ready');
  }

  onHealthStyleDropDownChange(val) {
    healthyStyle.value = val.toString();
  }

  onDailyRegimenDropDownChange(val) {
    dailyReg.value = val.toString();
  }

  onCookingTimeDropDownChange(val) {
    cookingTime.value = val.toString();
  }

  onCaloriesDropDownChange(val) {
    calLevel.value = val.toString();
  }

  onFibersDropDownChange(val) {
    fibLevel.value = val.toString();
  }

  onProteinDropDownChange(val) {
    protLevel.value = val.toString();
  }

  onFatsDropDownChange(val) {
    fatLevel.value = val.toString();
  }

  onSugarDropDownChange(val) {
    sugLevel.value = val.toString();
  }

  onCarbohydratesDropDownChange(val) {
    carbLevel.value = val.toString();
  }

  onQuantityDropDownChange(val) {
    quantity.value = val.toString();
  }

  addData(MainViewController mainViewController) async {
    showLoadingDialogCustom(title: "Adding Recipe...");
    isLoading.value = true;
    print('inside add data');
    recipeModel.recipeName = tecRecipeName.text;
    recipeModel.dailyRegimen = dailyReg.value;
    recipeModel.healthStyle = healthyStyle.value;
    recipeModel.cookingTime = cookingTime.value;

    Nutrition nutrition = Nutrition.name();
    nutrition.calories = calLevel.value;
    nutrition.fiber = fibLevel.value;
    nutrition.protein = protLevel.value;
    nutrition.fats = fatLevel.value;
    nutrition.sugar = sugLevel.value;
    nutrition.carbohydrates = carbLevel.value;
    List<Nutrition> listNutrition = [];
    listNutrition.add(nutrition);
    recipeModel.nutrition = listNutrition;

    List<Ingredients> listIngredients = [];
    for (int ing = 0; ing < tecIngredientsList.length; ing++) {
      Ingredients ingredients = Ingredients.name();
      if (tecIngredientsList[ing].text.isNotEmpty) {
        ingredients.ingredientName = tecIngredientsList[ing].text;
        ingredients.quantity = "${tecQuantitiesList[ing].text} ${quantityList[ing]}";

        listIngredients.add(ingredients);
      }
    }
    recipeModel.ingredients = listIngredients;
    print('===========adding in process');
    List<String> listSteps = [];
    for (int st = 0; st < tecStepsList.length; st++) {
      if (tecStepsList[st].text.isNotEmpty) {
        listSteps.add(tecStepsList[st].text);
      }
    }
    recipeModel.steps = listSteps;
    print('==================data ${recipeModel.toString()}');

    try {
      if (await CommonCode().isNetworkAvailable()) {
        String uid = "";
        uid = "R${uuid.v4().toString().replaceAll("-", "").substring(0, 9).toUpperCase()}";
        recipeModel.recipeId = uid;
        recipeModel.createdBy = UserModel.loggedinUser!.uid;

        await firebaseFirestore.collection(kRecipesCollection).doc(uid).set(recipeModel.toMap());
        await sendPushMessageToTopic(
            topic: 'newRecipes',
            title: "New-Recipe-Alert",
            body: "Dear Users, new recipe ${recipeModel.recipeName} is added. Click to open the app to see the details.");
        isLoading.value = false;
        Get.back();
        Get.back();
        resetAllData();
        mainViewController.index.value = 0;
        showCustomSnackBar(content: "Congratulations, your recipe added successfully");
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

  getAllRecipes() async {
    recipesListAll.clear();
    try {
      if (await CommonCode().isNetworkAvailable()) {
        QuerySnapshot snapshot = await firebaseFirestore.collection(kRecipesCollection).where("isActive", isEqualTo: true).get();
        for (var d in snapshot.docs) {
          RecipeModel model = RecipeModel.fromMap(d.data() as Map<String, dynamic>);
          print('===============recipe model ${model}');
          print('===============favouriteSpecialistsList model ${model.bookmarkedBy}');
          recipesListAll.add(model);
        }
        recipesListAllTemp = recipesListAll;
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

  bookmarkRecipes(RecipeModel recipeModel) async {
    try {
      if (await CommonCode().isNetworkAvailable()) {
        bool isBookMarked = recipeModel.bookmarkedBy.contains(UserModel.loggedinUser?.uid);
        isBookMarked ? recipeModel.bookmarkedBy.remove(UserModel.loggedinUser?.uid) : recipeModel.bookmarkedBy.add(UserModel.loggedinUser?.uid);

        await firebaseFirestore.collection(kRecipesCollection).doc(recipeModel.recipeId).update({"bookmarkedBy": recipeModel.bookmarkedBy});

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

  resetAllData() {
    step = 1.obs;
    tecRecipeName = TextEditingController();
    tecIngredientName = TextEditingController();
    fnRecipeName = FocusNode();
    tfnIngredientName = FocusNode();
    tecStepsList.clear();
    tecIngredientsList.clear();
    tecQuantitiesList.clear();
    fnStepsList.clear();
    fnIngredientsList.clear();
    calLevel.value = levels.first;
    fibLevel.value = levels.first;
    protLevel.value = levels.first;
    fatLevel.value = levels.first;
    sugLevel.value = levels.first;
    carbLevel.value = levels.first;
    dailyReg.value = dailyRegimens.first;
    healthyStyle.value = healthyStyles.first;
    cookingTime.value = cookingTimes.first;
    moreIngList = <Widget>[].obs;
    moreHowList = <Widget>[].obs;
    quantityList.clear();

    recipeModel = RecipeModel.name();

    for (int i = 0; i <= 2; i++) {
      tecStepsList.add(TextEditingController());
      fnStepsList.add(FocusNode());
      moreHowList.add(StepsTextWidget(controller: this, index: i));
    }
    for (int i = 0; i <= 2; i++) {
      tecIngredientsList.add(TextEditingController());
      tecQuantitiesList.add(TextEditingController(text: "0"));
      quantityList.add(quantities.first);
      fnIngredientsList.add(FocusNode());
      // moreIngList.add(StepsTextWidget(controller: this, index: i));
      moreIngList.add(IngredientsWidget(
        controller: this,
        index: i,
      ));
    }
  }

  applyFilters() {
    recipesListAllTemp.value = recipesListAll
        .where((record) => dailyReg.value.isNotEmpty ? record.dailyRegimen == dailyReg.value : record.dailyRegimen == record.dailyRegimen)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) => healthyStyle.value.isNotEmpty ? record.healthStyle == healthyStyle.value : record.healthStyle == record.healthStyle)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) => cookingTime.value.isNotEmpty ? record.cookingTime == cookingTime.value : record.cookingTime == record.cookingTime)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) =>
            calLevel.value.isNotEmpty ? record.nutrition[0].calories == calLevel.value : record.nutrition[0].calories == record.nutrition[0].calories)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) =>
            fibLevel.value.isNotEmpty ? record.nutrition[0].fiber == fibLevel.value : record.nutrition[0].fiber == record.nutrition[0].fiber)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) =>
            protLevel.value.isNotEmpty ? record.nutrition[0].protein == protLevel.value : record.nutrition[0].protein == record.nutrition[0].protein)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where(
            (record) => fatLevel.value.isNotEmpty ? record.nutrition[0].fats == fatLevel.value : record.nutrition[0].fats == record.nutrition[0].fats)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) =>
            sugLevel.value.isNotEmpty ? record.nutrition[0].sugar == sugLevel.value : record.nutrition[0].sugar == record.nutrition[0].sugar)
        .toList();

    recipesListAllTemp.value = recipesListAll
        .where((record) => carbLevel.value.isNotEmpty
            ? record.nutrition[0].carbohydrates == carbLevel.value
            : record.nutrition[0].carbohydrates == record.nutrition[0].carbohydrates)
        .toList();

    Get.back(result: true);
  }
}

const cookingTimes = ['30 minutes', '1 hour', '2 hour', "3 Hours", "45 minutes"];
const levels = ['Low', 'High', 'Medium'];
const quantities = ['cup', 'mg', 'g'];
