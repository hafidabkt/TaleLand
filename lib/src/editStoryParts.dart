import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/writingEditor.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/backend/backend.dart';

class ChaptersList extends StatelessWidget {
  final Book book;
  const ChaptersList({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5, right: 15, left: 15),
            child: Text(
              'Story Chapters: ',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: book.parts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    int partid = await getPartid(
                        book.parts[index].title, book.parts[index].bookid);
                    print(partid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteChapter(
                            part: book.parts[index], partid: partid),
                      ),
                    );
                  },
                  child: ChapterTile(part: book.parts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: myColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "   Edit ${book.title} Parts",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ]),
    );
  }
}

class ChapterTile extends StatelessWidget {
  final Part part;
  ChapterTile({required this.part});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Padding(
            padding: EdgeInsets.only(left: 20), child: Text(part.title)),
        contentPadding: EdgeInsets.all(0),
        tileColor: myAccent,
      ),
    );
  }
}
