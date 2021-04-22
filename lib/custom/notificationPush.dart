import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPush {
  static Future<void> notification() async {
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var settings =
        new InitializationSettings(android, new IOSInitializationSettings());
    flip.initialize(settings);

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var key in prefs.getKeys()) {
      var element = (prefs.get(key) as String);
      var timeElement = element.split(';')[1];

      DateTime now = DateTime.now();
      String formattedTime = DateFormat.jm().format(now);

      if (int.parse(formattedTime.split(':')[0]) < 10) {
        formattedTime = "0" + formattedTime;
      }
      
      if (now.weekday == int.parse(element.split(';')[2]) &&
          formattedTime == timeElement) {
        await flip.show(
            0,
            'Perlavisión Noticias',
            'El programa ${element.split(';')[0]}, comenzará pronto',
            platformChannelSpecifics,
            payload: 'Default_Sound');
      }
    }
  }
}
