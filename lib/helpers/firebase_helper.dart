import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:healthy/utils/app_strings.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../utils/loading_dialoge.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;
    print("================uuid for getting user model $uid");
    DocumentSnapshot docsnap = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    print('=======snapshot data for user ${docsnap.data()}');
    if (docsnap.data() != null) {
      userModel = UserModel.fromMap(docsnap.data() as Map<String, dynamic>);
      return userModel;
    } else {
      return userModel;
    }
  }

  static logout() async {
    showLoadingDialogCustom(title: 'Logging out');
    await FirebaseAuth.instance.signOut();

    Get.offNamedUntil(kLoginRoute, (route) => false);
    //Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => loginScreen()), (route) => false);
  }

  static getDietTypes() async {
    healthyStyles.clear();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("diet_types").where("isActive", isEqualTo: true).get();
      for (var d in snapshot.docs) {
        var dietData = d.data() as Map<String, dynamic>;
        healthyStyles.add(dietData["typeName"]);
        print('============dietData $dietData');
      }
    } catch (e) {
      print(e);
    }
  }

  static getDailyRegimens() async {
    dailyRegimens.clear();
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("daily_regimens").where("isActive", isEqualTo: true).get();
      for (var d in snapshot.docs) {
        var dietData = d.data() as Map<String, dynamic>;
        dailyRegimens.add(dietData["categoryName"]);
        print('============dietData $dietData');
      }
    } catch (e) {
      print(e);
    }
  }
}
