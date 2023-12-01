import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/resetPassword.dart';
import 'package:project/src/nameReset.dart';
import 'package:project/src/theme.dart';
class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myAccent,
        title: Text('Profile Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildSettingOption(
            context,
            'Change Name',
            Icons.person,
            () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => nameReset()));
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
            'Logout',
            Icons.exit_to_app,
            () {
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
           )
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
