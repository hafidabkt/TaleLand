import 'package:flutter/material.dart';
import 'package:project/src/color.dart';

class HorizontalImageListUser3 extends StatefulWidget {
  HorizontalImageListUser3({Key? key}) : super(key: key);

  @override
  _HorizontalImageListState createState() => _HorizontalImageListState();
}

class _HorizontalImageListState extends State<HorizontalImageListUser3> {
  final List<String> imagePaths = [
    'assets/book7.png',
    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imagePaths.length + 1, // Add 1 for the "+" icon
      itemBuilder: (context, index) {
        if (index == imagePaths.length) {
          // The last item is the "+" icon
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                // Implement the logic to add an image here
                // For example, you can open a file picker to choose an image.
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Container(
                width: 110.0, // Adjust the width as needed
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  border: Border.all(
                    color: myPurpleColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 48.0,
                    color: myPurpleColor,
                  ),
                ),
              ),
            ),
          );
        } else {
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
        }
      },
    );
  }
}
