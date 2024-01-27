class Category {
  int? id;
  final String name;
  final String imageUrl;

  Category({this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}

List<Category> categories = [
  Category(name: 'Adventure', imageUrl: 'assets/Adventure.png'),
  Category(name: 'Fantasy', imageUrl: 'assets/Fantasy.png'),
  Category(name: 'Horror', imageUrl: 'assets/Horror.png'),
  Category(name: 'Fanfiction', imageUrl: 'assets/Fanfiction.png'),
  Category(name: 'Historical', imageUrl: 'assets/Historical.png'),
  Category(name: 'Mystery', imageUrl: 'assets/Mystery.png'),
  Category(name: 'Romance', imageUrl: 'assets/Romance.png'),
  Category(name: 'Short', imageUrl: 'assets/Short.png'),
  Category(name: 'Science Fiction', imageUrl: 'assets/Science_fiction.png'),
  Category(name: 'Musical', imageUrl: 'assets/Musical.png'),
];
