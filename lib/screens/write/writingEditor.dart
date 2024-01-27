import 'package:flutter/material.dart';
import 'package:project/theme/color.dart';
import 'package:project/utils/class/bookClass.dart';
import 'package:project/backend/notif.dart';
import 'package:project/backend/editing.dart';

class WriteChapter extends StatefulWidget {
  final Part part;
  final int partid;
  const WriteChapter({required this.part, required this.partid});

  @override
  _WriteChapterState createState() => _WriteChapterState();
}

class _WriteChapterState extends State<WriteChapter> {
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contentController.text = widget.part.content;
    titleController.text = widget.part.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      bottomNavigationBar: const ChapterBottomBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                left: 25,
                right: 25,
                bottom: 0,
              ),
              child: Container(
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 23),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Content",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 206, 206, 206),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: myColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "   Write Chapter",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            setState(() {
              Navigator.pop(context);
            });
            widget.part.title = titleController.text;
            widget.part.content = contentController.text;
            int id = await publishChapter(widget.part, widget.partid);
            await sendNotification(id);
            Navigator.pop(context);
          },
          child: const Text(
            'Publish',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ChapterBottomBar extends StatelessWidget {
  const ChapterBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: myColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.text_format, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
