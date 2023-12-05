
import 'package:project/class/profileClass.dart';

class Message {
  String text;
  Profile sender;
  Profile reciever;
  bool seen;
  String time;
  Message(
      {required this.text,
      this.seen = false,
      required this.reciever,
      required this.sender,
      this.time = '10:45AM'});
}

List<Message> messages = [
  Message(text: 'Wow!', sender: authors[0], reciever: authors[1]),
  Message(text: 'Wow!', sender: authors[1], reciever: authors[0]),
  Message(text: 'Wow!', sender: authors[0], reciever: authors[1]),
  Message(text: 'Wow!', sender: authors[0], reciever: authors[0]),
];
