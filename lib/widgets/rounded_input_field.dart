import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'widgets.dart';


class RoundedInputField extends StatelessWidget {
  RoundedInputField({Key? key, this.hintText, this.icon = Icons.person})
      : super(key: key);
  final String? hintText;
  final IconData icon;

  @override
  TextEditingController controller = TextEditingController();
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
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
