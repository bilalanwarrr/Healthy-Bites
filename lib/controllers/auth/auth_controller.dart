import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/main.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/utils/loading_dialoge.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../model/user_model.dart';
import '../../utils/common_code.dart';
import '../../utils/custom_snackbar.dart';

class AuthController extends GetxController {
  TextEditingController tecEmail = TextEditingController(),
      tecPassword = TextEditingController(),
      tecFullName = TextEditingController(),
      tecConfirmPassword = TextEditingController();
  FocusNode fnEmail = FocusNode(),
      fnPassword = FocusNode(),
      fnFullName = FocusNode(),
      fnConfirmPassword = FocusNode();
  RxBool emailErrorVisible = false.obs,
      passwordErrorVisible = false.obs,
      fullNameErrorVisible = false.obs,
      confirmPasswordErrorVisible = false.obs,
      isLoading = false.obs;
  RxString emailErrorMessage = 'Email field is required'.obs,
      passwordErrorMessage = 'Email field is required'.obs,
      fullNameErrorMessage = 'Email field is required'.obs,
      confirmPasswordErrorMessage = 'Email field is required'.obs;

  @override
  void onInit() {
    print('=========onint');
    tecEmail = TextEditingController();
    tecPassword = TextEditingController();
    tecFullName = TextEditingController();
    tecConfirmPassword = TextEditingController();
  }

  bool emailValidation() {
    print(
        '=================valid ${CommonCode.isValidEmail(tecEmail.text.trim())}');
    if (tecEmail.text.trim().isEmpty) {
      emailErrorVisible.value = true;
      emailErrorMessage.value = "Email field is required";
    } else if (tecEmail.text.trim().isNotEmpty &&
        !CommonCode.isValidEmail(tecEmail.text.trim())) {
      print('============inside else if');
      emailErrorVisible.value = true;
      emailErrorMessage.value = "Enter a valid email";
    } else {
      emailErrorVisible.value = false;
      emailErrorMessage.value = "";
      return true;
    }
    return false;
  }

  bool passwordValidation() {
    if (tecPassword.text.trim().isEmpty) {
      passwordErrorVisible.value = true;
      passwordErrorMessage.value = "Password field is required";
    } /*else if (!CommonCode.isValidEmail(tecEmail.text.trim())) {
      emailErrorVisible.value = true;
      emailErrorMessage.value = "Enter a valid email";
    }*/
    else {
      passwordErrorVisible.value = false;
      passwordErrorMessage.value = "";
      return true;
    }
    return false;
  }

  bool confirmPasswordValidation() {
    if (tecConfirmPassword.text.trim().isEmpty) {
      confirmPasswordErrorVisible.value = true;
      confirmPasswordErrorMessage.value = "Confirm Password field is required";
    } else if (tecConfirmPassword.text.trim() != tecPassword.text.trim()) {
      confirmPasswordErrorVisible.value = true;
      confirmPasswordErrorMessage.value =
          "Confirm password should be same as password";
    } else {
      confirmPasswordErrorVisible.value = false;
      confirmPasswordErrorMessage.value = "";
      return true;
    }
    return false;
  }

  bool fullNameValidation() {
    if (tecFullName.text.trim().isEmpty) {
      fullNameErrorVisible.value = true;
      fullNameErrorMessage.value = "FullName field is required";
    } else {
      fullNameErrorVisible.value = false;
      fullNameErrorMessage.value = "";
      return true;
    }
    return false;
  }

  checkValues({bool isSignUp = false}) async {
    isLoading.value = true;
    showLoadingDialogCustom();
    if (((isSignUp && (fullNameValidation() && confirmPasswordValidation())) ||
            !isSignUp) &&
        emailValidation() &&
        passwordValidation()) {
      bool? net = await CommonCode().isNetworkAvailable();
      if (net) {
        print(
            '=====================isSign Up $isSignUp : fname ${tecFullName.text.trim()}, Email ${tecEmail.text.trim()}, password : ${tecPassword.text.trim()} ');
        if (isSignUp) {
          await signup(tecEmail.text.trim(), tecFullName.text.trim(),
              tecPassword.text.trim());
        } else {
          await login(
              email: tecEmail.text.trim(), password: tecPassword.text.trim());
        }
      } else {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar(content: kInternetNotAvailable);
      }
    } else {
      isLoading.value = false;
      Get.back();
      showCustomSnackBar(
        content: 'Enter all data in valid format',
      );
    }
  }

