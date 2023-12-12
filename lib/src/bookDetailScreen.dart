import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/color.dart';
import 'package:project/src/homePage.dart';
import 'package:project/src/readingEditor.dart';
import 'package:project/src/authorProfile.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreen createState() => _BookDetailsScreen();
}

class _BookDetailsScreen extends State<BookDetailsScreen> {
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
                          builder: (context) => AuthorProfileDetailsScreen(
                              author: widget.book.author),
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
                      onPressed: () {
                        setState(() {
                          saved = !saved;
                          if (saved) {
                            user.toReadList.add(widget.book.bookId);
                          } else {
                            user.toReadList.remove(widget.book.bookId);
                          }
                        });
                      },
                      icon: !saved
                          ? Icon(Icons.add_circle, size: 40, color: myAccent)
                          : Icon(Icons.remove_circle,
                              size: 40, color: myAccent)),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
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
                        print(user.favoriteBooks);
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
