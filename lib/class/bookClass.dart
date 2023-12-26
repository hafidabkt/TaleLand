import 'package:project/backend/backend.dart';

import 'profileClass.dart';

List<Book> forYou = [];
List<Book> bookOftheMonth = [];
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
    this.likes = 0,
    this.rating = 0,
    this.views = 0,
    this.comments = 0,
    this.isPublished = false,
    this.tags = "",
    required this.parts,
  });

  void printDetails() {
    print('Book Details:');
    print('Title: $title');
    print('Category: $category');
    print('Description: $description');
    print('Likes: $likes');
    print('Rating: $rating');
    print('Views: $views');
    print('Comments: $comments');
    print('Published: ${isPublished ? 'Yes' : 'No'}');
    print('Tags: $tags');
    print('Book ID: $bookId');
  }
}

class Part {
  String title;
  String content;
  int bookid;
  

  Part(
      {required this.title,
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
