import 'package:flutter/material.dart';
import 'listTile.dart';

class MyListmessages extends StatelessWidget {
  const MyListmessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            CustomListTile(
                title: 'Besmala Bendif',
                subtitle: '2 new messages',
                avatarUrl: 'assets/images/login.png'),
          ],
        ),
      ),
    );
  }
}
