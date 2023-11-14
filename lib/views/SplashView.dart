import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/utils/app_strings.dart';

import '../model/user_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    if (UserModel.loggedinUser != null) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offAndToNamed(kMainRoute);
      });
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Get.offAndToNamed(kBoardingRoute);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => BoardingView()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
