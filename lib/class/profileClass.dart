class Profile {
  final String name;
  final String imageUrl;
  String bio;
  String followers;
  String views;
  int bookList;
  int published;
  Profile({
    required this.name,
    required this.imageUrl,
    this.bio = '',
    this.followers = '224K',
    this.views = '1.2M',
    this.bookList = 16,
    this.published = 7,
  });
}

List<Profile> authors = [
  Profile(name: 'Jane Marie', imageUrl: 'assets/profile01.png',bio:'Hello i am a writer and this is my profile , i hope you like it, nice to meet you all ^^'),
  Profile(name: 'Briana March', imageUrl: 'assets/profile02.png',bio:'Welcome to my craetive weirdos this is your space to get out of your skin into the world of Science fiction'),
  Profile(name: 'Lucie Clarck', imageUrl: 'assets/profile03.png'),
  Profile(name: 'James Arthur', imageUrl: 'assets/profile04.png'),
  // Add more authors as needed
];
