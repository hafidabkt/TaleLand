import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/color.dart';
import 'package:project/src/homePage.dart';

class BookCard extends StatefulWidget {
  final Book book;

  BookCard({required this.book});

  @override
  _BookCardState createState() => _BookCardState();
}
class _BookCardState extends State<BookCard> {
  late bool saved; // Declare as late to initialize it in initState
  late bool isLiked;
  @override
  void initState() {
    super.initState();
    saved = isSaved(widget.book.bookId); // Initialize saved in initState
    isLiked = isliked(widget.book.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: myBeige,
      margin: EdgeInsets.only(bottom: 12, left: 25, top: 12, right: 20),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: Image.asset(
                  widget.book.image,
                  width: 150,
                  height: 230,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        widget.book.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Author: ${widget.book.author.name}',
                        style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 48, 17, 17)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.book.description,
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.visibility, color: myAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text('${widget.book.views}'),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isLiked ? myAccent : null,
                            ),
                            onPressed: () {
                              setState(() {
                                isLiked = !isLiked;
                                if (isLiked) {
                                  user.favoriteBooks.add(widget.book.bookId);
                                } else {
                                  user.favoriteBooks.remove(widget.book.bookId);
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('${widget.book.likes}'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.mode_comment, color: myAccent),
                          SizedBox(
                            width: 8,
                          ),
                          Text('${widget.book.comments}')
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.book.description,
                    style: TextStyle(fontSize: 16, color: myBrownColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  saved = !saved;
                  if (saved) {
                    user.toReadList.add(widget.book.bookId);
                  } else {
                    user.toReadList.remove(widget.book.bookId);
                  }
                  print(user.toReadList);
                });
              },
              icon: Icon(Icons.bookmarks),
              color: saved ? myAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

bool isSaved(int id) {
  if (user.readingList.contains(id) || user.toReadList.contains(id)) {
    return true;
  }
  return false;
}
bool isliked(int id) {
  if (user.favoriteBooks.contains(id)) {
    return true;
  }
  return false;
}