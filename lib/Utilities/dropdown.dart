import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final Function(String) onOptionSelected;

  const Dropdown({required this.onOptionSelected});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String _selectedOption = 'Select Language';
  List<String> _options = [
    'Select Language',
    'Telugu',
    'Hindi',
    'English',
    'Tamil'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
              widget.onOptionSelected(newValue);
            });
          },
          dropdownColor: Colors.blue.shade900,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          items: _options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "  " + value,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
