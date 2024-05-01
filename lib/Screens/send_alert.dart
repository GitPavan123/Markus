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
                      "cQBS9d39RICHdAyUKOoead:APA91bEnWuDFMWCsPP4P-ZqYHErUM8xXc9D2xdASp3L-efpanTrst6-LHuUjnQAAy7g6JxAc32g1Ot4U1HxuR8o35RVORzlPZ6_WxM9N4aoj9v96xAnFQ-VOrrPT2_pc6zeN1BhiuonH");
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
                      "cQBS9d39RICHdAyUKOoead:APA91bEnWuDFMWCsPP4P-ZqYHErUM8xXc9D2xdASp3L-efpanTrst6-LHuUjnQAAy7g6JxAc32g1Ot4U1HxuR8o35RVORzlPZ6_WxM9N4aoj9v96xAnFQ-VOrrPT2_pc6zeN1BhiuonH");
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
                      "cQBS9d39RICHdAyUKOoead:APA91bEnWuDFMWCsPP4P-ZqYHErUM8xXc9D2xdASp3L-efpanTrst6-LHuUjnQAAy7g6JxAc32g1Ot4U1HxuR8o35RVORzlPZ6_WxM9N4aoj9v96xAnFQ-VOrrPT2_pc6zeN1BhiuonH");
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
      "AAAAAT7lLnA:APA91bHMIgxfCdBbtFHVY-FHziIAqSMJN1W0hCBbc4MtONA40vWDuAjBDadbFLeej2DBlEjZsXG_5ESCdQ0B3X1wIn0T-J6dlrxzyzURoMJpB2JkBlYezF_3Rw0sE8hV_aPvV5moUJhH"; // Replace with your Firebase server key
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
