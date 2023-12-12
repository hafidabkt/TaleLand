import 'package:flutter/material.dart';
import 'package:project/class/profileClass.dart';
import 'package:project/src/intrest.dart';
import 'package:project/components/components.dart';
import 'package:project/components/under_part.dart';
import 'package:project/src/screens.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/src/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/main.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String gender = '';

    Future<void> signup() async {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': nameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'gender': gender,
        }),
      );

      if (response.statusCode == 201) {
        print('Signup successful');
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> me = responseData['user'];
        user = Profile(
          email: me['email'],
          name: me['name'],
          imageUrl: 'assets/profile01.png',
          gender: me['gender'],
          publishedBooks: [],
          notPublishedBooks: [],
          favoriteBooks: [],
          forYou: [],
          blockedList: [],
          followeesList: [],
          followersList: [],
          toReadList: [],
          readingList: [],
          recommendationList: [],
        );
        authors.add(user);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IntrestScreen(),
          ),
        );
      } else {
        print('Signup failed: ${response.body}');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                const Upside(
                  imgUrl: "assets/register.png",
                ),
                const PageTitleBar(title: 'Create New Account '),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        iconButton(context),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "or use your email account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 78, 78, 78),
                            fontFamily: 'OpenSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          width: 0.8 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: myPinkColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: "Gender",
                              border: InputBorder.none,
                            ),
                            items: ['Male', 'Female']
                                .map((gender) => DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value == 'Female') {
                                gender = 'F';
                              } else {
                                gender = 'M';
                              }
                            },
                            isExpanded: true,
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: myBlueColor,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                    fontFamily: 'OpenSans', color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            controller: nameController,
                            cursorColor: myBlueColor,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "Name",
                                hintStyle: const TextStyle(
                                    fontFamily: 'OpenSans', color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                        TextFieldContainer(
                          child: TextFormField(
                            obscureText: true,
                            cursorColor: myPinkColor,
                            controller: passwordController,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontFamily: 'OpenSans', color: Colors.grey),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: myPinkColor,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        RoundedButton(
                          text: 'SIGN UP',
                          press: signup,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        UnderPart(
                          title: "Already have an account?",
                          navigatorText: "Login here",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
