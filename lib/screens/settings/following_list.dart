import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'package:project/screens/profile/authorProfile.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/backend/following.dart';

class MyFollowersScreen extends StatefulWidget {
  @override
  _MyFollowersScreenState createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  late Future<List<Profile>> followees;

  // Use a Set to keep track of indices being unfollowed
  Set<int> unfollowingIndices = Set<int>();

  @override
  void initState() {
    super.initState();
    followees = getFollowees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: myColor,
        title: Text(
          ' My Following List',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DancingScript',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: FutureBuilder<List<Profile>>(
          future: followees,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Profile> followeesList = snapshot.data ?? [];

              return ListView.builder(
                itemCount: followeesList.length,
                itemBuilder: (BuildContext context, int index) {
                  Profile followee = followeesList[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          _navigateToUserProfile(followee);
                        },
                        child: Text(
                          followee.name,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          _navigateToUserProfile(followee);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(followee.imageUrl),
                          radius: 25,
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: unfollowingIndices.contains(index)
                            ? null
                            : () async {
                                // Update the state to indicate unfollowing in progress
                                setState(() {
                                  unfollowingIndices.add(index);
                                });

                                // Perform the unfollow operation
                                await dropFollowee(followee.id, index);

                                // Update the state to indicate unfollowing is done
                                setState(() {
                                  unfollowingIndices.remove(index);
                                });

                                // Close the dialog
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                          primary: myColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                        child: Text(
                          unfollowingIndices.contains(index) ? "Unfollowing..." : "Unfollow",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Jost',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _navigateToUserProfile(Profile p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthorProfileDetailsScreen(author: p),
      ),
    );
  }
}
