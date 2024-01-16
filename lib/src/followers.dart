import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/backend/backend.dart';

class Followers extends StatefulWidget {
  @override
  _MyFollowersScreenState createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<Followers> {
  late Future<List<Profile>> followers;

  // Use a Set to keep track of indices being unfollowed
  Set<int> unfollowingIndices = Set<int>();

  @override
  void initState() {
    super.initState();
    followers = getFollowers();
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
          ' My Followers List',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DancingScript',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: FutureBuilder<List<Profile>>(
          future: followers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Profile> followersList = snapshot.data ?? [];

              return ListView.builder(
                itemCount: followersList.length,
                itemBuilder: (BuildContext context, int index) {
                  Profile follower = followersList[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: GestureDetector(
                        onTap: () {
                          _navigateToUserProfile(follower);
                        },
                        child: Text(
                          follower.name,
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          _navigateToUserProfile(follower);
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(follower.imageUrl),
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
                                await dropFollower(follower.id, index);

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
                          unfollowingIndices.contains(index) ? "Removing..." : "Remove",
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
