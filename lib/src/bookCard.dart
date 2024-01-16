import 'package:flutter/material.dart';
import 'package:project/backend/backend.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/global.dart';

class BookCard extends StatefulWidget {
  final Book book;

  BookCard({required this.book});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  late bool saved;
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    saved = isSaved(widget.book.bookId);
    isLiked = isliked(widget.book.bookId);
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width - 40; // Adjust padding as needed

    return Card(
      elevation: 0,
      color: myBeige,
      margin: EdgeInsets.only(bottom: 12, left: 20, top: 12, right: 20),
      child: Container(
        width: cardWidth,
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
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        '''${widget.book.title}''',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Author: ${widget.book.author.name}',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 48, 17, 17),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '''${widget.book.description}''',
                        style: TextStyle(fontSize: 16),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () async {
                  setState(() {
                    saved = !saved;
                  });
                  saveButton(widget.book, saved);
                },
                icon: Icon(Icons.bookmarks),
                color: saved ? myAccent : Colors.grey,
              ),
            ),
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
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? myAccent : null,
                      ),
                      onPressed: () async {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        likeButton(widget.book, isLiked);
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
          ],
        ),
      ),
    );
  }
}

bool isSaved(int id) {
  if (user!.readingList.contains(id) || user!.toReadList.contains(id)) {
    return true;
  }
  return false;
}

bool isliked(int id) {
  if (user!.favoriteBooks.contains(id)) {
    return true;
  }
  return false;
}
