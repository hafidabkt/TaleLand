import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/screens.dart';
import 'package:project/class/bookClass.dart';

class EditStory extends StatefulWidget {
  final Book book;
  const EditStory({required this.book});

  @override
  _EditStoryState createState() => _EditStoryState();
}

class _EditStoryState extends State<EditStory> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.book.title;
    descriptionController.text = widget.book.description;
    tagsController.text = widget.book.tags;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: myAccent,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Container(
                      width: 100.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage(widget.book.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Add logic here for handling the button click (e.g., opening a photo picker)
                          print('Button Clicked!');
                        },
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 238, 211,
                                243), // You can change the icon color as needed
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Edit Story Cover ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 167, 166, 166),
                        fontSize: 23),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Story title',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: TextField(
                  controller: titleController,
                  maxLines: null, // Allows the user to input multiple lines
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: titleController.text,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none, // Removes the underline
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Story Description',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: TextField(
                  controller: descriptionController,
                  maxLines: null, // Allows the user to input multiple lines
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: descriptionController.text,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none, // Removes the underline
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tags',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: TextField(
                  controller: tagsController,
                  maxLines: null, // Allows the user to input multiple lines
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: tagsController.text,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none, // Removes the underline
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextButton(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    STORY CHAPTERS',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChaptersList(book: widget.book)));
                },
              ),
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                color: myColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              width: 400,
              decoration: BoxDecoration(
                color: myColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: myColor, // You can change the color as needed
                      ),
                      child: InkWell(
                        onTap: () {
                          Part temp = Part(title: '', content: '',bookid:widget.book.bookId);
                          widget.book.parts.add(temp);
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WriteChapter(
                                        part: widget.book.parts.last,
                                      )));
                        },
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Add new Part ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: myColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
            child: Text(
          "Edit ${widget.book.title}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        )),
        TextButton(
            onPressed: () async {
              await _save();
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ))
      ]),
    );
  }

  Future<void> _save() async {
    setState(() {
      widget.book.title = titleController.text;
      widget.book.description = descriptionController.text;
      widget.book.tags = tagsController.text;
      Navigator.pop(context);
    });
  }
}
