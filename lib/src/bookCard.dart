import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/color.dart';

class BookCard extends StatefulWidget {
  final Book book;

  BookCard({required this.book});

  @override
  _BookCardState createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
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
                        'Author: ${widget.book.author}',
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
                  Row(children: [
                    Icon(Icons.visibility,color:myAccent),
                    SizedBox(
                        width: 8,
                      ),
                    Text('${widget.book.views}'),
                  ],),
                  Row(
                    children: [
                      IconButton(
                                icon: Icon(
                                  widget.book.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.book.isLiked ? myAccent : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    widget.book.isLiked = !widget.book.isLiked;
                                    if (widget.book.isLiked) {
                                      widget.book.likes++;
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
                      Icon(Icons.mode_comment,color:myAccent),
                      SizedBox(
                        width: 8,
                      ),
                      Text('${widget.book.comments}')
                    ],
                  ),
                        ],
                  ),
                  SizedBox(height: 12,),
                  Text(
                    widget.book.description,
                    style: TextStyle(fontSize: 16,color: myBrownColor),
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
                  widget.book.saved = !widget.book.saved;
                });
              },
              icon: Icon(Icons.bookmarks),
              color: widget.book.saved ? myAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
