import 'package:project/class/bookClass.dart';
import 'package:project/main.dart';

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
