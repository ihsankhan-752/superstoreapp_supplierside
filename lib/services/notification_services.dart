import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  init() async {
    FirebaseMessaging messaging = await FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    getToken();
    messaging.onTokenRefresh.listen((token) {
      if (token != null && FirebaseAuth.instance.currentUser != null)
        FirebaseFirestore.instance.collection('tokens').doc(FirebaseAuth.instance.currentUser!.email).set({'token': token});
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        EasyLoading.showSuccess('got Notification');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      EasyLoading.showSuccess('got Notification');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  //homepage init
  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null && FirebaseAuth.instance.currentUser != null)
      FirebaseFirestore.instance.collection('tokens').doc(FirebaseAuth.instance.currentUser!.email).set({'token': token});
  }

  void sendPushNotification(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAAMQU-kmw:APA91bHLc0YlM0Vz60iqNfOnRpQzyoZHLrAKfAW6CinPSRF8lNlrOb8T8_VzLHcmj3LGBYjBaRiAqNRr3HbkSxGEE4vANvDpsrB3D0VWvENtpPgBod6GVVSdUof7JGQhULVvY7RquTsD",
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': "high",
            "data": <String, dynamic>{
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "id": '1',
              "status": "done",
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              // "android_channel_id": "abc",
            },
            "to": token
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
