import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:project/utils/class/profileClass.dart';
import 'package:project/screens/profile/authorProfile.dart';
import 'package:project/theme/color.dart';

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
        title: Text('Filtered Profiles', style: TextStyle(color: Colors.white)),
        backgroundColor: myAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: widget.filteredProfiles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Use SvgPicture.asset for SVG images
                  SvgPicture.asset('assets/not_found.svg', height: 150, width: 150),
                ],
              ),
            )
          : ListView.builder(
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
                author: profile,
              ),
            ),
          );
        },
      ),
    );
  }
}
