import 'package:flutter/material.dart';
import 'package:project/src/color.dart';
import 'package:project/src/bookCard.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/editStory.dart';
import 'package:project/components/netBooks.dart';

class edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Story', style: TextStyle(color: Colors.white)),
        backgroundColor: myColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListOfPublished(),
    );
  }
}

class ListOfPublished extends StatefulWidget {
  @override
  _ListOfPublished createState() => _ListOfPublished();
}

class _ListOfPublished extends State<ListOfPublished> {
  List<Book> booksPublished = BooksPublished();
  List<Book> notPublished = BooksNotPublished();
  String selectedOption = 'Published';
  void selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: myAccent,
            border: Border.all(color: myAccent),
          ),
          child: Row(
            children: <Widget>[
              buildTab('Published'),
              buildTab('Not Published'),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: selectedOption == 'Published'
                ? booksPublished.length
                : notPublished.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => selectedOption == 'Published'
                            ? EditStory(
                                book: booksPublished[index],
                              )
                            : EditStory(
                                book: notPublished[index],
                              )),
                  );
                },
                child: Container(
                    child: selectedOption == 'Published'
                        ? BookCard(book: booksPublished[index])
                        : BookCard(book: notPublished[index])),
              );
            },
          ),
        ),
      ],
    );
  }

  Expanded buildTab(String option) {
    return Expanded(
      child: InkWell(
        onTap: () {
          selectOption(option);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              option,
              style: TextStyle(
                fontSize: 16.0,
                color: selectedOption == option ? Colors.black : Colors.black,
              ),
            ),
            if (selectedOption == option)
              Container(
                height: 2.0,
                width: 130,
                color: myColor,
              ),
          ],
        ),
      ),
    );
  }
}
