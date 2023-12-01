import 'package:flutter/material.dart';

class HorizontalImageList2 extends StatelessWidget {
  HorizontalImageList2({super.key});

  final List<String> imagePaths = [
    'assets/book5.png',
    'assets/book6.png',

    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 110.0, // Adjust the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white, // Background color of the container
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
