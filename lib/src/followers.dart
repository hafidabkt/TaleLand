import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/class/profileClass.dart';

class Followers extends StatefulWidget {
  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<Followers> {
  List<int> visibleIndices = [0, 1, 2, 3]; // Initial list of visible indices

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
          ' My Followers',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'DancingScript',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: ListView.builder(
          itemCount: visibleIndices.length,
          itemBuilder: (BuildContext context, int index) {
            int authorIndex = visibleIndices[index];
            String userName = authors[authorIndex].name;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: GestureDetector(
                  onTap: () {
                    // Navigate to another page when title is tapped
                    _navigateToUserProfile(authors[authorIndex]);
                  },
                  child: Text(
                    userName,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                leading: GestureDetector(
                  onTap: () {
                    // Navigate to another page when avatar is tapped
                    _navigateToUserProfile(authors[authorIndex]);
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(authors[authorIndex]
                        .imageUrl), // Use the image URL directly
                    radius: 25,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Show the unfollow dialog
                    _showUnfollowDialog(context, userName, index);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: myColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  ),
                  child: Text(
                    "remove",
                    style: TextStyle(color: Colors.white, fontFamily: 'Jost'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToUserProfile(Profile p) {
    // Implement your navigation logic here
    // For example, you can push a new page with the user's profile
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthorProfileDetailsScreen(author: p),
      ),
    );
  }

  void _showUnfollowDialog(BuildContext context, String userName, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        authors[index].imageUrl), // Use the image URL directly
                    radius: 60,
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    userName,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('You want to remove $userName'),
                  Text(' from your followers?'),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle unfollow button press in the dialog
                      setState(() {
                        // Remove the index from the visibleIndices list
                        visibleIndices.removeAt(index);
                      });
                      Navigator.pop(context); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      primary: myColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      "remove",
                      style: TextStyle(color: Colors.white, fontFamily: 'Jost'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
