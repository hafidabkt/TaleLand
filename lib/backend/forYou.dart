import 'package:project/utils/constant.dart';

Future<void> ForYou(List<dynamic> selected, dynamic id) async {
  for (var value in selected) {
    try {
      final response = await supabase
          .from('foryou')
          .upsert({'profile_id': id, 'category_id': value});

      // Optionally log the response or handle it as needed
      print(response);
    } catch (error) {
      print('Error upserting record: $error');
      // Handle error as needed
    }
  }
}