import 'package:flutter/material.dart';
import 'package:project/global.dart';
import 'package:project/src/color.dart';
import 'package:project/src/resetPassword.dart';
import 'package:project/src/resetName.dart';
import 'package:project/src/screens.dart';
import 'package:project/src/theme.dart';
import 'package:project/src/blockedListScreen.dart';
import 'package:project/src/following_list.dart';

class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myAccent,
        title: Text(
          'Profile Settings',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildSettingOption(
            context,
            'Change Name',
            Icons.person,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => nameReset()));
            },
          ),
          buildSettingOption(
            context,
            'Change Profile Picture',
            Icons.photo,
            () {
              // Implement your change profile picture logic here
            },
          ),
          buildSettingOption(
            context,
            'Change Password',
            Icons.lock,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgetPassword()));
            },
          ),
          buildSettingOption(
            context,
            'Following list',
            Icons.list,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyFollowersScreen()));
              // Implement your logout logic here
            },
          ),
          buildSettingOption(
            context,
            'Theme',
            Icons.color_lens,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThemeScreen()));
            },
          ),
          buildSettingOption(
            context,
            'Blocked List',
            Icons.person_off,
            () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => blockedListScreen()));
            },
          ),
          buildSettingOption(
            context,
            'Logout',
            Icons.exit_to_app,
            () {
              user = null;
              Navigator.of(context).popUntil((route) => route.isFirst);
              // Push the TargetScreen onto the navigation stack
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget buildSettingOption(
      BuildContext context, String label, IconData icon, Function onPressed) {
    return InkWell(
      onTap: () {
        {
          onPressed();
        }
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
