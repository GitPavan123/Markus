import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const route='/notification-screen';

  @override
  Widget build(BuildContext context) {
    // Extract notification message from arguments
    final notificationMessage = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // Access notification fields
    final title = notificationMessage['title'];
    final body = notificationMessage['body'];
    final data = notificationMessage['data'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$title'),
            Text('$body'),
            Text('$data'),

          ],
        ),
      ),
    );
  }
}
