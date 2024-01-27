import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/utils/class/bookClass.dart';
import 'package:project/screens/book/bookCard.dart';
import 'package:project/theme/color.dart';
import 'package:project/screens/book/bookDetailScreen.dart';

class FilteredBooksScreen extends StatefulWidget {
  final List<Book> filtered;
  const FilteredBooksScreen({required this.filtered});
  @override
  _FilteredBooksScreenState createState() => _FilteredBooksScreenState();
}

class _FilteredBooksScreenState extends State<FilteredBooksScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtered Books', style: TextStyle(color: Colors.white)),
        backgroundColor: myAccent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: widget.filtered.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/not_found.svg', height: 150, width: 150),
                ],
              ),
            )
          : ListView.builder(
              itemCount: widget.filtered.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: BookCard(book: widget.filtered[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(
                          book: widget.filtered[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
