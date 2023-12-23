import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';

Future<List<Book>> fetchBooks() async {
  try {
    final response =
        await Supabase.instance.client.from('Book').select('*').execute();

    if (response.error != null) {
      print('Error fetching data: ${response.error}');
      return [];
    }

    // Map the retrieved data to your Book objects
    List<Book> books = (response.data as List<dynamic>).map<Book>((bookData) {
      List<Part> parts = (bookData['parts'] as List<dynamic>)
          .map((partMap) => Part.fromMap(partMap))
          .toList();

      Book book = Book.fromMap(bookData);
      book.setAuthorAndParts(authors[bookData['author_id']], parts);

      return book;
    }).toList();

    return books;
  } catch (error) {
    print('Error fetching data: $error');
    return [];
  }
}
