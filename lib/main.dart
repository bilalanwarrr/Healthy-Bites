import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:healthy/constant.dart';
import 'package:healthy/utils/app_strings.dart';
import 'package:healthy/utils/route_generator.dart';
import 'package:healthy/utils/screen_bindings.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'helpers/firebase_helper.dart';
import 'helpers/firebase_push_notification_api.dart';
import 'model/user_model.dart';

bool shouldUseFirebaseEmulator = true;

late final FirebaseApp app;
late final FirebaseAuth auth;
Uuid uuid = const Uuid();
final healthyStyles = [];
final dailyRegimens = []; //Daily Regimen
String userDeviceToken = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // We store the app and auth to make testing with a named instance easier.
  /*app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }
*/
  await Firebase.initializeApp();
  userDeviceToken = await FirebasePushNotificationApi().initNotifications();
  User? currentUser = FirebaseAuth.instance
      .currentUser; // to store info about logged in user (if any) i.e. email/password
  if (currentUser != null) {
    UserModel? thisUserModel =
        await FirebaseHelper.getUserModelById(currentUser.uid);
    UserModel.loggedinUser = thisUserModel;
  }
  await FirebaseHelper.getDietTypes();
  await FirebaseHelper.getDailyRegimens();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(fontFamily: "Gotham").copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: primaryColor),
          ),
          /*builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
              textScaleFactor:
                  data.textScaleFactor > 2.0 ? 2.0 : data.textScaleFactor,
            ),
            child: FlutterEasyLoading(
                child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: Center(child: child),
            )),
          );
        },*/
          title: kAppName,
          debugShowCheckedModeBanner: false,
          initialBinding: ScreenBindings(),
          initialRoute: kSplashRoute,
          getPages: RouteGenerator.getPages(),
        );
      },
    );
  }
}

Future<void> sendPushMessage(
    {required String title, required String body}) async {
  print('=======inside send method');
  String _token = userDeviceToken;
  if (_token.isEmpty) {
    print('Unable to send FCM message, no token exists.');
    return;
  }

  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization":
            "key=AAAAOK8PohQ:APA91bF7UIbi7AC9YpsfrlBWUW4RNbH4gb4BqxulJ4AlG8f7PIheeFu4bptbwzEeYh1WUgjL__Ky2iUjNP9t6i1VRJTfbiZC7Bj0VKEX2L5K2REb_n64Prm2igboJ4WhOAes6prLCnQ7"
      },
      body: constructFCMPayload(_token, title, body),
    );
    print('==============FCM request for device sent!');
  } catch (e) {
    print("=============Exception on sending push $e");
  }
}

Future<void> sendPushMessageToTopic(
    {required String topic,
    required String title,
    required String body}) async {
  print('=======inside sendPushMessageToTopic method');
  String _token = userDeviceToken;
  if (_token.isEmpty) {
    print('Unable to sendPushMessageToTopic FCM message, no token exists.');
    return;
  }

  try {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization":
            "key=AAAAOK8PohQ:APA91bF7UIbi7AC9YpsfrlBWUW4RNbH4gb4BqxulJ4AlG8f7PIheeFu4bptbwzEeYh1WUgjL__Ky2iUjNP9t6i1VRJTfbiZC7Bj0VKEX2L5K2REb_n64Prm2igboJ4WhOAes6prLCnQ7"
      },
      body: constructFCMPayload("/topics/$topic", title, body),
    );
    print('==============FCM request for device sent!');
  } catch (e) {
    print("=============Exception on sending push $e");
  }
}

// Crude counter to make messages unique
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token, String title, String body) {
  print('=========inside payload');
  _messageCount++;
  return jsonEncode({
    // 'token': token,
    'priority': 'high',
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': title, //'Hello FlutterFire!',
      'body':
          body, //'This notification (#$_messageCount) was created via FCM!',
    },
    'to': token
  });
}
