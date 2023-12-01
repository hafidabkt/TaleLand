import 'package:flutter/material.dart';
import 'package:project/src/readingEditor.dart';
import 'package:project/class/bookClass.dart';

class BookshelfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.class_),
          title: 
          Text('BookShelf'),
    
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSection('Reading', books.sublist(0,3), context),
            buildSection('To Read', books.sublist(3,5), context),
            buildSection('Favorites', books.sublist(5,9), context),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Book> books, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: 0, left: 25, top: 12, right: 20),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to book details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => readerScreen(book: books[index]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Image.asset(
                            books[index].image,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        books[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