  Future login({required String email, required String password}) async {
    try {
      // FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential? user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        await FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(user.user!.uid)
            .update({"deviceToken": userDeviceToken});
        await FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(user.user!.uid)
            .get()
            .then((value) async {
          log('user profile data is \n${value.data()}');
          if (value.data() != null) {
            UserModel newUser = UserModel(
                uid: user.user!.uid,
                fullName: value.data()!['fullName'],
                email: value.data()!['email'],
                profileImg: value.data()!['profileImg'],
                deviceToken: value.data()!["deviceToken"]);
            if (value.data()!["isActive"]) {
              UserModel.loggedinUser = newUser;
              await sendPushMessage(
                  title: "$kAppName - Access Alert",
                  body:
                      "Dear user, you have accessed app at ${DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now())}");
              await FirebaseMessaging.instance.subscribeToTopic("newRecipes");
              isLoading.value = false;
              Get.back();
              Get.toNamed(kMainRoute);
              //NavigationService().replaceScreen(MainView());
            } else {
              Get.back();
              showCustomSnackBar(content: 'User Not Found!');
            }
          }
        }).onError((error, stackTrace) {
          Get.back();
          log("=========on error ${error.toString()}");
        });
      }

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      log('firebase auth expcetion ${e.toString()}');
      Get.back();
      if (e.code == "invalid-email") {
        showCustomSnackBar(content: 'Invalid Email!');
      } else if (e.code == "user-disabled") {
        showCustomSnackBar(content: 'User Disabled!');
      } else if (e.code == "user-not-found") {
        showCustomSnackBar(content: 'User Not Found!');
      } else if (e.code == "wrong-password") {
        showCustomSnackBar(content: 'Wrong Password!');
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        showCustomSnackBar(content: 'Invalid Login Credentials');
      } else {
        showCustomSnackBar(content: e.code);
      }

      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;

      log("============ex ${e.toString()}");
    }
  }

  Future<void> signup(
    String email,
    String fullName,
    String password,
  ) async {
    UserCredential? credentials;

    try {
      print('signing up');
      credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credentials != null) {
        String uid = credentials.user!.uid;
        UserModel userModel = UserModel(
            uid: uid,
            fullName: fullName,
            email: email,
            profileImg: UserModel.defaultProfilePic,
            isActive: true,
            deviceToken: userDeviceToken);

        await FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(uid)
            .set(userModel.toMap())
            .then(
          (value) async {
            UserModel.loggedinUser = userModel;
            //Get.back();
            // NavigationService().goBack();
            showCustomSnackBar(
              content: 'New user created!',
            );
            await sendPushMessage(
                title: "$kAppName - Access Alert",
                body:
                    "Dear user, you have accessed app at ${DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now())}");
            await FirebaseMessaging.instance.subscribeToTopic("newRecipes");
            // UserModel.loggedinUser = userModel;
            Get.back();
            Get.toNamed(kMainRoute);

            isLoading.value = false;
          },
        );
      }
    } on FirebaseAuthException catch (ex) {
      Get.back();
      print('expextion: ${ex.message}');
      if (ex.code == "weak-password") {
        showCustomSnackBar(content: 'Password should be at least 6 characters');
      } else {
        showCustomSnackBar(
          content: ex.code.toString(),
        );
      }

      isLoading.value = false;
    }
  }

  Future sendResetEmail({required String email}) async {
    isLoading.value = true;
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar(content: 'Reset email sent successfully');
      }).onError((error, stackTrace) {
        isLoading.value = false;
        Get.back();
        showCustomSnackBar(content: 'Error sending reset email');
      });
    } on FirebaseAuthException catch (e) {
      log('firebase auth expcetion ${e.toString()}');
      Get.back();
      if (e.code == "invalid-email") {
        showCustomSnackBar(content: 'Invalid Email!');
      } else if (e.code == "user-disabled") {
        showCustomSnackBar(content: 'User Disabled!');
      } else if (e.code == "user-not-found") {
        showCustomSnackBar(content: 'User Not Found!');
      } else if (e.code == "wrong-password") {
        showCustomSnackBar(content: 'Wrong Password!');
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        showCustomSnackBar(content: 'Invalid Login Credentials');
      } else {
        showCustomSnackBar(content: e.code);
      }
      isLoading.value = false;
    } catch (e) {
      Get.back();
      isLoading.value = false;

      log("============ex ${e.toString()}");
    }
  }
}
