import 'package:flutter/material.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/src/bookCard.dart';

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
        title: Text('Filtered Books'),
      ),
      body: ListView.builder(
        itemCount: widget.filtered.length,
        itemBuilder: (context, index) {
          return BookCard(book: widget.filtered[index]);
        },
      ),
    );
  }
}
