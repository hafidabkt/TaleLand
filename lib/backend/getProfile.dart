import 'package:project/utils/class/profileClass.dart';
import 'package:project/utils/constant.dart';

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
  print(notPublishedBooks);
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
  Profile prof = Profile(
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
  return prof;
}