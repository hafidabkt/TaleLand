import 'package:flutter/material.dart';
import 'package:project/screens/home/Home.dart';
import 'package:project/screens/Inapp/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project/backend/getList.dart';

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
    getPopularProfiles();
    getAllBooks();
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreen() 
    );
  }
}
