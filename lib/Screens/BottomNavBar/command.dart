import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:markus/Utilities/Languages/english.dart';
import 'package:markus/Utilities/Languages/hindi.dart';
import 'package:markus/Utilities/Languages/tamil.dart';
import 'package:markus/Utilities/Languages/telugu.dart';
import 'package:markus/Utilities/camera.dart';
import 'package:markus/Utilities/dropdown.dart';

import '../add_devices.dart';

class Commands extends StatefulWidget {
  @override
  _CommandsState createState() => _CommandsState();
}

class _CommandsState extends State<Commands> {
  late List<CameraDescription> cameras = [];
  bool positive = true;
  bool isGesture = false;
  String selectedLanguage = 'Select Language';

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    cameras = await availableCameras();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (cameras == null || cameras.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Commands"),
          backgroundColor: Colors.blue.shade900,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                      1, 92, 0, 0), // Adjust the position as needed
                  items: [
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap on "Add device"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDevice()),
                          );
                        },
                        child: Text("Add device"),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 30.0,
                style: const ToggleStyle(
                  borderColor: Color(0xFF0D47A1),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                  backgroundColor: Color(0xFF0D47A1),
                ),
                borderWidth: 5.0,
                height: 58,
                onChanged: (b) {
                  setState(() {
                    positive = b;
                    isGesture = !b;
                  });
                },
                styleBuilder: (b) => ToggleStyle(
                    indicatorColor: b ? Colors.white : Colors.white),
                iconBuilder: (value) => value
                    ? Icon(
                        Icons.touch_app_outlined,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.mic_none,
                        color: Colors.black,
                      ),
                textBuilder: (value) => value
                    ? Center(child: Text('Gesture'))
                    : Center(child: Text('Voice')),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: 370,
                height: 400,
                child: Column(children: [
                  isGesture
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  isGesture
                      ? Dropdown(
                          onOptionSelected: (option) {
                            setState(() {
                              selectedLanguage = option;
                            });
                          },
                        )
                      : Text(""),
                  isGesture
                      ? SizedBox(
                          height: 30,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  isGesture
                      ? Container(
                          width: 300,
                          height: 250,
                          child: _buildSelectedLanguageWidget(),
                        )
                      : Container(
                          width: 170,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CameraApp(cameras: cameras),
                          ),
                        )
                ]),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildSelectedLanguageWidget() {
    switch (selectedLanguage) {
      case 'Telugu':
        return Telugu();
      case 'Hindi':
        return Hindi();
      case 'English':
        return English();
      case 'Tamil':
        return Tamil();
      default:
        return Container();
    }
  }
}
