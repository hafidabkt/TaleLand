import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/global.dart';

List<Book> BooksNotPublished() {
  List<Book> notpublished = [];
  for (int i = 0; i < books.length; i++) {
    if (user!.notPublishedBooks.contains(books[i].bookId)) {
      notpublished.add(books[i]);
    }
  }
  return notpublished;
}

List<Book> BooksPublished() {
  List<Book> published = [];
  
  for (int i = 0; i < books.length; i++) {
    if (user!.publishedBooks.contains(books[i].bookId)) {
      published.add(books[i]);
    }
  }
  return published;
}
