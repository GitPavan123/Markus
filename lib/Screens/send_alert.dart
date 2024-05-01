import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("Emergency service alert"),
      ),
      body: Center(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  sendPushNotification(
                      "Emergency Alert!",
                      "Emergency call for fire rescue triggered!",
                },
                child: Text(
                  "Fire Rescue!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 17,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  sendPushNotification(
                      "Emergency Alert!",
                      "Emergency call for crime rescue triggered!",
                },
                child: Text(
                  "Crime Rescue!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 17,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  sendPushNotification(
                      "Emergency Alert!",
                      "Emergency call for gas leak triggered!",
                },
                child: Text(
                  "Gas leak!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      )),
    );
  }
}

Future<void> sendPushNotification(
    String title, String description, String fcmToken) async {
  print(title);
  print(description);
  print(fcmToken);
  const String serverKey =
  final String url = 'https://fcm.googleapis.com/fcm/send';
  final body = {
    'notification': {'title': title, 'body': description},
    'priority': 'high',
    'data': {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK'
    }, // Optional data payload
    'to': fcmToken,
  };
  final headers = {
    'Authorization': 'key=$serverKey',
    'Content-Type': 'application/json',
  };

  final response =
      await http.post(Uri.parse(url), body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification: ${response.statusCode}');
  }
}
