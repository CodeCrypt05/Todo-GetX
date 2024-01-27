import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class FirebaseCloudMessaging {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  //Handle Terminated messages here
  void _handleMessage(RemoteMessage message) async {
    print(message.data);
  }

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static String? fcmToken;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  //Foreground type variables
  dynamic fgType;
  dynamic fgId;
  dynamic fgCollType;
  dynamic fgCollTitle;

  getFirebaseNotification() async {
    FirebaseMessaging.instance.getAPNSToken().then((APNStoken) {
      print('here is APN token ---$APNStoken');
    });
    firebaseMessaging.getToken().then((value) async {
      fcmToken = value.toString();
      print('here is fcm token ---$fcmToken');
    }).catchError((onError) {
      print("Exception: $onError");
    });

    //We can use multiple subscription topics for different different Notifications
    firebaseMessaging.subscribeToTopic("democracyapp");

    //For Foreground Notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showFlutterNotification(message);

      print("remote message data ${message.data}");

      print(message.data);
      print('----------- here');
    });
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin?.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              channelDescription: channel.description,
            ),
            iOS: DarwinNotificationDetails()),
      );
    }
  }

  Future<void> setupFlutterNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    if (Platform.isIOS) {
      NotificationSettings settings = await FirebaseMessaging.instance
          .requestPermission(
              alert: true,
              announcement: false,
              badge: true,
              carPlay: false,
              criticalAlert: false,
              sound: true,
              provisional: false);
      print("user granted permission : ${settings.authorizationStatus}");
    }
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              print('here is payload ---> $payload');
            });

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS,
    );

    void onReceiveNotificationResponse(NotificationResponse payload) async {
      /////////////////////////VIBHOR//////////////////////
      //Foreground redirection code
    }

    await flutterLocalNotificationsPlugin?.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onReceiveNotificationResponse);

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      playSound: true,
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> scheduleNotification(DocumentSnapshot task) async {
    // Extract task details from the DocumentSnapshot
    String taskId = task['taskId'];
    String taskTitle = task['task'];
    DateTime taskDateTime = task['timeStamp'].toDate();

    // Schedule the notification
    await flutterLocalNotificationsPlugin!.zonedSchedule(
      int.parse(taskId), // Notification ID
      'Task Reminder',
      'Task: $taskTitle',
      tz.TZDateTime.from(taskDateTime, tz.local), // Schedule time
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
