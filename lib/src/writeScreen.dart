import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/screens.dart';
import 'package:project/src/edit.dart';

class WriteEditor extends StatelessWidget {
  const WriteEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 23,
                ),
                Text(
                  "Write",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => edit(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.auto_fix_high,
                      color: myAccent,
                    ),
                  ),
                  Text(
                    "Edit another story",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateStory(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.bookmark_add_rounded,
                      color: myAccent,
                    ),
                  ),
                  Text(
                    "Creare a new story",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
