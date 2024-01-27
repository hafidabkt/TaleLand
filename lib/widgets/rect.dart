import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';


class RectangularContainer extends StatelessWidget {
  final double width;
  final double height;
  final List<Widget> children;
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final String text;

  RectangularContainer({
    required this.width,
    required this.height,
    this.text = '', // Add a text property
    this.children = const [],
    this.backgroundColor = myPinkColor,
    this.borderWidth = 1.0,
    this.borderColor = myPinkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Customize text color
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
