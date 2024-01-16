import 'package:flutter/material.dart';
import 'package:project/src/bookDetailScreen.dart';
import 'package:project/src/authorProfile.dart';
import 'package:project/class/bookClass.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/color.dart';
import 'package:project/src/bookCard.dart';
import 'package:project/backend/backend.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> forYouBooks;

  @override
  void initState() {
    super.initState();
    forYouBooks = getForYou();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              'Book of the month',
              bookOftheMonth.map((book) => BookCard(book: book)).toList(),
            ),
            _buildSection(
              'Popular authors',
              popular
                  .map((author) => AuthorProfileCard(author: author))
                  .toList(),
            ),
            FutureBuilder<List<Book>>(
              future: forYouBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 'For you' section
                  return _buildSection(
                    'For you',
                    snapshot.data!
                        .map(
                          (book) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailsScreen(book: book),
                                ),
                              );
                            },
                            child: Container(
                              child: BookCard(book: book),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      margin: EdgeInsets.only(bottom: 0, left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            height: 300,
            margin: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index];
              },
            ),
          ),
        ],
      ),
    );
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
            SizedBox(height: 16),
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
                borderRadius: BorderRadius.circular(10),
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
