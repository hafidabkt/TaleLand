import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/theme/color.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myAccent,
        title: Text('Theme Selector',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(firstColor, firstAccent);
                    },
                    child: _buildAnimatedContainer(firstColor, firstAccent),
                  ),
                ),
                SizedBox(width: 16), // Adjust the margin between containers
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(secondColor, secondAccent);
                    },
                    child: _buildAnimatedContainer(secondColor, secondAccent),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(fifthColor, fifthAccent);
                    },
                    child: _buildAnimatedContainer(fifthColor, fifthAccent),
                  ),
                ),
                SizedBox(width: 16), // Adjust the margin between containers
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(sexColor, sexAccent);
                    },
                    child: _buildAnimatedContainer(sexColor, sexAccent),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(thirdtColor, thirdAccent);
                    },
                    child: _buildAnimatedContainer(thirdtColor, thirdAccent),
                  ),
                ),
                SizedBox(width: 16), // Adjust the margin between containers
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _updateSelectedColor(forthColor, forthAccent);
                    },
                    child: _buildAnimatedContainer(forthColor, forthAccent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectedColor(Color color, Color accent) {
    setState(() {
      myAccent = accent;
      myColor = color;
      Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Myapplication()));
      
    });
  }

  Widget _buildAnimatedContainer(Color accentColor, Color backgroundColor) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [accentColor, backgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Text(
          'Theme',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
