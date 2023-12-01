import 'package:flutter/material.dart';
import '../src/color.dart';

class StoryTile extends StatelessWidget {
  final String backgroundImage; // User-provided background image
  final String title; // User-provided title

  StoryTile({required this.backgroundImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        tileColor: myPinkColor,
        contentPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.withOpacity(0.5)),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(backgroundImage),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: PopupMenuButton<String>(
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'edit',
              child: Text('Edit Story'),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              // Handle the edit action here
              print('Edit Story selected');
            }
          },
          icon: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
