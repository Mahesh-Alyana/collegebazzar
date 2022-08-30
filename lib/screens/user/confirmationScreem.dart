import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/personal_chat_room.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => HomeScreen())),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Scaffold(
      backgroundColor: Color(0xff262626),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: [
              NavBar(),
              Container(
                height: height * 0.7,
                width: width,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.approval_rounded,
                          size: height * 0.2,
                          color: Colors.greenAccent,
                        ),
                      ),
                      Text(
                        "Order Confirmed",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: textSize * 0.035),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    height: height * 0.25,
                    width: width,
                    color: Colors.black,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Image.asset("assets/images/logo.png")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
