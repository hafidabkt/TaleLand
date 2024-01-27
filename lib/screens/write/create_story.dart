import 'package:flutter/material.dart';
import 'package:project/backend/createStory.dart';
import 'package:project/utils/global.dart';
import 'package:project/theme/color.dart';
import 'package:project/utils/screens.dart';
import 'package:project/utils/class/categoryClass.dart';
import 'package:project/utils/class/bookClass.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({Key? key}) : super(key: key);

  @override
  _CreateStoryState createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  late Category selectedCategory;
  late int selectedCategoryId;
  bool isPublic = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCategory = categories[0];
    selectedCategoryId = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: myAccent,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Container(
                      width: 100.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          // Add logic here for handling the button click (e.g., opening a photo picker)
                          print('Button Clicked!');
                        },
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: myColor,
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Add a cover',
                    style: TextStyle(
                      color: myBrownColor,
                      fontSize: 23,
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      left: 25,
                      right: 25,
                      bottom: 20,
                    ),
                    child: Container(
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: '   Story Title ',
                          hintStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 25,
                      right: 25,
                      bottom: 20,
                    ),
                    child: Container(
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: '   Story Description ',
                          hintStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      left: 25,
                      right: 25,
                      bottom: 20,
                    ),
                    child: Container(
                      child: TextField(
                        controller: tagController,
                        decoration: InputDecoration(
                          hintText: '   Add Tags ',
                          hintStyle: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 25,
                          right: 25,
                          bottom: 20,
                        ),
                        child: DropdownButton<Category>(
                          value: selectedCategory,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                          underline: Container(
                            height: 2,
                            color: myColor,
                            width: 100,
                          ),
                          onChanged: (Category? newValue) {
                            if (newValue != null) {
                              // Update the selected category when the user selects a new value
                              setState(() {
                                selectedCategory = newValue;
                                selectedCategoryId =
                                    SelectedCategoryId(newValue);
                              });
                            }
                          },
                          items: categories.map<DropdownMenuItem<Category>>(
                            (Category value) {
                              return DropdownMenuItem<Category>(
                                value: value,
                                child: Text(value.name),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Public',
                                style: TextStyle(fontSize: 17),
                              ),
                              Switch(
                                activeColor: myAccent,
                                activeTrackColor: myColor,
                                inactiveThumbColor: Colors.black,
                                inactiveTrackColor: myBeige,
                                value: isPublic,
                                onChanged: (value) {
                                  setState(() {
                                    isPublic = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: myColor,
      iconTheme: IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              "Add Story Info",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                if (!titleController.text.isEmpty &&
                    !tagController.text.isEmpty &&
                    !descriptionController.text.isEmpty) {
                  Book temp = await createStory(
                    selectedCategoryId + 1,
                    titleController.text,
                    descriptionController.text,
                    tagController.text,
                    isPublic,
                  );
                  setState(() {
                    isPublic ? user!.published++ : null;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WriteChapter(
                          part: temp.parts[0],
                          partid: -1,
                        ),
                      ),
                    );
                    titleController.clear();
                    descriptionController.clear();
                    tagController.clear();
                  });
                }
              } catch (e) {
                print('Error creating story: $e');
                // Handle or log the error as needed
              }
            },
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int SelectedCategoryId(Category temp) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i] == temp) {
        return i;
      }
    }
    return -1;
  }
}
