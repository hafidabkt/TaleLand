import 'package:flutter/foundation.dart';

class Profile {
  static int _nextId = 1; // Static variable to track the next available ID
  final int id; // Unique ID for each profile
  final String name;
  final String imageUrl;
  final String email;
  String bio;
  String followers;
  String views;
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
    required this.email,
    this.gender = 'F',
    required this.name,
    required this.imageUrl,
    this.bio = '',
    this.followers = '0',
    this.views = '0',
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
  }) : id = _nextId++; // Assign the next available ID and increment it

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'bio': bio,
      'followers': followers,
      'views': views,
      'bookList': bookList,
      'published': published,
      'gender': gender,
      'publishedBooks': publishedBooks.join(','), // Convert List to comma-separated string
      'readingList': readingList.join(','),
      'toReadList': toReadList.join(','),
      'favoriteBooks': favoriteBooks.join(','),
      'notPublishedBooks': notPublishedBooks.join(','),
      'recommendationList': recommendationList.join(','),
      'followersList': followersList.join(','),
      'followeesList': followeesList.join(','),
      'blockedList': blockedList.join(','),
      'forYou': forYou.join(','),
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      email: map['email'] ?? '',
      name: map['name'],
      imageUrl: map['imageUrl'],
      bio: map['bio'],
      followers: map['followers'],
      views: map['views'],
      bookList: map['bookList'],
      published: map['published'],
      gender: map['gender'],
      publishedBooks: (map['publishedBooks'] as String).split(',').map((e) => int.parse(e)).toList(),
      readingList: (map['readingList'] as String).split(',').map((e) => int.parse(e)).toList(),
      toReadList: (map['toReadList'] as String).split(',').map((e) => int.parse(e)).toList(),
      favoriteBooks: (map['favoriteBooks'] as String).split(',').map((e) => int.parse(e)).toList(),
      notPublishedBooks: (map['notPublishedBooks'] as String).split(',').map((e) => int.parse(e)).toList(),
      recommendationList: (map['recommendationList'] as String).split(',').map((e) => int.parse(e)).toList(),
      followersList: (map['followersList'] as String).split(',').map((e) => int.parse(e)).toList(),
      followeesList: (map['followeesList'] as String).split(',').map((e) => int.parse(e)).toList(),
      blockedList: (map['blockedList'] as String).split(',').map((e) => int.parse(e)).toList(),
      forYou: (map['forYou'] as String).split(',').map((e) => int.parse(e)).toList(),
    );
  }
}

List<Profile> authors = [
  Profile(
    email: 'janemarie@email.com',
    name: 'Jane Marie',
    imageUrl: 'assets/profile01.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: '120',
    views: '500',
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
  ),
  Profile(
    email: 'stefclark@email.com',
    name: 'stef Clark',
    imageUrl: 'assets/profile02.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: '120',
    views: '500',
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
    email: 'lorafoll@email.com',
    name: 'Lora Foll',
    imageUrl: 'assets/profile03.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: '120',
    views: '500',
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
    email: 'jamesbou@email.com',
    name: 'James Bou',
    imageUrl: 'assets/profile04.png',
    bio:
        'Hello, I am a writer, and this is my profile. I hope you like it. Nice to meet you all ^^',
    followers: '120',
    views: '500',
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
