import 'package:flutter/material.dart';
import 'package:project/utils/class/bookClass.dart';
import 'package:project/theme/color.dart';
import 'package:project/utils/global.dart';
import 'package:project/utils/constant.dart';
import 'package:project/backend/part.dart';
import 'package:project/backend/book.dart';

class Comment {
  String content;
  int userId;

  Comment({
    required this.content,
    required this.userId,
  });
}

class readerScreen extends StatefulWidget {
  final Book book;
  readerScreen({required this.book});
  @override
  _readerScreen createState() => _readerScreen();
}

class _readerScreen extends State<readerScreen> {
  bool isDarkMode = false;
  late Future<int> pageIndex;
  @override
  void initState() {
    super.initState();
    pageIndex = getPageIndex(widget.book.bookId);
    if (user!.toReadList.contains(widget.book.bookId)) {
      addToReadingList(widget.book.bookId);
    }
  }

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
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb,
                color: !user!.recommendationList.contains(widget.book.bookId)
                    ? Colors.white
                    : myAccent),
            onPressed: () async {
              if (!user!.recommendationList.contains(widget.book.bookId)) {
                await supabase.from('recommendationlist').upsert(
                    {'book_id': widget.book.bookId, 'profile_id': user!.id});
                user!.recommendationList.add(widget.book.bookId);
              } else {
                await supabase
                    .from('recommendationlist')
                    .delete()
                    .eq('profile_id', user!.id)
                    .eq('book_id', widget.book.bookId);
                user!.recommendationList.remove(widget.book.bookId);
              }
              setState(() {});
            },
            tooltip: 'Recommend',
          ),
        ],
      ),
      body: FutureBuilder<int>(
        future: pageIndex,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return readerScreenhelper(
              book: widget.book,
              isDarkMode: isDarkMode,
              partIndex: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            // Handle error case
            return Text('Error: ${snapshot.error}');
          } else {
            // Future is still loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

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
  List<Comment> comments = [];
  @override
  void initState() {
    super.initState();
    saved = isSaved(widget.book.bookId);
    isLiked = isliked(widget.book.bookId);
    fetchData();
  }

  void fetchData() async {
    // Assuming getComments returns a List<Comment>
    List<Comment> fetchedComments = await getComments(widget.book.bookId);

    setState(() {
      comments = fetchedComments;
    });
  }

  bool isBottomBarVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _commentController = TextEditingController();

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
                          title: Text(comment.content),
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
                        Navigator.pop(context);
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
                      onPressed: () async {
                        String comment = _commentController.text;
                        if (comment.isNotEmpty) {
                          setState(() {
                            comments.add(
                                Comment(content: comment, userId: user!.id));
                            _commentController.clear();
                            addComment(comment, widget.book.bookId);
                          });
                        }
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
                  tooltip: 'Mode',
                ),
                IconButton(
                  icon: Icon(
                    saved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      saved = !saved;
                    });
                    if (saved) {
                      addToReadingList(widget.book.bookId);
                    } else {
                      supabase
                          .from('readinglist')
                          .delete()
                          .eq('profile_id', user!.id)
                          .eq('book_id', widget.book.bookId);
                      user!.readingList.remove(widget.book.bookId);
                    }
                  },
                  tooltip: 'Saving',
                ),
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.star : Icons.star_border,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    likeButton(widget.book, isLiked);
                  },
                  tooltip: 'Like',
                ),
                IconButton(
                  icon: Icon(
                    Icons.text_format,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showFontSizeDialog(); // Show font size adjustment dialog
                  },
                  tooltip: 'Arange Size',
                ),
                IconButton(
                  icon: Icon(
                    Icons.mode_comment,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showCommentsPopup(); // Handle comment action
                  },
                  tooltip: 'Comment',
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                  },
                  tooltip: 'Parts',
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
                onTap: () async {
                  await supabase
                      .from('readinglist')
                      .update({'part_index': index})
                      .eq('profile_id', user!.id)
                      .eq('book_id', book.bookId);
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
