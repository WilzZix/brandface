import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    debugPrint('[FCM][bg] message received: id=${message.messageId} '
        'data=${message.data}');
  }
  // FCM displays the system banner itself for messages with a notification
  // payload. No further action required here.
}
