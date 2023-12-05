import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/src/readingEditor.dart';
import 'package:project/src/authorProfile.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreen createState() => _BookDetailsScreen();
}

class _BookDetailsScreen extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Image.asset(
                        widget.book.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.book.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(widget.book.author.imageUrl),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    child: Text(
                      '${widget.book.author.name}',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorProfileDetailsScreen(author: widget.book.author),
                        ),
                      );
                    },
                  ),
                ]),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(
                  bottom: 18,
                  left: 50,
                  right: 50,
                  top: 18,
                ),
                child: Row(
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
                        Icon(Icons.favorite, color: myAccent),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => readerScreen(book: widget.book),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: myAccent, // Background color
                      onPrimary: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the border radius as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        'Read',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle, size: 40, color: myAccent)),
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
                ],
              ),
              SizedBox(height: 8),
              Divider(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      widget.book.description,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
