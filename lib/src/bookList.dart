import 'package:project/class/bookClass.dart';
import 'package:flutter/material.dart';
import 'package:project/src/bookDetailScreen.dart';

class bookList extends StatelessWidget {
  final List<int> book;
  final List<Book> bookies;
  bookList({required this.book, required this.bookies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 150, // Adjust the width as needed
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white, // Background color of the container
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: book.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to book details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsScreen(
                          book: findIndex(bookies, book[index])),
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
                            findIndex(bookies, book[index]).image,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Book findIndex(List<Book> bookies, int bookId) {
  for (int i = 0; i < bookies.length; i++) {
    if (bookies[i].bookId == bookId) {
      return bookies[i];
    }
  }
  return bookies[0];
}
