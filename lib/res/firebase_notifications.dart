import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/cubit/cubit.dart';
import 'package:waseet/router/app_router.dart';
import 'package:waseet/router/screens.dart';

class FirebaseNotifications {
  FirebaseNotifications._();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static final FirebaseNotifications instance = FirebaseNotifications._();

  Future<void> init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    const android = AndroidInitializationSettings('mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: android, iOS: ios);
    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      // onDidReceiveBackgroundNotificationResponse:(details)=>
      onDidReceiveNotificationResponse: (details) {
        if (details.payload == null) return;
        final payload = json.decode(details.payload!);
        if (payload is Map<String, dynamic>) {
          _handleMessageAction(payload);
        }
      },
    );
    final permission = await FirebaseMessaging.instance.requestPermission(
      provisional: true,
    );
    log('FirebaseMessaging permission: $permission');
    final token = await FirebaseMessaging.instance.getTokenOrApnsToken();
    log('FirebaseMessaging token: $token');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      handleNotification(message);
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> _handleMessageAction(Map<String, dynamic> data) async {
    if (data['type'] == 'chat') {
      await Future<void>.delayed(const Duration(seconds: 5));
      if (data['chatId'] != null) {
        await AppRouter.router.pushNamed(
          Screens.chat.name,
          pathParameters: {
            'chat_room_id': data['chatId'] as String,
          },
        );
      }
    }
    if (data['type'] == 'nafath_verification') {
      // ignore: use_build_context_synchronously
      rootNavigatorKey.currentState?.context.read<AppBloc>().add(
            HandleNafathNotificationEvent(
              data,
            ),
          );
    }
  }

  Future<void> onAppOpenedNotification() async {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        if (event.data.isNotEmpty) {
          final data = event.data;
          _handleMessageAction(data);
        }
      },
    );
  }

  Future<void> handleNotification(RemoteMessage message) async {
    _onMessageStreamController.add(message.data);
    await _showLocalNotification(message);
    if (message.data.isNotEmpty) {
      await _handleMessageAction(message.data);
    }
  }

  Future<void> _showLocalNotification(RemoteMessage? message) async {
    if (message == null) return;
    final android = AndroidNotificationDetails(
      '${DateTime.now()}',
      'Default',
      priority: Priority.high,
      importance: Importance.max,
      shortcutId: DateTime.now().toIso8601String(),
      sound: const RawResourceAndroidNotificationSound('notification'),
    );

    const ios = DarwinNotificationDetails(
      presentBadge: true,
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
    );
    final platform = NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().microsecond,
      '${message.notification?.title}',
      '${message.notification?.body}',
      platform,
      payload: json.encode(message.data),
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    log('Handling a background message ${message.messageId}');
    if (message.data.isNotEmpty) {
      log('Handling a background message ${message.data}');
      await FirebaseNotifications.instance.handleNotification(message);
    }
  }

  static final StreamController<Map<String, dynamic>>
      _onMessageStreamController = StreamController.broadcast();

  static Stream<Map<String, dynamic>> get onMessageStream =>
      _onMessageStreamController.stream;

  static Map<String, dynamic>? lastNotificationBa;

  static void streamHandled() {
    _onMessageStreamController.add({});
    lastNotificationBa = null;
  }
}

extension FirebaseMessagingX on FirebaseMessaging {
  Future<String?> getTokenOrApnsToken() async {
    String? token;
    try {
      token = await getToken();
    } catch (e) {
      if (Platform.isIOS) {
        token = await getAPNSToken();
      } else {
        token = await getToken();
      }
    }
    return token;
  }
}
