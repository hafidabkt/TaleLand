import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/src/color.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPassword createState() => _ForgetPassword();
}

class _ForgetPassword extends State<ForgetPassword> {
  int verify = 120;
  bool reset = false;
  String text = 'Enter The code Sent into your Email Box:';
  TextEditingController codeController = TextEditingController();
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
                imgUrl: "assets/login.png",
              ),
              const PageTitleBar(
                title: 'RESET YOUR PASSWORD',
              ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: reset,
                        child: Form(
                          child: Column(
                            children: [
                              const Text(
                                'Set Your New PassWord:',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 18,
                                ),
                              ),
                              const RoundedPasswordField(),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Confirm PassWord:',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 18,
                                ),
                              ),
                              const RoundedPasswordField(),
                              const SizedBox(
                                height: 20,
                              ),
                              RoundedButton(
                                  text: 'RESET PASSWORD',
                                  press: () {
                                    Navigator.pop(context);
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !reset,
                        child: Form(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 18,
                                ),
                              ),
                              TextFieldContainer(
                                  child: TextFormField(
                                controller: codeController,
                                cursorColor: myBlueColor,
                                decoration: InputDecoration(
                                    hintText: 'code',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'OpenSans',
                                        color: Colors.grey),
                                    border: InputBorder.none),
                              )),
                              const SizedBox(
                                height: 20,
                              ),
                              RoundedButton(
                                  text: 'Next',
                                  press: () {
                                    setState(() {
                                      if (verify.toString() == codeController.text) {
                                        reset = true;
                                      } else {
                                        codeController.clear();
                                        text = 'Wrong Code Try Again';
                                      }
                                    });
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
