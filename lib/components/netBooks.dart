import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';

List<Book> BooksNotPublished() {
  List<Book> notpublished = [];
  for (int i = 0; i < books.length; i++) {
    if (user.publishedBooks.contains(books[i].bookId)) {
      notpublished.add(books[i]);
    }
  }
  return notpublished;
}

List<Book> Foryou() {
  List<Book> foryou = [];
  for (int i = 0; i < books.length; i++) {
    if (user.forYou.contains(books[i].bookId)) {
      foryou.add(books[i]);
    }
  }
  return foryou;
}

List<Book> BooksPublished() {
  List<Book> published = [];
  
  for (int i = 0; i < books.length; i++) {
    if (user.publishedBooks.contains(books[i].bookId)) {
      published.add(books[i]);
    }
  }
  return published;
}
