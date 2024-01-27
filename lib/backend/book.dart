import 'package:project/utils/class/bookClass.dart';
import 'package:project/screens/book/readingEditor.dart';
import 'package:project/utils/constant.dart';
import 'package:project/utils/global.dart';

void saveButton(Book book, bool saved) async {
  if (saved) {
    user!.toReadList.add(book.bookId);
    final response = await supabase.from('toreadlist').upsert([
      {
        'profile_id': user!.id,
        'book_id': book.bookId,
      },
    ]);
  } else {
    if (user!.readingList.contains(book.bookId)) {
      user!.readingList.remove(book.bookId);
      final response = await supabase
          .from('readinglist')
          .delete()
          .eq('book_id', book.bookId)
          .eq('profile_id', user!.id);
    } else {
      user!.toReadList.remove(book.bookId);
      final response = await supabase
          .from('toreadlist')
          .delete()
          .eq('book_id', book.bookId)
          .eq('profile_id', user!.id);
    }
  }
}

void likeButton(Book book, bool isLiked) async {
  if (isLiked) {
    user!.favoriteBooks.add(book.bookId);
    book.likes++;
    final response = await supabase.from('book').update({
      'likes': book.likes,
    }).eq('book_id', book.bookId);
    await supabase.from('favoritebooks').upsert([
      {
        'profile_id': user!.id,
        'book_id': book.bookId,
      },
    ]);
  } else {
    user!.favoriteBooks.remove(book.bookId);
    book.likes--;
    final response = await supabase.from('book').update({
      'likes': book.likes,
    }).eq('book_id', book.bookId);
    await supabase
        .from('favoritebooks')
        .delete()
        .eq('book_id', book.bookId)
        .eq('profile_id', user!.id);
  }
}

Future<void> addComment(String comment, int id) async {
  await supabase.from('comment').upsert({
    'book_id': id,
    'user_id': user!.id,
    'content': comment,
  });
}

Future<List<Comment>> getComments(int id) async {
  List<Comment> comments = [];
  final com = await supabase.from('comment').select().eq('book_id', id);
  print(com);
  for (var row in com as List) {
    comments.add(Comment(content: row['content'], userId: row['user_id']));
  }
  return comments;
}

Future<void> addToReadingList(int id) async {
  if (user!.toReadList.contains(id)) {
    user!.toReadList.remove(id);
    final response = await supabase
        .from('toreadlist')
        .delete()
        .eq('book_id', id)
        .eq('profile_id', user!.id);
  }
  user!.readingList.add(id);
  final response = await supabase
      .from('readinglist')
      .upsert({'book_id': id, 'profile_id': user!.id});
}
