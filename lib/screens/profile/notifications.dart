import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'package:project/backend/notif.dart';
import 'package:project/utils/constant.dart';
import 'package:project/utils/global.dart';

class NotificationScreenState extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
        backgroundColor: myColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        key: _refreshKey,
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> notifications = snapshot.data ?? [];

            return CustomRectangularButton2(
              notifications: notifications,
              refreshKey: _refreshKey,
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final response =
        await supabase.from('notificated').select().eq('user_id', user!.id);
    List<Map<String, dynamic>> notifications = [];
    for (var row in response as List) {
      final notifResponse =
          await supabase.from('notif').select().eq('notif_id', row['notif_id']);
      final notifData = notifResponse;

      if (notifData != null && notifData.isNotEmpty) {
        final notifItem = notifData.first;
        notifications.add({
          'title': notifItem['title'],
          'content': notifItem['content'],
          'notif_id': notifItem['notif_id'],
        });
      }
    }
    return notifications;
  }
}

class CustomRectangularButton2 extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;
  final GlobalKey<RefreshIndicatorState> refreshKey;

  const CustomRectangularButton2(
      {required this.notifications, required this.refreshKey});

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              // Manually trigger a refresh
              return refreshKey.currentState?.show();
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return buildNotificationTile(context, notifications[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotificationTile(
      BuildContext context, Map<String, dynamic> notification) {
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
            notification['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            notification['content'],
            style: TextStyle(color: Colors.white),
          ),
          leading: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: myAccent,
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
            onSelected: (value) async {
              if (value == 'delete') {
                await deleteNotif(notification['notif_id']);
                // Trigger a refresh of the FutureBuilder
                refreshKey.currentState?.show();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Deleting notification'),
                  ),
                );
              }
            },
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
