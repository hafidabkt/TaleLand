import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'widgets.dart';


class RoundedInputField extends StatelessWidget {
  const RoundedInputField({Key? key, this.hintText, this.icon = Icons.person})
      : super(key: key);
  final String? hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: myBlueColor,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle:
                const TextStyle(fontFamily: 'OpenSans', color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}
