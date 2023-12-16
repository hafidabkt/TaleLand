import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/Home.dart';
import 'package:project/src/signup_screen.dart';
import 'dataBase/dataBaseHelper.dart'; // Replace with the actual path

Profile user = authors[0];
void main() async {
  // Initialize the database helper
  // DatabaseHelper databaseHelper = DatabaseHelper();

  // // Initialize the database
  // await databaseHelper.initDatabase();

  // // Call your database methods
  // await databaseHelper.insertBook(books.first);
  // await databaseHelper
  //     .printBookDetails(1); // Replace 1 with the desired book ID

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class Myapplication extends StatefulWidget {
  @override
  _MyapplicationState createState() => _MyapplicationState();
}

class _MyapplicationState extends State<Myapplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jost',
      ),
      home: Screen2(),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}
