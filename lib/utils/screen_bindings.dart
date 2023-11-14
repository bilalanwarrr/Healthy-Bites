import 'package:get/get.dart';
import 'package:healthy/controllers/auth/auth_controller.dart';
import 'package:healthy/controllers/main_view_controller.dart';
import 'package:healthy/controllers/profile_conftroller.dart';
import 'package:healthy/controllers/recipe_controller.dart';
import 'package:healthy/controllers/recipe_details_controller.dart';
import 'package:healthy/controllers/saved_recipes_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainViewController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => RecipeController());
    Get.lazyPut(() => RecipeDetailsController());
    Get.lazyPut(() => SavedRecipesController());
    Get.lazyPut(() => ProfileController());
  }
}
