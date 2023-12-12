import 'package:project/class/bookClass.dart';
import 'package:flutter/material.dart';
class bookList extends StatelessWidget {
  final List<int> book;
  bookList({required this.book});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: book.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 110.0, // Adjust the width as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white, // Background color of the container
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                books[findIndex(books, book[index])].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

int findIndex(List<Book> bookies, int bookId) {
  for (int i = 0; i < bookies.length; i++) {
    if (bookies[i].bookId == bookId) {
      return i;
    }
  }
  return -1;
}