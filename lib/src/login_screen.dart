import 'package:flutter/material.dart';
import 'package:project/backend/backend.dart';
import 'package:project/src/color.dart';
import 'package:project/components/components.dart';
import 'package:project/components/under_part.dart';
import 'package:project/src/screens.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/src/Home.dart';
import 'package:project/src/resetPassword.dart';
import 'package:project/utils/constant.dart';
import 'package:project/global.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _signInLoading = false;

  final _formkey = GlobalKey<FormState>();

  @override
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

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
                  Upside(
                    imgUrl: "assets/login.png",
                  ),
                  const PageTitleBar(
                    title: 'WELCOME TO TaleLand',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 320.0),
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
                                fontWeight: FontWeight.w600),
                          ),
                          Form(
                            child: Column(
                              children: [
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
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                TextFieldContainer(
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    cursorColor: myPinkColor,
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            fontFamily: 'OpenSans',
                                            color: Colors.grey),
                                        suffixIcon: Icon(
                                          Icons.visibility,
                                          color: myPinkColor,
                                        ),
                                        border: InputBorder.none),
                                  ),
                                ),
                                switchListTile(),
                                _signInLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : RoundedButton(
                                        text: 'LOGIN',
                                        press: () async {
                                          final isValidate =
                                              _formkey.currentState?.validate();
                                          if (isValidate != true) {
                                            return;
                                          }
                                          setState(() {
                                            _signInLoading = true;
                                          });
                                          try {
                                            // Check the custom 'users' table for the user's existence
                                            final userResponse = await supabase
                                                .from('profiles')
                                                .select(
                                                    'id, email, password, name') // Adjust columns as needed
                                                .eq('email',
                                                    emailController.text)
                                                .eq('password',
                                                    passwordController.text)
                                                .single();
                                            final user = await getProfile(
                                                userResponse['id']);
                                            if (userResponse != null) {
                                              // User exists in the 'users' table, login is successful
                                              print('Login successful');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('Login successful'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                              
                                              getForYou();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('Log in failed'),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            // Exception during login
                                            print('Error during login: $e');
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Log in failed'),
                                                backgroundColor:
                                                    Colors.redAccent,
                                              ),
                                            );
                                          } finally {
                                            setState(() {
                                              _signInLoading = false;
                                            });
                                          }
                                        }),
                                const SizedBox(
                                  height: 10,
                                ),
                                UnderPart(
                                  title: "Don't have an account?",
                                  navigatorText: "Register here",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPassword()));
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: myPurpleColor,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

switchListTile() {
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 40),
    child: SwitchListTile(
      dense: true,
      title: const Text(
        'Remember Me',
        style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'),
      ),
      value: true,
      activeColor: myPurpleColor,
      onChanged: (val) {},
    ),
  );
}

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      RoundedIcon(imageUrl: "assets/facebook.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/twitter.png"),
      SizedBox(
        width: 20,
      ),
      RoundedIcon(imageUrl: "assets/google.jpg"),
    ],
  );
}
