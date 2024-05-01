import 'package:flutter/material.dart';
import 'package:markus/Screens/BottomNavBar/vulnerability.dart';
import 'package:markus/Screens/send_alert.dart';

import 'BottomNavBar/command.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue.shade900,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.record_voice_over),
            icon: Icon(Icons.record_voice_over_outlined),
            label: 'Commands',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.help_center_outlined),
            icon: Icon(Icons.help_center),
            label: 'Rescue',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.camera_indoor),
            icon: Icon(Icons.camera_indoor_outlined),
            label: 'Vulnerability',
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          switch (currentPageIndex) {
            case 0:
              return Commands();
            case 1:
              return SendNotification();
            case 2:
              return Vulnerability();
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
