import 'package:project/utils/constant.dart';
import 'package:project/utils/global.dart';

Future<int> getPageIndex(int id) async {
  if (user!.readingList.contains(id)) {
    final response = await supabase
        .from('readinglist')
        .select('part_index')
        .eq('book_id', id)
        .eq('profile_id', user!.id)
        .single();
    if (response == null) {
      return 0;
    }
    int index = response['part_index'] as int;
    return index;
  } else {
    return 0;
  }
}

Future<int> getPartid(String title, int bookid) async {
  final id = await supabase
      .from('part')
      .select('part_id')
      .eq('title', title)
      .eq('bookid', bookid)
      .single();
  int partid = id['part_id'] as int;
  return partid;
}
