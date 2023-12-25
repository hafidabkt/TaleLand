import 'package:flutter/foundation.dart';

class Profile {
  final int id; // Unique ID for each profile
  final String name;
  final String imageUrl;
  final String email;
  String bio;
  int followers;
  int views;
  int bookList;
  int published;
  String gender;
  List<int> publishedBooks; // List of book IDs published
  List<int> readingList; // List of book IDs being read
  List<int> toReadList; // List of book IDs to read
  List<int> favoriteBooks; // List of favorite book IDs
  List<int> notPublishedBooks; // List of book IDs not published
  List<int> recommendationList; // List of book IDs recommended
  List<int> followersList; // List of follower user IDs
  List<int> followeesList; // List of followee user IDs
  List<int> blockedList; // List of blocked user IDs
  List<int> forYou; // List of category IDs

  Profile({
    required this.id,
    required this.email,
    this.gender = 'F',
    required this.name,
    required this.imageUrl,
    this.bio = '',
    this.followers = 0,
    this.views = 0,
    this.bookList = 0,
    this.published = 0,
    this.forYou = const [],
    this.publishedBooks = const [],
    this.readingList = const [],
    this.favoriteBooks = const [],
    this.followersList = const [],
    this.followeesList = const [],
    this.blockedList = const [],
    this.notPublishedBooks = const [],
    this.recommendationList = const [],
    this.toReadList = const [],
  });
}

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
