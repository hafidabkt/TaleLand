import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/Home.dart';
import 'package:project/src/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project/class/profileClass.dart';


Profile user = authors[0];

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

void main() {
  runApp(MyApp());
}
