import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../user/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController userName = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController rollNumber = new TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: const Color(0xff262626),
        child: ListView(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height,
                    width: width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.1,
                        right: width * 0.1,
                      ),
                      child: Form(
                        key: key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Welcome,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: textSize * 0.035,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefix: SvgPicture.asset(
                                      'assets/images/profile_icon.svg',
                                      color: const Color(0xffacacac),
                                      height: 20,
                                    ),
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      color: const Color(0xffacacac),
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize * 0.015,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: email,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefix: SvgPicture.asset(
                                      'assets/images/email_icon.svg',
                                      color: const Color(0xffacacac),
                                      height: 20,
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      color: const Color(0xffacacac),
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize * 0.015,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: rollNumber,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefix: SvgPicture.asset(
                                      'assets/images/profile_icon.svg',
                                      color: const Color(0xffacacac),
                                      height: 20,
                                    ),
                                    hintText: "Roll number",
                                    hintStyle: TextStyle(
                                      color: const Color(0xffacacac),
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize * 0.015,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: password,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefix: SvgPicture.asset(
                                      'assets/images/password_icon.svg',
                                      color: const Color(0xffacacac),
                                      height: 20,
                                    ),
                                    hintText: "password",
                                    hintStyle: TextStyle(
                                      color: const Color(0xffacacac),
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize * 0.015,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: confirmPassword,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    prefix: SvgPicture.asset(
                                      'assets/images/password_icon.svg',
                                      color: const Color(0xffacacac),
                                      height: 20,
                                    ),
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                      color: const Color(0xffacacac),
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize * 0.015,
                                    ),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width * 0.3,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors: [
                                      const Color(0xff437ed6),
                                      const Color(0xff33a6df),
                                    ],
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                        FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text,
                                        )
                                            .then((value) {
                                          FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text,
                                          );
                                        }).then((value) {
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({
                                            "admin": false,
                                            "email": email.text,
                                            "userName": userName.text,
                                            "rollNumber": rollNumber.text,
                                          }).then((value) {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (route) => false);
                                          });
                                        });
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        "Signup",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 0.015,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: const Color(0xff747980),
                                      fontSize: textSize * 0.015,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          (route) => false);
                                    }),
                                    child: Text(
                                      " Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textSize * 0.015,
                                        fontFamily: "Barlow",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    width: width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        Image.asset("assets/images/login.png"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
