import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/color.dart';
import 'package:project/main.dart';

class readerScreen extends StatefulWidget {
  final Book book;
  readerScreen({required this.book});
  @override
  _readerScreen createState() => _readerScreen();
}

class _readerScreen extends State<readerScreen> {
  bool isDarkMode = false;
  int pageIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.book.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: myColor,
      ),
      body: readerScreenhelper(
        book: widget.book,
        isDarkMode: isDarkMode,
        partIndex: pageIndex,
      ),
    );
  }
}

// ignore: must_be_immutable
class readerScreenhelper extends StatefulWidget {
  final Book book;
  bool isDarkMode;
  final int partIndex;
  readerScreenhelper(
      {required this.book, required this.partIndex, required this.isDarkMode});

  @override
  _readerScreenhelper createState() => _readerScreenhelper();
}

class _readerScreenhelper extends State<readerScreenhelper> {
  late bool saved; // Declare as late to initialize it in initState
  late bool isLiked;
  @override
  void initState() {
    super.initState();
    saved = isSaved(widget.book.bookId); // Initialize saved in initState
    isLiked = isliked(widget.book.bookId);
    addToReadingList(widget.book.bookId);
  }

  bool isBottomBarVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _commentController = TextEditingController();
  List<String> comments = ['perfect timing for the drop of this chapter'];

  double _fontSize = 16.0; // Default font size

  void _showCommentsPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      ...comments.map(
                        (comment) => ListTile(
                          title: Text(comment),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size.fromWidth(180),
                        ),
                      ),
                      child: Text("Close"),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(myAccent),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size.fromWidth(180),
                        ),
                      ),
                      onPressed: () {
                        String comment = _commentController.text;
                        if (comment.isNotEmpty) {
                          setState(() {
                            comments.add(comment);
                            _commentController.clear();
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: widget.isDarkMode ? Brightness.dark : Brightness.light,
        fontFamily: 'Jost',
      ),
      home: Scaffold(
        key: _scaffoldKey,
        body: GestureDetector(
          onTap: () {
            setState(() {
              isBottomBarVisible = !isBottomBarVisible;
            });
          },
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.book.image,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.book.parts[widget.partIndex].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        widget.book.parts[widget.partIndex].content,
                        style: TextStyle(fontSize: _fontSize),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isBottomBarVisible ? kToolbarHeight : 0,
          child: Container(
            color: widget.isDarkMode ? myAccent : myColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isDarkMode = !widget.isDarkMode;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    saved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      saved = !saved;
                      if (saved) {
                        user.readingList.add(widget.book.bookId);
                      } else {
                        user.readingList.remove(widget.book.bookId);
                      }
                      print(user.readingList);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.star : Icons.star_border,
                    color: Colors.white,
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
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle share action
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.text_format,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showFontSizeDialog(); // Show font size adjustment dialog
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.mode_comment,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showCommentsPopup(); // Handle comment action
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: MyDrawer(
            book: widget.book,
            isDarkMode: widget.isDarkMode,
            num: widget.partIndex),
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adjust Font Size"),
          content: Column(
            children: [
              Text("Slide to adjust font size"),
              Slider(
                value: _fontSize,
                onChanged: (value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
                min: 10.0,
                max: 30.0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

class MyDrawer extends StatelessWidget {
  final Book book;
  final bool isDarkMode;
  final int num;

  MyDrawer({required this.book, required this.isDarkMode, required this.num});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode ? myAccent : myColor,
            ),
            child: Center(
              child: Text(
                '${book.title}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: book.parts.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(book.parts[index].title),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => readerScreenhelper(
                          book: book, partIndex: index, isDarkMode: isDarkMode),
                    ),
                  );
                },
              );
            },
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

void addToReadingList(int id) {
  if (user.toReadList.contains(id)) {
    user.toReadList.remove(id);
  }
  if(!user.readingList.contains(id)){
    user.readingList.add(id);
  } 
}
