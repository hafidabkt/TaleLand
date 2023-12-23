import 'package:flutter/material.dart';
import 'package:project/src/homePage.dart';
import 'bookList.dart';
import 'package:project/src/color.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/src/notifications.dart';
import 'package:project/src/followers.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/main.dart';
import 'package:project/class/profileClass.dart';

class Profile2 extends StatefulWidget {
  final Profile author;
  Profile2({required this.author});

  @override
  State<Profile2> createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  String selectedOption = 'About';
  File? _image;
  void initState() {
    super.initState();
    _loadImageFromPrefs();
  }

  Future _loadImageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profileImagePath');

    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future _saveImageToPrefs(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImagePath', imagePath);
  } // Variable to store the selected image

  Future _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imagePath = File(pickedFile.path).path;
      await _saveImageToPrefs(imagePath);

      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        leading: null,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'TaleLand',
          style: TextStyle(
            fontFamily: 'DancingScript',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationScreenState()),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileSettingsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!) as ImageProvider<Object>?
                                : AssetImage(user.imageUrl),
                          ),
                        ),
                        Positioned(
                          bottom: -7,
                          right: -5,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: _getImage,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        widget.author.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${widget.author.followers}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Followers(),
                                  ),
                                );
                              },
                              child: Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${widget.author.published}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "work",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${widget.author.bookList}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "reading list",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Divider(
              color: Colors.grey, // Change the color to blue
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '''${user.bio}''',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: myBrownColor,
                height: 40,
                width: 400,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'My Reading list >',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 200.0,
                child: bookList(bookies: books, book: user.publishedBooks),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: myBrownColor,
                height: 40,
                width: 400,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'My Published Stories >',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 200.0,
                child: bookList(
                    bookies: notPublished, book: user.notPublishedBooks),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                color: myBrownColor,
                height: 40,
                width: 400,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'My Recommendation list >',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 200.0,
                child: bookList(bookies: books, book: user.recommendationList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

