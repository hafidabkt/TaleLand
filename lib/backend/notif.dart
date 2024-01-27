import 'package:project/utils/constant.dart';
import 'package:project/utils/global.dart';

Future<void> sendNotification(int part_id) async {
  final book = await supabase
      .from('part')
      .select('bookid')
      .eq('part_id', part_id)
      .single();
  print(book);
  int book_id = book['bookid'] as int;

  final titleResponse = await supabase
      .from('book')
      .select('title')
      .eq('book_id', book_id)
      .single();
  String bookTitle = titleResponse['title'] as String;
  await supabase.from('notif').upsert({
    'book_id': book_id,
    'title': 'Update, New Chapter Is Added',
    'content': bookTitle,
    'part_id': part_id
  });
  final notif = await supabase
      .from('notif')
      .select('notif_id')
      .eq('part_id', part_id)
      .eq('book_id', book_id)
      .single();
  int notif_id = notif['notif_id'] as int;
  final results = await supabase
      .from('readinglist')
      .select('profile_id')
      .eq('book_id', book_id);
  print('profile');
  print(results);
  for (var row in results as List) {
    final response = await supabase
        .from('notificated')
        .upsert({'notif_id': notif_id, 'user_id': row['profile_id']});
    print(response);
  }
}

Future<void> deleteNotif(int id) async {
  final response = await supabase
      .from('notificated')
      .delete()
      .eq('user_id', user!.id)
      .eq('notif_id', id);
  // Check the response or handle errors if necessary
  if (response.error != null) {
    // Handle error, for example, show a notification or log the error
    print('Error deleting notification: ${response.error!.message}');
  } else {
    // Notification deleted successfully
    print('Notification deleted successfully');
  }
}