import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/Home.dart';
import 'package:project/src/homePage.dart';
import 'package:project/src/signup_screen.dart';
import 'dataBase/dataBaseHelper.dart'; // Replace with the actual path
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:project/utils/constant.dart';
import 'package:project/src/intrest.dart';

Profile user = authors[0];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwdGt3aWlucHdwdWt0dWt4ZWlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5MDExNDMsImV4cCI6MjAxODQ3NzE0M30.TEMqnlIWzX5kNEfYQcNVVdXXhOiai19ptn2e0GHICss',
      url: 'https://tptkwiinpwpuktukxeik.supabase.co');

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

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  User? _user;
  @override
  void initState() {
    _getAuth();
    super.initState();
  }

  Future<void> _getAuth() async {
    setState(() {
      _user = client.auth.currentUser;
    });
    client.auth.onAuthStateChange.listen((event) {
      _user = event.session?.user;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _user == null ? const SignUpScreen() : IntrestScreen(),
    );
  }
}
