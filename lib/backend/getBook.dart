import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';


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
    parts = parts.reversed.toList();
    final temp =
        await supabase.from('readinglist').count().eq('book_id', bookId);
    print(temp);
    int views = temp as int;
    Book book = Book(
        parts: parts,
        bookId: row['book_id'] as int ?? 0,
        author: await getProfile(row['author_id'] as int ?? 0),
        category: row['category'] as int ?? 0,
        title: row['title']?.toString() ?? '',
        image: row['image']?.toString() ?? '',
        description: row['description']?.toString() ?? '',
        views: views,
        isPublished: row['is_published'] as bool ?? false,
        tags: row['tags']?.toString() ?? '',
        comments: row['comments'] as int ?? 0,
        rating: row['rating'] as int ?? 0,
        likes: row['likes'] as int ?? 0,
        on_going: row['on_going'] as bool ?? true);

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
    parts.add(part);
  }
  return parts;
}