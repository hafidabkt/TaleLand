import 'package:flutter/foundation.dart';

List<Profile> popular = [];

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

