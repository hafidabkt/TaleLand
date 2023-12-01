import 'package:flutter/material.dart';

class TextEntryContainer2 extends StatefulWidget {
  final String labelText;

  TextEntryContainer2({required this.labelText});

  @override
  _TextEntryContainerState createState() => _TextEntryContainerState();
}

class _TextEntryContainerState extends State<TextEntryContainer2> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: '',
            ),
          ),
        ],
      ),
    );
  }
}
