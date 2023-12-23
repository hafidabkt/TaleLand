import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/Home.dart';
import 'package:project/src/signup_screen.dart';
import 'dart:async';
import 'package:project/class/bookClass.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project/backend/dataBaseHelper.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tptkwiinpwpuktukxeik.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwdGt3aWlucHdwdWt0dWt4ZWlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5MDExNDMsImV4cCI6MjAxODQ3NzE0M30.TEMqnlIWzX5kNEfYQcNVVdXXhOiai19ptn2e0GHICss',
  );
  Widget build(BuildContext context) {
    return MyApp();
  }
}
