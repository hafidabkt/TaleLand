import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/class/categoryClass.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  String searchText = '';
  String selectedFilter = 'tag'; // Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close, color: Colors.white),
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildFilterButton('Tag', 'tag'),
                buildFilterButton('Profile', 'profile'),
                buildFilterButton('Title', 'title'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              height: 400,
              child: Center(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Set the number of columns
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCategoryContainer(categories[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(String text, String filter) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      style: ButtonStyle(
        backgroundColor: selectedFilter == filter
            ? MaterialStateProperty.all<Color>(myAccent)
            : MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size.fromWidth(100),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedFilter == filter ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildCategoryContainer(Category category) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Handle category press
          print('Category pressed: ${category.name}');
        },
        child: Container(
          width: 120, // Set your preferred width
          height: 160, // Set your preferred height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(category.imageUrl),
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
