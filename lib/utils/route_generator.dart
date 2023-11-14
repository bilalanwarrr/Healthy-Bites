import 'package:get/get.dart';
import 'package:healthy/utils/screen_bindings.dart';
import 'package:healthy/views/Auth/SignInView.dart';
import 'package:healthy/views/Auth/SignUpView.dart';
import 'package:healthy/views/BoardingView.dart';
import 'package:healthy/views/DetailView.dart';
import 'package:healthy/views/EditProfileView.dart';
import 'package:healthy/views/Main/MainView.dart';
import 'package:healthy/views/Main/SavedRecipeView.dart';
import 'package:healthy/views/SplashView.dart';

import '../views/FiltersView.dart';
import 'app_strings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kSplashRoute, page: () => SplashView(), binding: ScreenBindings()),
      GetPage(name: kBoardingRoute, page: () => BoardingView(), binding: ScreenBindings()),
      GetPage(name: kLoginRoute, page: () => SignInView(), binding: ScreenBindings()),
      GetPage(name: kSignupRoute, page: () => SignUpView(), binding: ScreenBindings()),
      GetPage(name: kMainRoute, page: () => MainView(), binding: ScreenBindings()),
      GetPage(name: kRecipeDetailsRoute, page: () => DetailView(), binding: ScreenBindings()),
      GetPage(name: kEditProfileRoute, page: () => EditProfileView(), binding: ScreenBindings()),
      GetPage(name: kSavedRecipesListRoute, page: () => SavedRecipeView(), binding: ScreenBindings()),
      GetPage(name: kFiltersRoute, page: () => FiltersView(), binding: ScreenBindings()),
      // GetPage(name: kAddRecipeRoute, page: () => AddRecipeView(), binding: ScreenBindings()),
    ];
  }
}
