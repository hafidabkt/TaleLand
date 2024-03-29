import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'package:project/screens/chat/chatList.dart';
import 'package:project/screens/book/bookshelf.dart';
import 'package:project/screens/search/search.dart';
import 'package:project/screens/home/homePage.dart';
import 'package:project/utils/screens.dart';
import 'package:project/screens/write/writeScreen.dart';
import 'package:project/utils/global.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  // Define your pages here
  final List<Widget> _pages = [
    HomePage(),
    WritePage(),
    LibraryPage(),
    SearchPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationScreenState(),
                ),
              );
            },
          ),
          // Profile picture on the right side
          InkWell(
            onTap: () {
              // Navigate to the profile page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(user!.imageUrl),
              ),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex], // Show the current selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          // Update the selected index when a bottom bar item is clicked
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Write',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class WritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WriteEditor();
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BookshelfScreen();
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchScreen();
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatListScreen();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Profile2();
  }
}

