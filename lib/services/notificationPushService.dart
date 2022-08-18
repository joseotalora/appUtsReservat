import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPushService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageController = StreamController<String>.broadcast();

  Stream<String> get messageStream => _messageController.stream;

  initNotification() async {
    await messaging.requestPermission();
    messaging.getInitialMessage(
      
      

      //onMessage: onMessage,
      //onBackgroundMessage: onBackgroundMessage,
      //onLaunch: onLaunch,
      //onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    //addLog(message: 'on message: $message');
    final data = message['body'];
    _messageController.sink.add(data);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    //addLog(message: 'on launch: $message');
    final data = message['body'];
    _messageController.sink.add(data);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    //addLog(message: 'on resume: $message');
    final data = message['body'];
    _messageController.sink.add(data);
  }

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    //addLog(message: 'on background: $message');
  }

  void subscribeToTopic(String topic) {
    //_firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeToTopic(String topic) {
    //_firebaseMessaging.unsubscribeFromTopic(topic);
  }

  dispose() {
    _messageController?.close();
  }
}
