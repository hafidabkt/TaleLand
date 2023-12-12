// import 'package:cloud_firestore/cloud_firestore.dart';

// class Book {
//   String title;
//   String image;
//   String description;
//   Profile author;
//   bool isPublished;
//   bool isLiked;
//   int rating;
//   bool saved;
//   int likes;
//   int views;
//   int comments;
//   String tags;
//   int bookId;
//   List<Part> parts;

//   Book({
//     this.bookId = 1,
//     required this.title,
//     required this.image,
//     required this.description,
//     required this.author,
//     this.likes = 0,
//     this.isLiked = false,
//     this.rating = 0,
//     this.saved = false,
//     this.views = 0,
//     this.comments = 0,
//     this.isPublished = false,
//     this.tags = "",
//     required this.parts,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'image': image,
//       'description': description,
//       'author': author.toMap(),
//       'isPublished': isPublished,
//       'isLiked': isLiked,
//       'rating': rating,
//       'saved': saved,
//       'likes': likes,
//       'views': views,
//       'comments': comments,
//       'tags': tags,
//       'bookId': bookId,
//       'parts': parts.map((part) => part.toMap()).toList(),
//     };
//   }

//   factory Book.fromMap(Map<String, dynamic> map) {
//     return Book(
//       bookId: map['bookId'] ?? 1,
//       title: map['title'] ?? '',
//       image: map['image'] ?? '',
//       description: map['description'] ?? '',
//       author: Profile.fromMap(map['author'] ?? {}),
//       isPublished: map['isPublished'] ?? false,
//       isLiked: map['isLiked'] ?? false,
//       rating: map['rating'] ?? 0,
//       saved: map['saved'] ?? false,
//       likes: map['likes'] ?? 0,
//       views: map['views'] ?? 0,
//       comments: map['comments'] ?? 0,
//       tags: map['tags'] ?? '',
//       parts: (map['parts'] as List<dynamic> ?? [])
//           .map((part) => Part.fromMap(part))
//           .toList(),
//     );
//   }
// }

// class Part {
//   String title;
//   String content;

//   Part({
//     required this.title,
//     required this.content,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'content': content,
//     };
//   }

//   factory Part.fromMap(Map<String, dynamic> map) {
//     return Part(
//       title: map['title'] ?? '',
//       content: map['content'] ?? '',
//     );
//   }
// }

// class Category {
//   final String name;
//   final String imageUrl;

//   Category(this.name, this.imageUrl);

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory Category.fromMap(Map<String, dynamic> map) {
//     return Category(
//       map['name'] ?? '',
//       map['imageUrl'] ?? '',
//     );
//   }
// }

// class Profile {
//   final String name;
//   final String imageUrl;
//   String bio;
//   String followers;
//   String views;
//   int bookList;
//   int published;
//   List<Book> publishedBooks;
//   List<Book> readingList;
//   List<Book> favoriteBooks;
//   List<Profile> followersList;
//   List<Profile> followeesList;
//   List<BlockedProfile> blockedList;
//   List<Category> forYou;

//   Profile({
//     required this.name,
//     required this.imageUrl,
//     this.bio = '',
//     this.followers = '0',
//     this.views = '0',
//     this.bookList = 0,
//     this.published = 0,
//     this.publishedBooks = const [],
//     this.readingList = const [],
//     this.favoriteBooks = const [],
//     this.followersList = const [],
//     this.followeesList = const [],
//     this.blockedList = const [],
//     required this.forYou,
//   });

//   factory Profile.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return Profile(
//       name: data['name'] ?? '',
//       imageUrl: data['imageUrl'] ?? '',
//       bio: data['bio'] ?? '',
//       followers: data['followers'] ?? '0',
//       views: data['views'] ?? '0',
//       bookList: data['bookList'] ?? 0,
//       published: data['published'] ?? 0,
//       publishedBooks: (data['publishedBooks'] as List<dynamic> ?? [])
//           .map((entry) => Book.fromMap(entry))
//           .toList(),
//       readingList: (data['readingList'] as List<dynamic> ?? [])
//           .map((entry) => Book.fromMap(entry))
//           .toList(),
//       favoriteBooks: (data['favoriteBooks'] as List<dynamic> ?? [])
//           .map((entry) => Book.fromMap(entry))
//           .toList(),
//       followersList: (data['followersList'] as List<dynamic> ?? [])
//           .map((entry) => Profile.fromMap(entry))
//           .toList(),
//       followeesList: (data['followeesList'] as List<dynamic> ?? [])
//           .map((entry) => Profile.fromMap(entry))
//           .toList(),
//       blockedList: (data['blockedList'] as List<dynamic> ?? [])
//           .map((entry) => BlockedProfile.fromMap(entry))
//           .toList(),
//       forYou: (data['forYou'] as List<dynamic> ?? [])
//           .map((entry) => Category.fromMap(entry))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'imageUrl': imageUrl,
//       'bio': bio,
//       'followers': followers,
//       'views': views,
//       'bookList': bookList,
//       'published': published,
//       'publishedBooks': publishedBooks.map((entry) => entry.toMap()).toList(),
//       'readingList': readingList.map((entry) => entry.toMap()).toList(),
//       'favoriteBooks': favoriteBooks.map((entry) => entry.toMap()).toList(),
//       'followersList': followersList.map((entry) => entry.toMap()).toList(),
//       'followeesList': followeesList.map((entry) => entry.toMap()).toList(),
//       'blockedList': blockedList.map((entry) => entry.toMap()).toList(),
//       'forYou': forYou.map((entry) => entry.toMap()).toList(),
//     };
//   }

//   Future<void> saveToFirestore(String userId) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('profiles')
//           .doc(userId)
//           .set(toMap());
//       print('Profile saved to Firestore');
//     } catch (e) {
//       print('Error saving profile to Firestore: $e');
//     }
//   }
// }

// class BlockedProfile {
//   final String blockedUserId;
//   final String blockedUserName;
//   final String blockedUserImageUrl;

//   BlockedProfile({
//     required this.blockedUserId,
//     required this.blockedUserName,
//     required this.blockedUserImageUrl,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'blockedUserId': blockedUserId,
//       'blockedUserName': blockedUserName,
//       'blockedUserImageUrl': blockedUserImageUrl,
//     };
//   }

//   factory BlockedProfile.fromMap(Map<String, dynamic> map) {
//     return BlockedProfile(
//       blockedUserId: map['blockedUserId'] ?? '',
//       blockedUserName: map['blockedUserName'] ?? '',
//       blockedUserImageUrl: map['blockedUserImageUrl'] ?? '',
//     );
//   }
// }
