import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/chat.dart';
import 'package:project/src/color.dart';
import 'package:project/class/messageClass.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  String _selectedFilter = 'All'; // Default filter

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start the animation when the screen is built
    _animationController.forward();
  }
  Profile her = authors[1];
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        leading: Icon(Icons.close, color: myColor),
        actions: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildFilterButton('All', 'All'),
                buildFilterButton('Private', 'Private'),
                buildFilterButton('Public', 'Public'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: myColor,
      body: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            color: Colors.white, // Set your preferred background color
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    buildChatUserTile(messages.last),
                    Divider(),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FadeTransition(
                  opacity: _animationController,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterButton(String text, String filterValue) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedFilter = filterValue;
        });
      },
      style: ButtonStyle(
        backgroundColor: _selectedFilter == filterValue
            ? MaterialStateProperty.all<Color>(myAccent)
            : MaterialStateProperty.all<Color>(myColor),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size.fromWidth(100),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChatUserTile(
    Message message
  ) {
    // You can add logic here to filter based on the selected filter (_selectedFilter)
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('${her.imageUrl}'), // Replace with actual image
      ),
      title: Text(
        her.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          text: (her == message.sender) ?
          message.text : 'You: ${message.text}',
          style: TextStyle(
            fontWeight: message.seen ? FontWeight.normal : FontWeight.bold,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
      trailing: Text(
        message.time,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
