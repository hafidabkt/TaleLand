import 'package:project/backend/backend.dart';

import 'profileClass.dart';

List<Book> books = [];

class Book {
  int category;
  String title;
  String image;
  String description;
  Profile author;
  bool isPublished;
  int rating;
  int likes;
  int views;
  bool on_going;
  int comments;
  String tags;
  int bookId;
  List<Part> parts;

  Book({
    required this.bookId,
    required this.category,
    required this.title,
    required this.image,
    required this.description,
    required this.author,
    this.on_going = true,
    this.likes = 0,
    this.rating = 0,
    this.views = 0,
    this.comments = 0,
    this.isPublished = false,
    this.tags = "",
    required this.parts,
  });
}

class Part {
  String title;
  String content;
  int bookid;
  Part({
    required this.title,
    required this.content,
    required this.bookid,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
