import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid = "";
  String fullName = "";
  String email = "";
  String password = "";
  String profileImg = defaultProfilePic;
  bool isActive = true;
  String deviceToken = "";
  Timestamp createdAt = Timestamp.fromDate(DateTime.now());
  Timestamp updatedAt = Timestamp.fromDate(DateTime.now());

  UserModel(
      {required this.uid, required this.fullName, required this.email, required this.profileImg, this.isActive = true, required this.deviceToken})
      : createdAt = Timestamp.fromDate(DateTime.now()),
        updatedAt = Timestamp.fromDate(DateTime.now());

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"] ?? UserModel.loggedinUser!.uid;
    fullName = map["fullName"];
    email = map["email"];
    password = map["password"] ?? "";
    profileImg = map["profileImg"];
    isActive = map["isActive"] ?? true;
    deviceToken = map["deviceToken"] ?? "";
    createdAt = map["createdAt"] ?? Timestamp.fromDate(DateTime.now());
    updatedAt = map["updatedAt"] ?? Timestamp.fromDate(DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "email": email,
      "password": password,
      "profileImg": profileImg,
      "isActive": isActive,
      "deviceToken": deviceToken,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  static UserModel? loggedinUser;
  static String defaultProfilePic =
      "https://firebasestorage.googleapis.com/v0/b/trend-spa.appspot.com/o/default%20profile%20pic.png?alt=media&token=5a505ec8-94c0-48b8-b025-a07498a42e4a";
}
