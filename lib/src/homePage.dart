import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project/src/bookDetailScreen.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/src/bookCard.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 0, left: 20, top: 50, right: 20),
            child: Text(
              'Book of the month',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailsScreen(book: books[index]),
                      ),
                    );
                  },
                  child: Container(
                    child: BookCard(book: books[index]),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0, left: 20, top: 20, right: 20),
            child: Text(
              'Popular authors',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // Popular Writers
          Container(
            height: 201,
            width: 150,
            margin: EdgeInsets.only(bottom: 12, left: 25, top: 12, right: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: authors.length,
              itemBuilder: (context, index) {
                return AuthorProfileCard(author: authors[index]);
              },
            ),
          ),
          // For You
          Container(
            margin: EdgeInsets.only(bottom: 0, left: 20, top: 20, right: 20),
            child: Text(
              'For you',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailsScreen(book: books[index]),
                      ),
                    );
                  },
                  child: Container(
                    child: BookCard(book: books[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class AuthorProfileCard extends StatelessWidget {
  final Profile author;

  AuthorProfileCard({required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthorProfileDetailsScreen(author: author),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        height: 200,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: myBrownColor,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              author.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12, left: 25, top: 12, right: 20),
              width: 90,
              height: 120,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), // Set the desired radius
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(author.imageUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
