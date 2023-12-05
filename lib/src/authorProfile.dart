import 'package:flutter/material.dart';
import 'package:project/class/blocked.dart';
import 'package:project/src/color.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/widgets/widgets.dart';

class AuthorProfileDetailsScreen extends StatefulWidget {
  final Profile author;
  const AuthorProfileDetailsScreen({required this.author});

  @override
  _AuthorProfileDetailsScreen createState() => _AuthorProfileDetailsScreen();
}

class _AuthorProfileDetailsScreen extends State<AuthorProfileDetailsScreen> {
  bool isFollowed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: myColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'TaleLand',
          style: TextStyle(
            fontFamily: 'DancingScript',
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'block_user') {
                // Handle the selected option (Block User)
                _blockUser(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'block_user',
                child: Text('Block User'),
              ),
              // Add more items as needed
            ],
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
                            backgroundImage: AssetImage(widget.author.imageUrl),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          widget.author.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${widget.author.followers}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Followers",
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
                              '${widget.author.published}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
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
                                  fontSize: 20, fontWeight: FontWeight.w500),
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 45,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isFollowed = !isFollowed;
                              });
                            },
                            child: Text(
                              isFollowed ? "UnFollow" : "Follow",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: myBrownColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  '''${widget.author.bio}''',
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
                      'Reading list >',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity, // Adjust the width as needed
                height: 200.0, // Adjust the height as needed
                child: HorizontalImageList(),
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
                      'Published Stories >',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity, // Adjust the width as needed
                height: 200.0, // Adjust the height as needed
                child: HorizontalImageList2(),
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
                      'Reacomandation list >',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity, // Adjust the width as needed
                height: 200.0, // Adjust the height as needed
                child: HorizontalImageList3(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _blockUser(BuildContext context) {
    setState(() {
      blocked.add(widget.author);
    });
  }
}
