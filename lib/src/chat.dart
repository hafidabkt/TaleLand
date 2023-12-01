import 'package:flutter/material.dart';
import 'package:project/src/color.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String image;

  ChatScreen({required this.userName,required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [
    {'text': 'Wow!', 'isMe': false, 'senderPic': 'assets/profile01.png'},
    {
      'text': 'The plot twist',
      'isMe': true,
      'senderPic': 'assets/profile01.png'
    },
    {
      'text': 'Yes never thought it would be like that',
      'isMe': false,
      'senderPic': 'assets/profile01.png'
    },
    {'text': 'love it', 'isMe': true, 'senderPic': 'assets/profile01.png'},
  ];

  bool isWhiteMode = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the screen is built
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'user-${widget.userName}',
              child: CircleAvatar(
                backgroundImage: AssetImage('${widget.image}'),
                radius: 20,
              ),
            ),
            SizedBox(width: 8),
            Text(widget.userName,style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),),
          ],
        ),
        actions: [
          IconButton(
            icon: isWhiteMode
                ? Icon(Icons.wb_sunny)
                : Icon(Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isWhiteMode = !isWhiteMode;
              });
            },
          ),
        ],
      ),
      backgroundColor: myColor,
      body: Container(
        
        decoration: BoxDecoration(
          color: isWhiteMode ? Colors.white : Color.fromARGB(255, 26, 26, 26),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: _messages.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  Map<String, dynamic> message = _messages[index];
                  bool isMe = message['isMe'];

                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          CircleAvatar(
                            backgroundImage: AssetImage(message['senderPic']),
                            radius: 16,
                          ),
                        SizedBox(width: 8),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isMe && isWhiteMode
                                ? myAccent
                                : (isWhiteMode
                                    ? myBeige
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(
                              color: isWhiteMode
                                  ? Colors.black
                                  : (isMe ? Colors.grey : Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: isWhiteMode
                            ? Color.fromARGB(255, 231, 229, 229)
                            : Color.fromARGB(255, 34, 34, 34),
                        hintStyle: TextStyle(
                          color: isWhiteMode ? Colors.black : Colors.white,
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                String messageText = _messageController.text;
                                if (messageText.isNotEmpty) {
                                  setState(() {
                                    _messages.add({
                                      'text': messageText,
                                      'isMe': true,
                                      'senderPic': 'assets/avatar.png'
                                    });
                                  });
                                }
                                _messageController.clear();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                String heartEmoji = '❤️';
                                setState(() {
                                  _messages.add({
                                    'text': heartEmoji,
                                    'isMe': true,
                                    'senderPic': widget.image,
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
