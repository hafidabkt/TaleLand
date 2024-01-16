
import 'package:project/class/profileClass.dart';
List<Profile> authors = [
  Profile(
    id: 1,
    email: 'janemarie@email.com',
    name: 'Jane Marie',
    imageUrl: 'assets/profile01.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: 120,
    views: 500,
    bookList: 15,
    published: 7,
    publishedBooks: [1, 2, 3],
    readingList: [4, 5],
    favoriteBooks: [6, 7],
    followersList: [],
    followeesList: [],
    blockedList: [],
    forYou: [1, 3],
    toReadList: [],
    recommendationList: [],
    notPublishedBooks: [],
  ),
  Profile(
    id: 2,
    email: 'stefclark@email.com',
    name: 'stef Clark',
    imageUrl: 'assets/profile02.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: 120,
    views: 500,
    bookList: 15,
    published: 7,
    publishedBooks: [1, 2, 3],
    readingList: [4, 5],
    favoriteBooks: [6, 7],
    followersList: [],
    followeesList: [],
    blockedList: [],
    forYou: [1, 3],
  ),
  Profile(
    id: 3,
    email: 'lorafoll@email.com',
    name: 'Lora Foll',
    imageUrl: 'assets/profile03.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: 120,
    views: 500,
    bookList: 15,
    published: 7,
    publishedBooks: [1, 2, 3],
    readingList: [4, 5],
    favoriteBooks: [6, 7],
    followersList: [],
    followeesList: [],
    blockedList: [],
    forYou: [1, 3],
  ),
  Profile(
    id: 4,
    email: 'jamesbou@email.com',
    name: 'James Bou',
    imageUrl: 'assets/profile04.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: 120,
    views: 500,
    bookList: 15,
    published: 7,
    publishedBooks: [1, 2, 3],
    readingList: [4, 5],
    favoriteBooks: [6, 7],
    followersList: [8, 9],
    followeesList: [10, 11],
    blockedList: [],
    forYou: [1, 3],
    recommendationList: [1],
  ),
];

class Message {
  String text;
  Profile sender;
  Profile reciever;
  bool seen;
  String time;
  Message(
      {required this.text,
      this.seen = false,
      required this.reciever,
      required this.sender,
      this.time = '10:45AM'});
}

List<Message> messages = [
  Message(text: 'Wow!', sender: authors[0], reciever: authors[1]),
  Message(text: 'Wow!', sender: authors[1], reciever: authors[0]),
  Message(text: 'Wow!', sender: authors[0], reciever: authors[1]),
  Message(text: 'Wow!', sender: authors[0], reciever: authors[0]),
];
