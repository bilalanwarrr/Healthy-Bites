import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:healthy/helpers/firebase_helper.dart';
import 'package:healthy/utils/loading_dialoge.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../constant.dart';
import '../helpers/permission_service.dart';
import '../model/user_model.dart';
import '../utils/app_strings.dart';
import '../utils/common_code.dart';
import '../utils/custom_snackbar.dart';

class ProfileController extends GetxController {
  TextEditingController tecFullName = TextEditingController(),
      tecEmail = TextEditingController(),
      tecPassword = TextEditingController(),
      dobTxt = TextEditingController(),
      nationalityTxt = TextEditingController();

  FocusNode fnEmail = FocusNode(),
      fnPassword = FocusNode(),
      fnFullName = FocusNode(),
      fnConfirmPassword = FocusNode();
  RxBool emailErrorVisible = false.obs,
      passwordErrorVisible = false.obs,
      fullNameErrorVisible = false.obs,
      confirmPasswordErrorVisible = false.obs,
      isLoading = false.obs,
      isEmailOrPasswordUpdated = false.obs;
  RxString emailErrorMessage = 'Email field is required'.obs,
      passwordErrorMessage = 'Email field is required'.obs,
      fullNameErrorMessage = 'Email field is required'.obs,
      confirmPasswordErrorMessage = 'Email field is required'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tecFullName.text = UserModel.loggedinUser!.fullName;
    tecEmail.text = UserModel.loggedinUser!.email;
    tecPassword.text = UserModel.loggedinUser!.password;
  }

  //Image
  File _image = File("");
  File _imagesList = File("");
  String imageNameList = '';
  final picker = ImagePicker();
  RxString profileImgURL = "".obs;

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

  Future<void> checkDataValues() async {
    isLoading.value = true;
    showLoadingDialogCustom();
    if (fullNameValidation() && emailValidation() && passwordValidation()) {
      Map<String, dynamic> userData = {
        "fullName": tecFullName.text,
        "email": tecEmail.text,
        "password": tecPassword.text,
        "profileImg": profileImgURL.value.isNotEmpty
            ? profileImgURL.value
            : UserModel.loggedinUser!.profileImg,
        "updatedAt": Timestamp.fromDate(DateTime.now()),
      };
      String result = await updateUserProfile(userData);
      print('==========result $result');
      Get.back();
      if (result == "Success") {
        showCustomSnackBar(content: "Profile Details updated successfully");
        if (isEmailOrPasswordUpdated.isTrue) {
          FirebaseHelper.logout();
        }
      } else if (result == "Failure") {
        showCustomSnackBar(
            content: "Service is not responding, please try again");
      }

      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.back();
      showCustomSnackBar(
        content: 'Enter all data in valid format',
      );
    }
  }

  Future<String> updateUserProfile(Map<String, dynamic> userData) async {
    // showLoadingDialogCustom(title: 'Please wait...');
    if (await CommonCode().isNetworkAvailable()) {
      try {
        await FirebaseFirestore.instance
            .collection(kUsersCollection)
            .doc(UserModel.loggedinUser!.uid)
            .update(userData);
        print(
            '======email updated ${tecEmail.text != UserModel.loggedinUser!.email}');
        print(
            '======password updated ${tecPassword.text != UserModel.loggedinUser!.password}');
        /*if (tecEmail.text != UserModel.loggedinUser!.email) {
          isEmailOrPasswordUpdated.value = true;
          await FirebaseAuth.instance.currentUser?.updateEmail(tecEmail.text);
        }
        if (tecPassword.text != UserModel.loggedinUser!.password) {
          isEmailOrPasswordUpdated.value = true;
          await FirebaseAuth.instance.currentUser?.updatePassword(tecPassword.text);
        }*/
        UserModel.loggedinUser = UserModel.fromMap(userData);
        return "Success";
      } catch (e) {
        print(e);
        return "Failure";
      }
    } else {
      print('===============inside else');
      // value.isLoading.value = false;
      showCustomSnackBar(content: kInternetNotAvailable);
      Get.back();
      return "Fail";
    }
  }

  //For Image

  void showUploadImageDialog() {
    Get.dialog(
        barrierDismissible: false,
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.white),
            //padding: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        openGallery();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                              'assets/images/gallery_icon.png',
                            ),
                            height: 70,
                            width: 70,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Gallery',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        openCamera();
                        //getImage(ImageSource.camera);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/camera_icon.png'),
                            height: 70,
                            width: 70,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Camera',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  void openCamera() {
    PermissionsService().hasCameraPermission().then((hasPermission) {
      if (hasPermission != null && hasPermission) {
        getImage(ImageSource.camera);
      } else {
        PermissionsService().requestCameraPermission(onPermissionDenied: () {
          showCustomSnackBar(
              content:
                  "Dear user, please go to the settings to enable camera access permission, in order to capture project images.");
          /*AppDialogs().errorDialog(
              title: "Permission not Granted",
              buttonText: 'OK',
              errorText:
                  "Dear user, please go to the settings to enable camera access permission, in order to capture project images.",
              oKFunction: null);*/
        }, onPermissionGranted: () {
          getImage(ImageSource.camera);
        });
      }
    });
  }

  void openGallery() {
    PermissionsService().hasPhotoAccessPermission().then((hasPermission) {
      if (hasPermission != null && hasPermission) {
        getImage(ImageSource.gallery);
      } else {
        PermissionsService().requestPhotoAccessPermission(
            onPermissionDenied: () {
          showCustomSnackBar(
              content:
                  "Dear user, please go to the settings to enable photo access permission, in order to select images from photo library.");
          /*AppDialogs().errorDialog(
              title: "Permission not Granted",
              buttonText: 'OK',
              errorText:
                  "Dear user, please go to the settings to enable photo access permission, in order to select images from photo library.",
              oKFunction: null);*/
        }, onPermissionGranted: () {
          getImage(ImageSource.gallery);
        });
      }
    });
  }

  Future getImage(ImageSource imageSource) async {
    showLoadingDialogCustom(title: 'Loading Image...');
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      //final bytes = await pickedFile.readAsBytes();
      //final filePath = await FlutterAbsolutePath.getAbsolutePath(pickedFile.path);
      if (pickedFile != null) {
        File _image = File(pickedFile.path);
        _image.length().then((value) => print('size::$value'));

        int index = pickedFile.path.lastIndexOf('/');
        if (index != -1) {
          // imageNameList.add(pickedFile.path.substring(index + 1));
          //Without Compression
          // imageNameList.add(pickedFile.path);
          //With Compression
          _compressImage(File(pickedFile.path));
        }
        _imagesList = (_image);
        uploadImageToFirebase(_imagesList);
      } else {
        Get.back();
      }
    } catch (e) {
      Get.back();
      showCustomSnackBar(
          content: 'You do not have permission to access photos/media library');
    }
  }

  Future uploadImageToFirebase(
    File _imageFile,
  ) async {
    profileImgURL.value = "";
    String fileName = Path.basename(_imageFile.path);
    Reference firebaseStorageRef =
        await FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);

    if (uploadTask.snapshot.state == TaskState.success) {
      final String url = await firebaseStorageRef.getDownloadURL();
    } else if (uploadTask.snapshot.state == TaskState.running) {
      uploadTask.snapshotEvents.listen((event) {
        var percentage = 100 *
            (event.bytesTransferred.toDouble() / event.totalBytes.toDouble());
      });
    } else {
      print('Enter A valid Image');
    }
    await uploadTask.whenComplete(() async {
      final String downloadUrl = await firebaseStorageRef.getDownloadURL();

      profileImgURL.value = downloadUrl;
      UserModel.loggedinUser!.profileImg = profileImgURL.value;
      //await FirebaseFirestore.instance.collection("users").doc(UserModel.loggedinUser!.uid).update({"img": profileImgURL});
      //notifyListeners();
      //notifyParent!();
      Get.back();
    });
  }

  void _compressImage(File file) async {
    final filePath = file.absolute.path;
    // Create output file path
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp|.pn'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    try {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: 40,
          format: filePath.lastIndexOf(new RegExp(r'.pn')) != -1
              ? CompressFormat.png
              : CompressFormat.jpeg);
      compressedImage!
          .length()
          .then((value) => print('after compression size::$value'));
      if (compressedImage != null) {
        imageNameList = (compressedImage.path);
      }
    } catch (e) {
      print("============exception compression $e");

      Get.back();
      /*CustomDialog().errorDialog(
          title: 'Error', errorText: 'Something went wrong, please try again!');*/
    }
  }
}
