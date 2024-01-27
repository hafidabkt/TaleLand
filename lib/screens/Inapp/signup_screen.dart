import 'package:flutter/material.dart';
import 'package:project/utils/class/profileClass.dart';
import 'package:project/screens/Inapp/intrest.dart';
import 'package:project/components/components.dart';
import 'package:project/components/under_part.dart';
import 'package:project/utils/screens.dart';
import 'package:project/utils/constant.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/theme/color.dart';
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:project/utils/global.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _signUpLoading = false;
  final _formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String gender = '';

  Future<Object?> saveUserDataToDatabase(
    String email, String password, String name, String gender,
  ) async {
    try {
      final response = await supabase.from('profiles').upsert([
        {
          'email': email,
          'password': password,
          'name': name,
          'gender': gender,
        },
      ]);
      print(response);
      if (response == null) {
        print('User data saved to the database!');
        final me = await supabase
            .from('profiles')
            .select()
            .eq('email', email)
            .eq('name', name)
            .eq('gender', gender)
            .single();
        user = Profile(
          email: me['email'],
          name: me['name'],
          imageUrl: 'assets/profile.png',
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
          id: me['id'],
        );
        print(user!.id);
      } else {
        print('Failed to save user data: ${response.error!.message}');
        return response.error!.message;
      }
    } catch (error) {
      print('Error during database operation: $error');
      return error;
    }
  }

  Future<void> signUp(
    String name, String email, String password, String gender,
  ) async {
    try {
      // Validate the form
      final isValidate = _formkey.currentState?.validate();
      if (isValidate != true) {
        return;
      }

      // Perform sign-up
      final signUpResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      if (signUpResponse.user != null) {
        // Save user data to the database
        final saveResponse = await saveUserDataToDatabase(
          email,
          password,
          name,
          gender,
        );

        if (saveResponse == null) {
          // Move to the next screen if sign-up and data save are successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => IntrestScreen(),
            ),
          );
        }
      }
    } catch (error) {
      print('Error during sign up: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Form(
        key: _formkey,
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
                                setState(() {
                                  if (value == 'Female') {
                                    gender = 'F';
                                  } else {
                                    gender = 'M';
                                  }
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              controller: emailController,
                              cursorColor: myBlueColor,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Add additional email validation if needed
                                return null;
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextFormField(
                              controller: nameController,
                              cursorColor: myBlueColor,
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: "Name",
                                hintStyle: const TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                // Add additional name validation if needed
                                return null;
                              },
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
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey,
                                ),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: myPinkColor,
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                // Add additional password validation if needed
                                return null;
                              },
                            ),
                          ),
                          _signUpLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RoundedButton(
                                  text: 'SIGN UP',
                                  press: () async {
                                    // Validate the form
                                    final isValidate =
                                        _formkey.currentState?.validate();
                                    if (isValidate != true) {
                                      return;
                                    }

                                    // Set loading state
                                    setState(() {
                                      _signUpLoading = true;
                                    });

                                    // Perform sign-up
                                    await signUp(
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      gender,
                                    );

                                    // Reset loading state
                                    setState(() {
                                      _signUpLoading = false;
                                    });
                                  },
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          UnderPart(
                            title: "Already have an account?",
                            navigatorText: "Login here",
                            onTap: () {
                              Navigator.pushReplacement(
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
      ),
    );
  }
}
