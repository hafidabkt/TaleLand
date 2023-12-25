import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'color.dart';
import 'package:project/main.dart';
import 'package:project/utils/constant';

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
          title: Text(
            'Blocked Users',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: user.blockedList.length,
            itemBuilder: (context, index) {
              int i = findIndex(authors, user.blockedList[index]);
              Profile profile = authors[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(profile.imageUrl),
                ),
                title: Text(profile.name),
                trailing: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      user.blockedList.removeAt(index);
                    });
                    final response02 = await supabase
                    .from('blockedlist')
                    .delete()
                    .eq('blocked_profile_id', profile.id);
                  },
                  child: Text(
                    'Unblock',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: myBrownColor,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

int findIndex(List<Profile> profiles, int profileId) {
  print(user.blockedList);
  print(profileId);
  for (int i = 0; i < profiles.length; i++) {
    if (profiles[i].id == profileId) {
      return i;
    }
  }
  return -1;
}
