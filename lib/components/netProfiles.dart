import 'package:project/class/profileClass.dart';
import 'package:project/main.dart';

List<Profile> netProfiles() {
  List<Profile> temp = [];
  for (int i = 0; i < authors.length; i++) {
    if (!user.blockedList.contains(authors[i].id)) {
      temp.add(authors[i]);
    }
  }
  return temp;
}

