import 'package:flutter/material.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/utils/class/profileClass.dart';
import '../../theme/color.dart';
import 'package:project/utils/constant.dart';
import 'package:project/utils/global.dart';

class blockedListScreen extends StatefulWidget {
  @override
  _blockedListScreenState createState() => _blockedListScreenState();
}

class _blockedListScreenState extends State<blockedListScreen> {
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
          itemCount: user!.blockedList.length,
          itemBuilder: (context, index) {
            return FutureBuilder<Profile>(
              future: getProfile(user!.blockedList[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a loading indicator here if needed
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle error
                  return Text('Error: ${snapshot.error}');
                } else {
                  Profile profile = snapshot.data!;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(profile.imageUrl),
                    ),
                    title: Text(profile.name),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          user!.blockedList.removeAt(index);
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
                }
              },
            );
          },
        ),
      ),
    );
  }
}
