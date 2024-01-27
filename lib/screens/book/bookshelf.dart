import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/book/readingEditor.dart';
import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/global.dart';

class BookshelfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.class_),
        title: Text('BookShelf'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSection('Reading', theBooks(user!.readingList), context),
            buildSection('To Read', theBooks(user!.toReadList), context),
            buildSection('Favorites', theBooks(user!.favoriteBooks), context),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Book> mylist, context) {
    if (mylist.isEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        Center(
        child: Container(
                          margin: EdgeInsets.all(40.0),
                          child: SvgPicture.asset('empty.svg',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),)
      ]);
    }
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
            itemCount: mylist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to book details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => readerScreen(book: mylist[index]),
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
                            mylist[index].image,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        mylist[index].title,
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

List<Book> theBooks(List<int> listbook) {
  List<Book> mylist = [];
  for (int i = 0; i < listbook.length; i++) {
    for (int j = 0; j < books.length; j++) {
      if (books[j].bookId == listbook[i]) {
        mylist.add(books[j]);
      }
    }
  }
  print(mylist);
  return mylist;
}
