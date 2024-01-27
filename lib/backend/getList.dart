import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/backend/getBook.dart';
import 'package:project/utils/global.dart';


Future<Book> getBookOftheMonth() async {
  DateTime currentDate = DateTime.now();
  var currentMonth = currentDate.month;
  final response = await supabase
      .from('bookofthemonth')
      .select('*')
      .filter('month', 'eq', currentMonth)
      .single();
  Book book = await getBook(response['book_id']);
  return book;
}

Future<void> getPopularProfiles() async {
  final response = await supabase
      .from('populareprofiles')
      .select('*, profiles!fk_profile_id(*)');
  Profile profile;
  for (var row in response as List) {
    profile = await getProfile(row['profile_id']);
    if (!popular.contains(profile)) {
      popular.add(profile);
    }
  }
}

void getAllBooks() async {
  final response = await supabase.from('book').select();

  if (response == null) {
    print('Error fetching books');
  }

  for (var row in response as List) {
    Book book = await getBook(row['book_id']);
    books.add(book);
  }
}

Future<List<Book>> getForYou() async {
  List<Book> forYou = [];
  final ids = await supabase
      .from('foryou')
      .select('category_id')
      .eq('profile_id', user!.id);
  print(ids);
  for (var id in ids as List) {
    final response = await supabase
        .from('book')
        .select('*')
        .eq('category', id['category_id'])
        .limit(10);
    print(response);
    for (var row in response as List) {
      print(response);
      Book book = await getBook(row['book_id']);
      forYou.add(book);
    }
  }
  return forYou;
}