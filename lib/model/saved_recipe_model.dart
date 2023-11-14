import 'package:cloud_firestore/cloud_firestore.dart';

class SavedRecipeModel {
  String savedRecipeId = "";
  String recipeId = "";
  String mealCategory = "";
  bool isActive = true;
  String savedBy = "";
  Timestamp createdAt = Timestamp.fromDate(DateTime.now());
  String updatedBy = "";
  Timestamp updatedAt = Timestamp.fromDate(DateTime.now());

  SavedRecipeModel.name();

  @override
  String toString() {
    return 'SavedRecipeModel{savedRecipeId: $savedRecipeId, recipeId: $recipeId, mealCategory: $mealCategory, isActive: $isActive, savedBy: $savedBy, createdAt: $createdAt, updatedBy: $updatedBy, updatedAt: $updatedAt}';
  }

  SavedRecipeModel.fromMap(Map<String, dynamic> map) {
    savedRecipeId = map["savedRecipeId"] ?? "";
    recipeId = map["recipeId"] ?? "";
    mealCategory = map["mealCategory"] ?? "";
    isActive = map["isActive"] ?? true;
    savedBy = map["savedBy"] ?? "";
    createdAt = map["createdAt"] ?? Timestamp.fromDate(DateTime.now());
    updatedBy = map["updatedBy"] ?? "";
    updatedAt = map["updatedAt"] ?? Timestamp.fromDate(DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      "savedRecipeId": savedRecipeId,
      "recipeId": recipeId,
      "mealCategory": mealCategory,
      "isActive": isActive,
      "savedBy": savedBy,
      "createdAt": createdAt,
      "updatedBy": updatedBy,
      "updatedAt": updatedAt,
    };
  }
}
