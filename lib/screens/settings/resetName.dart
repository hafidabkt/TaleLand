import 'package:flutter/material.dart';
import 'package:project/components/components.dart';
import 'package:project/widgets/widgets.dart';
import 'package:project/theme/color.dart';

class nameReset extends StatefulWidget {
  nameReset({Key? key}) : super(key: key);

  @override
  _nameReset createState() => _nameReset();
}

class _nameReset extends State<nameReset> {

  TextEditingController nameController = TextEditingController();
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
                title: 'RESET YOUR NAME',
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
                      Form(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Set Your New User Name',
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontSize: 18,
                                ),
                              ),
                              TextFieldContainer(
                                  child: TextFormField(
                                controller: nameController,
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
