import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/class/profileClass.dart';

class MyFollowersScreen extends StatefulWidget {
  @override
  _MyFollowersScreenState createState() => _MyFollowersScreenState();
}

class _MyFollowersScreenState extends State<MyFollowersScreen> {
  List<int> visibleIndices = [0, 1, 2, 3]; // Initial list of visible indices
  List<Profile> authors = [
    Profile(
        name: 'Jane Marie',
        imageUrl: 'assets/profile01.png',
        bio:
            'Hello, I am a writer and this is my profile. I hope you like it. Nice to meet you all ^^'),
    Profile(
        name: 'Briana March',
        imageUrl: 'assets/profile02.png',
        bio:
            'Welcome to my creative weirdos! This is your space to get out of your skin into the world of Science fiction'),
    Profile(name: 'Lucie Clarck', imageUrl: 'assets/profile03.png'),
    Profile(name: 'James Arthur', imageUrl: 'assets/profile04.png'),
    // Add more authors as needed
  ];

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
                    "Following",
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
              padding: const EdgeInsets.all(30.0),
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
                  Text('You want to unfollow $userName ?'),
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
                      "Unfollow",
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
