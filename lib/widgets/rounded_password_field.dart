import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'widgets.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        cursorColor: myPinkColor, 
        decoration: const InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: "Password",
            hintStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.grey),
            suffixIcon: Icon(
              Icons.visibility,
              color: myPinkColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
