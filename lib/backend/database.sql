CREATE TABLE profiles (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  gender CHAR(1) DEFAULT 'F',
  name VARCHAR(255) NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  bio TEXT,
  followers VARCHAR(255) DEFAULT '0',
  views VARCHAR(255) DEFAULT '0',
  published INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE profiles
ADD COLUMN supabase_user_id UUID;
-- Supabase AI is experimental and may produce incorrect answers
-- Always verify the output before executing

create extension if not exists "uuid-ossp";

create table
  Part (
    part_id bigint primary key generated always as identity,
    title text not null,
    content text
  );

create table
  Book (
    book_id bigint primary key generated always as identity,
    category int not null,
    title text not null,
    image text not null,
    description text not null,
    author_id int references profiles (id) not null,
    likes int default 0,
    rating int default 0,
    views int default 0,
    comments int default 0,
    is_published boolean default false,
    tags text
  );

create table
  BookPart (
    book_id int references Book (book_id) not null,
    part_id int references Part (part_id) not null,
    primary key (book_id, part_id)
  );

  create table
  favoriteBooks (
    book_id int references Book (book_id) not null,
    profile_id int references profiles (id) not null,
    primary key (book_id, profile_id)
  );

  create table
  readingList (
    book_id int references Book (book_id) not null,
    profile_id int references profiles (id) not null,
    primary key (book_id, profile_id)
  );

  create table
  toreadlist (
    book_id int references Book (book_id) not null,
    profile_id int references profiles (id) not null,
    primary key (book_id, profile_id)
  );

  create table
  recommendationlist(
    book_id int references Book (book_id) not null,
    profile_id int references profiles (id) not null,
    primary key (book_id, profile_id)
  );

  create table
  followings(
    follower_id int references profiles (id) not null,
    followee_id int references profiles (id) not null,
    primary key (follower_id, followee_id)
  );

  create table
  blockedList(
    blocker_id int references profiles (id) not null,
    blocked_profile_id int references profiles (id) not null,
    primary key (blocker_id, blocked_profile_id)
  );

  -- Create the Category table
  CREATE TABLE Category (
  category_id SERIAL PRIMARY KEY,
  nameCategory VARCHAR(255) NOT NULL,
  imageUrl VARCHAR(255) NOT NULL
  );

  create table ForYou(
    profile_id int references profiles (id) not null,
    category_id int references Category (category_id) not null,
    primary key (profile_id,category_id),
  );

  create table PopulareProfiles(
    profile_id int references profiles (id) not null
  );
  
  create table BookoftheMonth(
    book_id int references Book(book_id) not null,
    month VARCHAR(255) NOT NULL
  );

-- insert into the table profiles:
INSERT INTO profiles (email, password_hash,name, image_url)
VALUES (
  'janemarie@email.com',
  'hashed_password_here', 
  'Jane Marie',
  'assets/profile01.png'
);
INSERT INTO profiles (email, password_hash,name, image_url)
VALUES (
  'stefclark@email.com',
  'hashed_password_here', 
  'Stef Clarck',
  'assets/profile02.png'
);
INSERT INTO profiles (email, password_hash,name, image_url)
VALUES (
  'lorafoll@email.com',
  'hashed_password_here', 
  'Lora Foll',
  'assets/profile03.png'
);
INSERT INTO profiles (email, password_hash,name, image_url)
VALUES (
  'jamesarthur@email.com',
  'hashed_password_here', 
  'James Arthur',
  'assets/profile04.png'
);
-- the insert into the category table
INSERT INTO Category (nameCategory, imageurl)
VALUES ('Adventure', 'assets/Adventure.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Fantasy', 'assets/Fantasy.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Horror', 'assets/Horror.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Fanfiction', 'assets/Fanfiction.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Historical', 'assets/Historical.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Mystery', 'assets/Mystery.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Romance', 'assets/Romance.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Short', 'assets/Short.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Science Fiction', 'assets/Science_fiction.png');

INSERT INTO Category (nameCategory, imageurl)
VALUES ('Musical', 'assets/Musical.png');

-- insert into book table
INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  1,
  'This is not a Ghost story',
  'assets/book2.png',
  'I never thought the my childhood ghost was real and never a real ghost',
  1, 
  50,
  4,
  1000,
  25,
  true,
  'Adventure, Fiction'
);

-- Assuming the categories and profiles tables are already populated with data
INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  6,
  'Lost',
  'assets/book3.png',
  'hi',
  3,
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  7,
  'AbraCadabra',
  'assets/book4.png',
  'hi',
  2,
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  0,
  'Skelaton man',
  'assets/book7.png',
  'hi',
  3,
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  0,
  'Ekko',
  'assets/book8.png',
  'hi',
  3, 
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  0,
  'Love JacaRanda',
  'assets/book9.png',
  'hi',
  2,
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  5,
  'Remarkables',
  'assets/book10.png',
  'hi',
  3,
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  6,
  'Scavangers',
  'assets/book5.png',
  'hi',
  4, 
  0,
  0,
  0,
  0,
  false,
  NULL
);

INSERT INTO Book (category, title, image, description, author_id, likes, rating, views, comments, is_published, tags)
VALUES (
  3,
  'Alone',
  'assets/book6.png',
  'hi',
  1, 
  0,
  0,
  0,
  0,
  false,
  NULL
);

-- insert parts

INSERT into part(title,content)
VALUES(
  'I do not understand',
  '''
  Once upon a time in the heart of a mystical forest, a peculiar mask went missing. The mask, a whimsical creation resembling a mischievous cat`s face, had long been a symbol of enchantment and mystery. It was said that whoever possessed the mask would be granted the ability to traverse between the seen and the unseen.

  The mask was the creation of an ancient sorcerer who had long since disappeared, leaving behind only whispers of his magical legacy. Legends spoke of the mask`s uncanny ability to reveal hidden realms and secret passages, and those who sought its powers were often drawn to the depths of the forest.

  One day, a young adventurer named Lila stumbled upon an old map that hinted at the mask`s location. Driven by curiosity and a longing for adventure, Lila embarked on a journey through the dense woods. The forest, however, was not as welcoming as it seemed, and soon Lila found herself lost among the towering trees and winding paths.

  As night fell, the air became thick with enchantment, and strange sounds echoed through the darkness. Lila, determined to find the mask, pressed on, guided only by the mysterious glow of fireflies. Unbeknownst to her, the forest seemed to have a mischievous spirit of its own, playing tricks on her senses and leading her in circles.

  Suddenly, in the moonlit clearing, Lila spotted a figure wearing the very cat mask she sought. A hand, adorned with ancient markings, reached out and grabbed the mask, disappearing into the shadows. With a mixture of excitement and trepidation, Lila chased after the elusive figure, each step taking her deeper into the heart of the mystical forest.

  The journey led Lila through ethereal landscapes, where talking animals shared ancient tales, and magical doorways opened to realms beyond imagination. As she pursued the masked figure, Lila discovered the true nature of the forest – a realm where lost dreams and forgotten memories intertwined, creating a tapestry of wonder and mystery.

  In the end, the mask was not merely a physical object but a key to unlocking the secrets hidden within oneself. Lila realized that the forest had a way of revealing what was lost, not in the tangible sense, but in the deepest recesses of the heart. As the first light of dawn broke through the canopy, Lila emerged from the forest, forever changed by the enchanting adventure and the wisdom gained in the search for the lost cat mask.
  '''
);

INSERT INTO BookPart(book_id, part_id)
VALUES(
  1,
  1
);
ALTER TABLE Part
ADD COLUMN bookid INT;
