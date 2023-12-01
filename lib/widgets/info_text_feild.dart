import 'package:flutter/material.dart';

class TextEntryContainer extends StatefulWidget {
  final String hintText;

  TextEntryContainer({required this.hintText});

  @override
  _TextEntryContainerState createState() => _TextEntryContainerState();
}

class _TextEntryContainerState extends State<TextEntryContainer> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: widget.hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
