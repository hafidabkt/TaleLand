import 'package:project/utils/class/bookClass.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/screens/book/readingEditor.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/getProfile.dart';
import 'package:project/utils/global.dart';

Future<int> publishChapter(Part part, int partid) async {
  if (partid == -1) {
    await supabase.from('part').upsert([
      {
        'title': part.title,
        'content': part.content,
        'bookid': part.bookid,
      }
    ]);
  } else {
    await supabase.from('part').update({
      'title': part.title,
      'content': part.content,
      'bookid': part.bookid,
    }).eq('part_id', partid);
  }

  final part_id = await supabase
      .from('part')
      .select('part_id')
      .eq('title', part.title)
      .eq('bookid', part.bookid)
      .single();

  int id = part_id['part_id'] as int;
  return id;
}

