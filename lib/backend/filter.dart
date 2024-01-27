import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/backend/getBook.dart';

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
    Book book = await getBook(row['book_id']);
    filterBooks.add(book);
  }
  return filterBooks;
}

Future<List<Book>> filterByValue(String value, String selectedFilter) async {
  List<Book> filterBooks = [];
  if (selectedFilter == 'tag') {
    final response =
        await supabase.from('book').select('*').ilike('tags', '%$value%');
    if (response == null) {
      print('Error fetching books');
    }
    for (var row in response as List) {
      Book book = await getBook(row['book_id']);
      filterBooks.add(book);
    }
  }
  if (selectedFilter == 'title') {
    final response =
        await supabase.from('book').select('*').ilike('title', '%$value%');
    if (response == null) {
      print('Error fetching books');
    }
    for (var row in response as List) {
      Book book = await getBook(row['book_id']);
      filterBooks.add(book);
    }
  }

  return filterBooks;
}

Future<List<Profile>> filterProfile(String value) async {
  List<Profile> filtered = [];
  final response =
      await supabase.from('profiles').select('*').ilike('name', '%$value%');
  if (response == null) {
    print('Error fetching books');
  }
  for (var row in response as List) {
    Profile profile = await getProfile(row['id']);
    filtered.add(profile);
  }
  return filtered;
}
