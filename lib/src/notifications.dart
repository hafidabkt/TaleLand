import 'package:flutter/material.dart';
import 'package:project/class/notificationClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/class/messageClass.dart';

class NotificationScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: myColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: CustomRectangularButton2(),
    );
  }
}

class CustomRectangularButton2 extends StatefulWidget {
  Profile me = authors[0];
  @override
  _CustomRectangularButtonState2 createState() =>
      _CustomRectangularButtonState2();
}

class _CustomRectangularButtonState2 extends State<CustomRectangularButton2> {
  String selectedOption = 'Notifications';

  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Message> myMessage = [];
    Message m;
    for (m in messages) {
      if (m.reciever == widget.me) {
        myMessage.add(m);
      }
    }
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: myAccent,
            border: Border.all(color: myAccent),
          ),
          child: Row(
            children: <Widget>[
              buildTab('Notifications'),
              buildTab('Messages'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: selectedOption == 'Notifications'
                ? notifications.length
                : myMessage.length,
            itemBuilder: (context, index) {
              return selectedOption == 'Notifications'
                  ? buildNotificationTile(notifications[index])
                  : buildMessageTile(myMessage[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildNotificationTile(notif notification) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myBrownColor,
          boxShadow: [
            BoxShadow(
              color: myBrownColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            notification.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(notification.subtitle,
              style: TextStyle(color: Colors.white)),
          leading: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: myAccent, // Customize the notification color
            ),
            child: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete Notification'),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                notifications.remove(notification);
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }

  Widget buildMessageTile(Message message) {
    // Customize the appearance of the message tile based on your design
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: myBrownColor, // Customize the color for messages
          boxShadow: [
            BoxShadow(
              color: myAccent.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            message.sender.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(message.text, style: TextStyle(color: Colors.white)),
          leading: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: myAccent, // Customize the message color
            ),
            child: Icon(
              Icons.mail_outline,
              color: Colors.white,
            ),
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete Message'),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                messages.remove(message);
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }

  Expanded buildTab(String option) {
    return Expanded(
      child: InkWell(
        onTap: () {
          selectOption(option);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              option,
              style: TextStyle(
                fontSize: 16.0,
                color: selectedOption == option ? Colors.black : Colors.black,
              ),
            ),
            if (selectedOption == option)
              Container(
                height: 2.0,
                width: 130,
                color: myColor,
              ),
          ],
        ),
      ),
    );
  }
}
