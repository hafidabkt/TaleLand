import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/screens/book/readingEditor.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/utils/global.dart';

Future<Book> createStory(
    selectedCategoryId, title, description, tag, isPublic) async {
  Book temp = Book(
      bookId: 0,
      category: selectedCategoryId,
      title: title,
      image: 'assets/book1.png',
      description: description,
      author: user!,
      tags: tag,
      parts: []);

  final response = await supabase.from('book').upsert([
    {
      'category': temp.category,
      'title': temp.title,
      'image': temp.image,
      'description': temp.description,
      'author_id': user!.id,
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
      .eq('author_id', user!.id)
      .single();

  final bookId = responseAfterInsert['book_id'] as int;
  temp.bookId = bookId;
  if (isPublic) {
    books.add(temp);
    user!.publishedBooks.add(temp.bookId);
    print(books.length);
  } else {
    books.add(temp);
    user!.notPublishedBooks.add(temp.bookId);
    print(user!.notPublishedBooks);
  }
  Part part = Part(content: '', title: '', bookid: temp.bookId);
  List<Part> parts = [];
  parts.add(part);
  temp.parts = parts;
  return temp;
}