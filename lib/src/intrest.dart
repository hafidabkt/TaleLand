import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/class/categoryClass.dart';
import 'package:project/main.dart';
class IntrestScreen extends StatefulWidget {
  final List<bool> isSleceted = [];
  @override
  _IntrestPageState createState() => _IntrestPageState();
}

class _IntrestPageState extends State<IntrestScreen> {
  int numberOfSelected = 0;
  bool canClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                ' Let\'s get started',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 0, left: 20, top: 40, right: 20),
              child: Text(
                'Choose Categories of your Interest',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Set the number of columns
                  crossAxisSpacing: 8.0,
                ),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  widget.isSleceted.add(false);
                  return buildCategoryContainer(categories[index], index);
                },
              ),
            ),
            ElevatedButton(
              onPressed: canClick
                  ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Myapplication()),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: canClick ? myAccent : Colors.grey,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                shadowColor: Colors.black,
              ),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryContainer(Category category, int i) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (widget.isSleceted[i]) numberOfSelected = numberOfSelected - 1;
            if (!widget.isSleceted[i]) numberOfSelected = numberOfSelected + 1;
            widget.isSleceted[i] = !widget.isSleceted[i];
            if (numberOfSelected >= 5) {
              canClick = true;
            } else {
              canClick = false;
            }
          });
        },
        child: Container(
          width: 120,
          height: 200,
          decoration: widget.isSleceted[i]
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: myAccent.withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: Offset(0, 3), // Offset in the x, y axis
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(category.imageUrl),
                    opacity: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage(category.imageUrl),
                    opacity: 50,
                    fit: BoxFit.cover,
                  ),
                ),
          child: Center(
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
