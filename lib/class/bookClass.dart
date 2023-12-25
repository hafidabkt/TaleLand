import 'package:project/backend/backend.dart';

import 'profileClass.dart';

Part temp = Part(bookid: 1, title: 'I do not understand', content: ''',
  Once upon a time in the heart of a mystical forest, a peculiar mask went missing. The mask, a whimsical creation resembling a mischievous cat's face, had long been a symbol of enchantment and mystery. It was said that whoever possessed the mask would be granted the ability to traverse between the seen and the unseen.

  The mask was the creation of an ancient sorcerer who had long since disappeared, leaving behind only whispers of his magical legacy. Legends spoke of the mask's uncanny ability to reveal hidden realms and secret passages, and those who sought its powers were often drawn to the depths of the forest.

  One day, a young adventurer named Lila stumbled upon an old map that hinted at the mask's location. Driven by curiosity and a longing for adventure, Lila embarked on a journey through the dense woods. The forest, however, was not as welcoming as it seemed, and soon Lila found herself lost among the towering trees and winding paths.

  As night fell, the air became thick with enchantment, and strange sounds echoed through the darkness. Lila, determined to find the mask, pressed on, guided only by the mysterious glow of fireflies. Unbeknownst to her, the forest seemed to have a mischievous spirit of its own, playing tricks on her senses and leading her in circles.

  Suddenly, in the moonlit clearing, Lila spotted a figure wearing the very cat mask she sought. A hand, adorned with ancient markings, reached out and grabbed the mask, disappearing into the shadows. With a mixture of excitement and trepidation, Lila chased after the elusive figure, each step taking her deeper into the heart of the mystical forest.

  The journey led Lila through ethereal landscapes, where talking animals shared ancient tales, and magical doorways opened to realms beyond imagination. As she pursued the masked figure, Lila discovered the true nature of the forest – a realm where lost dreams and forgotten memories intertwined, creating a tapestry of wonder and mystery.

  In the end, the mask was not merely a physical object but a key to unlocking the secrets hidden within oneself. Lila realized that the forest had a way of revealing what was lost, not in the tangible sense, but in the deepest recesses of the heart. As the first light of dawn broke through the canopy, Lila emerged from the forest, forever changed by the enchanting adventure and the wisdom gained in the search for the lost cat mask.
  ''');

List<Part> parts = [
  temp,
  Part(
      title: 'The Come Back',
      content: 'Love is a strong word you guys',
      bookid: 2),
  Part(title: 'Was it a Mistake', content: 'hi', bookid: 2),
  Part(title: 'Was it a Mistake', content: 'hi', bookid: 2)
];
List<Part> p = [Part(title: 'First Part', content: '', bookid: 1)];
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
