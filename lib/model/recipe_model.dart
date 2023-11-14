import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  String recipeId = "";
  String recipeName = "";
  String dailyRegimen = "";
  String healthStyle = "";
  String cookingTime = "";
  List<dynamic> nutrition = const [];
  List<dynamic> ingredients = const [];
  List<dynamic> recommendedFor = const [];
  List<dynamic> bookmarkedBy = const [];
  List<dynamic> steps = const [];
  String recipeImg = defaultProfilePic;
  bool isActive = true;
  String createdBy = "";
  Timestamp createdAt = Timestamp.fromDate(DateTime.now());
  String updatedBy = "";
  Timestamp updatedAt = Timestamp.fromDate(DateTime.now());

  RecipeModel.name();

  @override
  String toString() {
    return 'RecipeModel{recipeId: $recipeId, recipeName: $recipeName, dailyRegimen: $dailyRegimen, healthStyle: $healthStyle, cookingTime: $cookingTime, nutrition: $nutrition, ingredients: $ingredients, recommendedFor: $recommendedFor, bookmarkedBy: $bookmarkedBy, steps: $steps, recipeImg: $recipeImg, isActive: $isActive, createdBy: $createdBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt}';
  }

  RecipeModel.fromMap(Map<String, dynamic> map) {
    recipeId = map["recipeId"] ?? "";
    recipeName = map["recipeName"] ?? "";
    dailyRegimen = map["dailyRegimen"] ?? "";
    healthStyle = map["healthStyle"] ?? "";
    cookingTime = map["cookingTime"] ?? "";
    nutrition = map["nutrition"] ?? <Nutrition>[];
    nutrition = List<Nutrition>.from(map["nutrition"].map((x) => Nutrition.fromMap(x))) ?? <Nutrition>[];
    ingredients = List<Ingredients>.from(map["ingredients"].map((x) => Ingredients.fromMap(x))) ?? <Ingredients>[];
    steps = map["steps"] ?? <String>[];
    recommendedFor = map["recommendedFor"] ?? [];
    bookmarkedBy = map["bookmarkedBy"] ?? [];
    recipeImg = map["recipeImg"] ?? "";
    isActive = map["isActive"] ?? true;
    createdBy = map["createdBy"] ?? "";
    createdAt = map["createdAt"] ?? Timestamp.fromDate(DateTime.now());
    updatedBy = map["updatedBy"] ?? "";
    updatedAt = map["updatedAt"] ?? Timestamp.fromDate(DateTime.now());
  }
  Map<String, dynamic> toMap() {
    return {
      "recipeId": recipeId,
      "recipeName": recipeName,
      "dailyRegimen": dailyRegimen,
      "healthStyle": healthStyle,
      "cookingTime": cookingTime,
      "nutrition": List<dynamic>.from(nutrition.map((x) => x.toMap())),
      "ingredients": List<dynamic>.from(ingredients.map((x) => x.toMap())),
      "steps": steps,
      "recipeImg": recipeImg,
      "isActive": isActive,
      "createdBy": createdBy,
      "createdAt": createdAt,
      "updatedBy": updatedBy,
      "updatedAt": updatedAt,
      "bookmarkedBy": bookmarkedBy,
      "recommendedFor": recommendedFor,
    };
  }

  static String defaultProfilePic =
      "https://firebasestorage.googleapis.com/v0/b/healthy-bites-700c9.appspot.com/o/recipeImages%2Fimg3.png?alt=media&token=bf1d11ee-294b-42dd-86e1-eefcff6eacbb";
}

class Nutrition {
  String calories = "";
  String fiber = "";
  String fats = "";
  String protein = "";
  String sugar = "";
  String carbohydrates = "";

  Nutrition.name();

  @override
  String toString() {
    return 'Nutrition{calories: $calories, fiber: $fiber, fats: $fats, protein: $protein, sugar: $sugar, carbohydrates: $carbohydrates}';
  }

  Nutrition.fromMap(Map<String, dynamic> map) {
    calories = map["calories"] ?? "";
    fiber = map["fiber"] ?? "";
    fats = map["fats"] ?? "";
    protein = map["protein"] ?? "";
    sugar = map["sugar"] ?? "";
    carbohydrates = map["carbohydrates"] ?? "";
  }
  Map<String, dynamic> toMap() {
    return {
      "calories": calories,
      "fiber": fiber,
      "fats": fats,
      "protein": protein,
      "sugar": sugar,
      "carbohydrates": carbohydrates,
    };
  }
}

class Ingredients {
  String ingredientName = "";
  String quantity = "";

  Ingredients.name();

  @override
  String toString() {
    return 'Ingredients{ingredientName: $ingredientName, quantity: $quantity}';
  }

  Ingredients.fromMap(Map<String, dynamic> map) {
    ingredientName = map["ingredientName"] ?? "";
    quantity = map["quantity"] ?? "0";
  }
  Map<String, dynamic> toMap() {
    return {
      "ingredientName": ingredientName,
      "quantity": quantity,
    };
  }
}
