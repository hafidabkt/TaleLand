import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';


class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatarUrl;

  const CustomListTile({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myPinkColor, // Assuming pink2 is defined somewhere in your code
          boxShadow: [
            BoxShadow(
              color: myPurpleColor.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatarUrl),
          ),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show a dialog with two options
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Options'),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          // Add logic for deleting conversation
                          print('Delete conversation');
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Delete Conversation'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          // Add logic for leaving chat group
                          print('Leave chat group');
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Leave Chat Group'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
