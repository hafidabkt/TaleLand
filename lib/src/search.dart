import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/class/categoryClass.dart';
import 'package:project/backend/backend.dart';
import 'package:project/src/filterdBooks.dart';
import 'package:project/src/filterdProfiles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  String searchText = '';
  String selectedFilter = 'tag'; // Default filter
  List<Book> filtered = [];
  List<Profile> filteredProfiles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close, color: Colors.white),
        title: TextField(
          onSubmitted: (value) async {
              showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text("Loading..."),
                    ],
                  ),
                );
              },
            );
            setState(() async {
              searchText = value;
              if (selectedFilter == 'profile') {
                filteredProfiles = await filterProfile(value);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredProfilesScreen(
                        filteredProfiles: filteredProfiles),
                  ),
                );
                
              } else {
                filtered = await filterByValue(value, selectedFilter);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FilteredBooksScreen(filtered: filtered),
                  ),
                );
              }
            }
            );
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
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCategoryContainer(category:categories[index]);
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
}

class buildCategoryContainer extends StatefulWidget {
  final Category category;

  buildCategoryContainer({required this.category});

  @override
  _buildCategoryContainer createState() => _buildCategoryContainer();
}

class _buildCategoryContainer extends State<buildCategoryContainer> {
  late Widget center;

  @override
  void initState() {
    super.initState();
    center = Text(
      widget.category.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
    void reloadScreen() {
    setState(() {
      center = Text(
        widget.category.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          
          print('Category pressed: ${widget.category.name}');
          setState(() {
            center = CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          });
          List<Book> filtered = await filterByCategory(widget.category.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilteredBooksScreen(filtered: filtered),
            )
           );
          reloadScreen();
        },
        child: Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(widget.category.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(child: center),
        ),
      ),
    );
  }
}

