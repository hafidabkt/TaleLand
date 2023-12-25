import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/main.dart';
import 'package:project/src/homePage.dart';
import 'package:project/utils/constant';

void likeButton(Book book, bool isLiked) async {
  if (isLiked) {
    user.favoriteBooks.add(book.bookId);
    book.likes++;
    final response = await supabase.from('book').update({
      'likes': book.likes,
    }).eq('book_id', book.bookId);
    await supabase.from('favoritebooks').upsert([
      {
        'profile_id': user.id,
        'book_id': book.bookId,
      },
    ]);
  } else {
    user.favoriteBooks.remove(book.bookId);
    book.likes--;
    final response = await supabase.from('book').update({
      'likes': book.likes,
    }).eq('book_id', book.bookId);
    await supabase.from('favoritebooks').delete().eq('book_id', book.bookId);
  }
}

void saveButton(Book book, bool saved) async {
  if (saved) {
    final response = await (user.readingList.contains(book.bookId)
            ? supabase.from('readinglist')
            : supabase.from('toreadlist'))
        .upsert([
      {
        'profile_id': user.id,
        'book_id': book.bookId,
      },
    ]);
  } else {
    final response = await (user.readingList.contains(book.bookId)
            ? supabase.from('readinglist')
            : supabase.from('toreadlist'))
        .delete()
        .eq('book_id', book.bookId);
  }
}

Future<Book> createStory(
    selectedCategoryId, title, description, tag, isPublic) async {
  Book temp = Book(
      bookId: 0,
      category: selectedCategoryId,
      title: title,
      image: 'assets/book1.png',
      description: description,
      author: user,
      tags: tag,
      parts: []);

  if (isPublic) {
    books.add(temp);
    user.publishedBooks.add(temp.bookId);
    print(books.length);
  } else {
    notPublished.add(temp);
    user.notPublishedBooks.add(temp.bookId);
    print(user.notPublishedBooks);
  }

  final response = await supabase.from('book').upsert([
    {
      'category': temp.category,
      'title': temp.title,
      'image': temp.image,
      'description': temp.description,
      'author_id': user.id,
      'likes': 0,
      'rating': 0.0,
      'views': 0,
      'comments': 0,
      'is_published': isPublic,
      'tags': temp.tags,
    },
  ]);

  final responseAfterInsert = await supabase
      .from('book')
      .select('book_id')
      .eq('title', temp.title)
      .eq('author_id', user.id)
      .single();

  final bookId = responseAfterInsert['book_id'] as int;

  temp.bookId = bookId;

  Part part = Part(content: '', title: '', bookid: temp.bookId);
  List<Part> parts = [];
  parts.add(part);
  temp.parts = parts;

  return temp;
}

Future<void> publishChapter(Part part) async {
  await supabase.from('part').upsert([
    {
      'title': part.title,
      'content': part.content,
      'bookid': part.bookid,
    }
  ]);
}

Future<List<Book>> getAllBooks() async {
  final response = await supabase.from('book').select();

  if (response == null) {
    print('Error fetching books');
    return [];
  }

  List<Book> books = [];

  for (var row in response as List) {
    List<Part> parts = await getParts(row['book_id']);
    Book book = Book(
      parts: parts,
      bookId: row['book_id'] as int,
      author: await getProfile(row['author_id']),
      category: row['category'] as int,
      title: row['title'] as String,
      image: row['image'] as String,
      description: row['description'] as String,
      views: row['views'] as int,
      isPublished: row['is_published'] as bool,
      tags: row['tags'] as String,
      comments: row['comments'] as int,
      rating: row['rating'] as int,
      likes: row['likes'] as int,
    );

    books.add(book);
  }

  return books;
}

Future<List<Part>> getParts(int bookId) async {
  final response = await supabase
      .from('part')
      .select()
      .eq('bookid', bookId)
      .order('part_id');

  if (response == null) {
    print('Error fetching parts');
    return [];
  }

  List<Part> parts = [];

  for (var row in response as List) {
    Part part = Part(
      title: row['title'] as String,
      content: row['content'] as String,
      bookid: row['bookid'] as int,
    );
    print(part.title);
    parts.add(part);
  }
  return parts;
}

