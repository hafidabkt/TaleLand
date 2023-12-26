import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/homePage.dart';
import 'package:project/utils/constant.dart';

void likeButton(Book book, bool isLiked) async {
  if (isLiked) {
    user..favoriteBooks.add(book.bookId);
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
    user.readingList.add(book.bookId);
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
    if (user.readingList.contains(book.bookId)) {
      user.readingList.remove(book.bookId);
    } else {
      user.toReadList.remove(book.bookId);
    }
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

Future<int> getPartid(String title, int bookid) async {
  final id = await supabase
      .from('part')
      .select('part_id')
      .eq('title', title)
      .eq('bookid', bookid)
      .single();
  print(id);
  int partid = id['part_id'] as int;
  print(partid);
  return partid;
}

Future<void> publishChapter(Part part, int partid) async {
  if (partid == -1) {
    await supabase.from('part').upsert([
      {
        'title': part.title,
        'content': part.content,
        'bookid': part.bookid,
      }
    ]);
  } else {
    final response = await supabase.from('part').update({
      'title': part.title,
      'content': part.content,
      'bookid': part.bookid,
    }).eq('part_id', partid);
    print(response);
  }
}

void getAllBooks() async {
  final response = await supabase.from('book').select();

  if (response == null) {
    print('Error fetching books');
  }

  for (var row in response as List) {
    print(response);
    Book book = await getBook(row['book_id']);
    books.add(book);
    print(books.first.bookId);
  }
}

Future<Book> getBook(int bookId) async {
  try {
    final response =
        await supabase.from('book').select('*').eq('book_id', bookId).single();

    if (response == null) {
      // Handle the case where the book with the given ID is not found
      throw Exception("Book with ID $bookId not found");
    }

    final row = response;

    // Use 'await' to make sure 'getParts' completes before continuing
    List<Part> parts = await getParts(bookId);

    Book book = Book(
      parts: parts,
      bookId: row['book_id'] as int ?? 0,
      author: await getProfile(row['author_id'] as int ?? 0),
      category: row['category'] as int ?? 0,
      title: row['title']?.toString() ?? '',
      image: row['image']?.toString() ?? '',
      description: row['description']?.toString() ?? '',
      views: row['views'] as int ?? 0,
      isPublished: row['is_published'] as bool ?? false,
      tags: row['tags']?.toString() ?? '',
      comments: row['comments'] as int ?? 0,
      rating: row['rating'] as int ?? 0,
      likes: row['likes'] as int ?? 0,
    );

    return book;
  } catch (e) {
    // Handle exceptions
    print("Error in getBook: $e");
    rethrow; // Rethrow the exception for higher-level error handling
  }
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
      title: row['title']?.toString() ?? '',
      content: row['content']?.toString() ?? '',
      bookid: row['bookid'] as int ?? 0,
    );
    print(part.title);
    parts.add(part);
  }
  return parts;
}

Future<List<Profile>> getPopularProfiles() async {
  final response = await supabase
      .from('populareprofiles')
      .select('*, profiles!fk_profile_id(*)');
  Profile profile;
  List<Profile> profiles = [];
  for (var row in response as List) {
    profile = await getProfile(row['profile_id']);
    profiles.add(profile);
  }
  return profiles;
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

void getBookOftheMonth() async {
  DateTime currentDate = DateTime.now();
  int currentMonth = currentDate.month;

  final response = await supabase
      .from('bookofthemonth')
      .select('*')
      .eq('month', currentMonth)
      .single();
  Book book = await getBook(response['book_id']);
  bookOftheMonth.clear();
  bookOftheMonth.add(book);
}

Future<List<Book>> filterByCategory(String category) async {
  List<Book> filterBooks = [];
  final temp = await supabase
      .from('category')
      .select('category_id')
      .eq('namecategory', category)
      .single();
  int id = temp['category_id'] as int;
  final response = await supabase
      .from('book')
      .select('*, category!fk_category_id(*)')
      .eq('category', id);
  if (response == null) {
    print('Error fetching books');
  }

  for (var row in response as List) {
    print(response);
    Book book = await getBook(row['book_id']);
    filterBooks.add(book);
  }

  print(filterBooks);
  return filterBooks;
}

Future<List<Book>> filterByValue(String value, String selectedFilter) async {
  List<Book> filterBooks = [];
  if (selectedFilter == 'tag') {
    final response =
        await supabase.from('book').select('*').like('tags', value);
    if (response == null) {
      print('Error fetching books');
    }
    for (var row in response as List) {
      print(response);
      Book book = await getBook(row['book_id']);
      filterBooks.add(book);
    }
    print(filterBooks);
  }
  if (selectedFilter == 'title') {
    final response = await supabase.from('book').select('*').eq('title', value);
    if (response == null) {
      print('Error fetching books');
    }
    for (var row in response as List) {
      print(response);
      Book book = await getBook(row['book_id']);
      filterBooks.add(book);
    }
    print(filterBooks);
  }

  return filterBooks;
}

Future<List<Profile>> filterProfile(String value) async {
  List<Profile> filtered = [];
    final response =
        await supabase.from('profiles').select('*').eq('name', value);
    if (response == null) {
      print('Error fetching books');
    }
    for (var row in response as List) {
      print(response);
      Profile profile = await getProfile(row['id']);
      filtered.add(profile);
    }
    print(filtered);
  return filtered;
}
