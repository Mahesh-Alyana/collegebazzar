import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:collegebazzar/widgets/product_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({Key? key, required this.userId, required this.productId})
      : super(key: key);

  String userId;
  String productId;
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController message = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Scaffold(
      backgroundColor: Color(0xff262626),
      body: Column(
        children: [
          NavBar(),
          Container(
            height: height * 0.65,
            width: width,
            child: Row(
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("Chats")
                        .doc(widget.userId)
                        .collection("chat")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("chats")
                        .snapshots(),
                    builder: (context, snapShot) {
                      return SizedBox(
                        width: width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width * 0.06,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: MaterialButton(
                                    onPressed: (() {
                                      Navigator.pop(context);
                                    }),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          "Back",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Barlow",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.userId)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  return Row(
                                    children: [
                                      Text(
                                        snapshot.data!["userName"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 0.015,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        " - ",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 0.015,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!["rollNumber"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 0.015,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                            Container(
                              width: width * 0.6,
                              height:
                                  width > height ? height * 0.5 : height * 0.65,
                              child: ListView.builder(
                                  itemCount: snapShot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: snapShot.data!.docs[index]
                                              ["sender"]
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    snapShot.data!.docs[index]
                                                        ["Message"],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    snapShot.data!.docs[index]
                                                        ["Message"],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    );
                                  })),
                            ),
                            Expanded(
                                child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: width * 0.6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: TextFormField(
                                      onEditingComplete: (() {
                                        FirebaseFirestore.instance
                                            .collection("Chats")
                                            .doc(widget.userId)
                                            .collection("chat")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("chats")
                                            .doc(DateTime.now().toString())
                                            .set({
                                          "Message": message.text,
                                          "sender": true
                                        }).then((value) => {
                                                  setState((() {
                                                    message.text = "";
                                                  }))
                                                });
                                      }),
                                      controller: message,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 20),
                                        // prefix: IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(
                                        //       Icons.emoji_emotions,
                                        //       color: Color(0xff262626),
                                        //     )),
                                        suffix: IconButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("Chats")
                                                  .doc(widget.userId)
                                                  .collection("chat")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .collection("chats")
                                                  .doc(
                                                      DateTime.now().toString())
                                                  .set({
                                                "Message": message.text,
                                                "sender": true
                                              }).then((value) => {
                                                        setState((() {
                                                          message.text = "";
                                                        }))
                                                      });
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.black,
                                            )),
                                        hintText: "Enter your message",
                                        hintStyle: TextStyle(
                                            color: Color(0xffACACAC),
                                            fontSize: textSize * 0.015),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  width: width * 0.05,
                ),
                Container(
                  height: height * 0.35,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x4d000000),
                        blurRadius: 12,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Color(0xff262626),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Boat Ws54",
                                style: TextStyle(
                                  color: Color(0xffecebeb),
                                  fontSize: textSize * 0.027,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.white,
                                size: textSize * 0.05,
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/images/product.png",
                        height: height * 0.2,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₹2000.00",
                                    style: TextStyle(
                                      color: Color(0xffecebeb),
                                      fontSize: textSize * 0.02,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "12th August 2022",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: textSize * 0.01,
                                      fontFamily: "Barlow",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xff5d9cc6),
                                      Color(0xff4e5bb3)
                                    ],
                                  ),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
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
    );
  }
}
