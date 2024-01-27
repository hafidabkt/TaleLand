import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'package:project/utils/class/messageClass.dart';
import 'package:project/utils/class/profileClass.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _messageController = TextEditingController();
  Profile me = authors[0];
  Profile her = authors[1];
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
              tag: 'user-${her.name}',
              child: CircleAvatar(
                backgroundImage: AssetImage('${her.imageUrl}'),
                radius: 20,
              ),
            ),
            SizedBox(width: 8),
            Text(
              messages[0].reciever.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: messages.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    Message message = messages[index];
                    bool isMe = (message.sender == me);

                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMe)
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(message.sender.imageUrl),
                              radius: 16,
                            ),
                          SizedBox(width: 8),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: isMe && isWhiteMode
                                  ? myAccent
                                  : (isWhiteMode ? myBeige : Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message.text,
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
                                      Message temp = Message(
                                          reciever: her,
                                          sender: me,
                                          text: messageText);
                                      messages.add(temp);
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
                                    Message temp = Message(
                                        reciever: her,
                                        sender: me,
                                        text: heartEmoji);
                                    messages.add(temp);
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
