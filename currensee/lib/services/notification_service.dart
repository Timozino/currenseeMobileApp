import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initialize() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground messages
      print('Message received: ${message.notification?.title ?? ''} ${message.notification?.body ?? ''}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle background messages
      print('Message clicked!');
    });
  }

  Future<void> subscribeToRateAlert(String currencyPair) async {
    await _firebaseMessaging.subscribeToTopic(currencyPair);
  }

  Future<void> unsubscribeFromRateAlert(String currencyPair) async {
    await _firebaseMessaging.unsubscribeFromTopic(currencyPair);
  }
}