import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart'; // Import your Profile class
import 'package:project/backend/backend.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/src/homePage.dart'; // Import your backend functions

class FilteredProfilesScreen extends StatefulWidget {
  final List<Profile> filteredProfiles;

  FilteredProfilesScreen({required this.filteredProfiles});

  @override
  _FilteredProfilesScreenState createState() => _FilteredProfilesScreenState();
}

class _FilteredProfilesScreenState extends State<FilteredProfilesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Profiles'),
      ),
      body: ListView.builder(
        itemCount: widget.filteredProfiles.length,
        itemBuilder: (context, index) {
          return buildProfileCard(widget.filteredProfiles[index]);
        },
      ),
    );
  }

  Widget buildProfileCard(Profile profile) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          // Assuming you have an image URL in your Profile class
          backgroundImage: AssetImage(profile.imageUrl),
        ),
        title: Text(profile.name),
        subtitle: Text(profile.bio),
        onTap: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorProfileDetailsScreen(
                              author: profile),
                        ),
                      );
        },
      ),
    );
  }
}