Future<Profile> getProfile(int id) async {
  final readinglist =
      await supabase.from('readinglist').select('book_id').eq('profile_id', id);

  List<int> readingList = (readinglist as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (readingList == null) {
    readingList = [];
  }

  final toreadlist =
      await supabase.from('toreadlist').select('book_id').eq('profile_id', id);

  List<int> toreadList = (toreadlist as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (toreadList == null) {
    toreadList = [];
  }

  final recommendationlist = await supabase
      .from('recommendationlist')
      .select('book_id')
      .eq('profile_id', id);

  List<int> recommendationList = (recommendationlist as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (recommendationList == null) {
    recommendationList = [];
  }

  final publishedbooks = await supabase
      .from('book')
      .select('book_id')
      .eq('author_id', id)
      .eq('is_published', true);

  List<int> publishedBooks = (publishedbooks as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (publishedBooks == null) {
    publishedBooks = [];
  }

  final notPublishedbooks = await supabase
      .from('book')
      .select('book_id')
      .eq('author_id', id)
      .eq('is_published', false);

  List<int> notPublishedBooks = (notPublishedbooks as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (notPublishedBooks == null) {
    notPublishedBooks = [];
  }

  final favoritebooks = await supabase
      .from('favoritebooks')
      .select('book_id')
      .eq('profile_id', id);

  List<int> favoriteBooks = (favoritebooks as List<dynamic>)
      .map((dynamic item) => item['book_id'] as int)
      .toList();
  if (favoriteBooks == null) {
    favoriteBooks = [];
  }

  final followerslist = await supabase
      .from('followings')
      .select('follower_id')
      .eq('followee_id', id);

  List<int> followersList = (followerslist as List<dynamic>)
      .map((dynamic item) => item['follower_id'] as int)
      .toList();
  if (followersList == null) {
    followersList = [];
  }

  final followeeslist = await supabase
      .from('followings')
      .select('followee_id')
      .eq('follower_id', id);

  List<int> followeesList = (followeeslist as List<dynamic>)
      .map((dynamic item) => item['followee_id'] as int)
      .toList();
  if (followeesList == null) {
    followeesList = [];
  }

  final blockedlist = await supabase
      .from('blockedlist')
      .select('blocked_profile_id')
      .eq('blocker_id', id);

  List<int> blockedList = (blockedlist as List<dynamic>)
      .map((dynamic item) => item['blocked_profile_id'] as int)
      .toList();
  if (blockedList == null) {
    blockedList = [];
  }

  final foryou =
      await supabase.from('foryou').select('category_id').eq('profile_id', id);

  List<int> forYou = (foryou as List<dynamic>)
      .map((dynamic item) => item['category_id'] as int)
      .toList();
  if (forYou == null) {
    forYou = [];
  }

  final profile =
      await supabase.from('profiles').select('*').eq('id', id).single();
  String imageUrl = profile['image_url'] == null
      ? 'assets/profile.png'
      : profile['image_url'];
  String gender = profile['gender'] == null ? 'Non Binary' : profile['gender'];
  String bio = profile['bio'] == null ? '' : profile['bio'];

  final views = await supabase.from('book').count().eq('author_id', id);
  user = Profile(
    email: profile['email'],
    name: profile['name'],
    imageUrl: imageUrl,
    readingList: readingList,
    toReadList: toreadList,
    recommendationList: recommendationList,
    publishedBooks: publishedBooks,
    notPublishedBooks: notPublishedBooks,
    favoriteBooks: favoriteBooks,
    followersList: followersList,
    followeesList: followeesList,
    blockedList: blockedList,
    followers: followersList.length,
    bookList: readingList.length,
    forYou: forYou,
    published: publishedBooks.length,
    gender: gender,
    views: views,
    bio: bio,
    id: id,
  );
  return user;
}
