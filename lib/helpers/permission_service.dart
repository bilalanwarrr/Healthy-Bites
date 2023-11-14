import 'package:permission_handler/permission_handler.dart';

/*
* @Author Added by Sadaf Khowaja
* */
class PermissionsService {
  //final Permission _permissionHandler = Permission.camera;

  Future<bool> _requestPermission(Permission permission) async {
    final result = await permission.request();
    if (result.isGranted) {
      return true;
    }
    return false;
  }

  // Requests the users permission to read Phone satae
  Future<bool> requestReadPhoneStatePermission(
      {required Function onPermissionGranted,
      required Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.phone);
    if (!granted) {
      onPermissionDenied();
    } else {
      onPermissionGranted();
    }
    return granted;
  }

  Future<bool> hasReadPhoneStatePermission() async {
    return hasPermission(Permission.phone);
  }

  // Requests the users permission to read Phone satae
  Future<bool> requestCameraPermission(
      {required Function onPermissionGranted,
      required Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.camera);
    if (!granted) {
      onPermissionDenied();
    } else {
      onPermissionGranted();
    }
    return granted;
  }

  Future<bool> hasCameraPermission() async {
    return hasPermission(Permission.camera);
  }

  Future<bool> hasPermission(Permission permission) async {
    var permissionStatus = await permission.isGranted;
    return permissionStatus;
  }

  //Added by Sadaf Khowaja
  Future<bool> requestPhotoAccessPermission(
      {required Function onPermissionGranted,
      required Function onPermissionDenied}) async {
    var granted = await _requestPermission(Permission.photos);
    if (!granted) {
      onPermissionDenied();
    } else {
      onPermissionGranted();
    }
    return granted;
  }

  Future<bool> hasPhotoAccessPermission() async {
    return await hasPermission(Permission.photos) &&
        await hasPermission(Permission.storage);
  }
}
