import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final TextEditingController _deviceNameController = TextEditingController();

  Future<int> getHighestCodeOn() async {
    final collection = FirebaseFirestore.instance.collection('Add_Devices');
    final snapshot =
        await collection.orderBy('Code_ON', descending: true).limit(1).get();
    if (snapshot.docs.isEmpty) {
      return 0; // No documents exist, return 0 for Code_ON
    }
    final docData = snapshot.docs.first.data();
    return docData['Code_ON'] as int;
  }

  void addDevice(String deviceName) async {
    final highestCodeOn = await getHighestCodeOn();
    final newCodeOn = highestCodeOn + 1;
    final newCodeOff = newCodeOn / 2;

    final collection = FirebaseFirestore.instance.collection('Add_Devices');
    final docRef = collection.doc(deviceName);
    await docRef.set({
      'Code_ON': newCodeOn,
      'Code_OFF': newCodeOff,
      'Device_Name': deviceName,
      'IsON': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add device"),
                actions: [
                  TextFormField(
                    cursorOpacityAnimates: true,
                    controller: _deviceNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 24),
                      labelText: "Device Name",
                      prefixIcon: Icon(Icons.light_sharp),
                      labelStyle: TextStyle(fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue.shade900, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      final deviceName = _deviceNameController.text;
                      if (deviceName.isEmpty) {
                        return; // Handle empty device name
                      }
                      addDevice(deviceName);
                      Navigator.of(context)
                          .pop(); // Close the dialog after successful addition
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade900,
      ),
      appBar: AppBar(
        title: Text("Add devices"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 700,
          color: Colors.red,
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("<Device Name>",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        Text("<Power consumed>",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    SizedBox(width: 16),
                    Text("           <IsON>",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ],
                ),
                width: 270,
                height: 70,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
