import 'package:flutter/material.dart';
import 'package:project/class/blocked.dart';
import 'package:project/class/profileClass.dart';
import 'color.dart';

class blockedListScreen extends StatefulWidget {
  @override
  _blockedListScreen createState() => _blockedListScreen();
}

class _blockedListScreen extends State<blockedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: myAccent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Blocked Users',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: ListView.builder(
        itemCount: blocked.length,
        itemBuilder: (context, index) {
          Profile profile = blocked[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(profile.imageUrl),
            ),
            title: Text(profile.name),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() {
                  blocked.removeAt(index);
                  authors.add(profile);
                });
              },
              child: Text('Unblock',
              style: TextStyle(fontSize: 15, color: Colors.white),),
              
              style: ElevatedButton.styleFrom(
                primary: myBrownColor,
                padding:
                    const EdgeInsets.all(8),
              ),
            ),
          
          );
        },
      ),
      )
    );
    ;
  }
}
