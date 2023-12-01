import 'package:flutter/material.dart';
import 'package:project/src/intrest.dart';
import 'package:project/components/components.dart';
import 'package:project/components/under_part.dart';
import 'package:project/src/screens.dart';
import 'package:project/widgets/widgets.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                         RoundedDateInputField(
                          hintText: 'Date of birth',
                          icon: Icons.calendar_today_rounded,
                        ),
                        const RoundedGenderSelectionField(),
                        RoundedInputField(
                          hintText: "Email",
                          icon: Icons.email,
                        ),
                        RoundedInputField(
                          hintText: "Name",
                          icon: Icons.person,
                        ),
                        const RoundedPasswordField(),
                       
                        RoundedButton(
                          text: 'SIGN UP',
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IntrestScreen(),
                              ),
                            );
                          },
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
