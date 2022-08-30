import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:collegebazzar/widgets/product_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PresonalChatRoom extends StatefulWidget {
  PresonalChatRoom({
    Key? key,
    required this.userId,
  }) : super(key: key);

  String userId;
  @override
  State<PresonalChatRoom> createState() => _PresonalChatRoomState();
}

class _PresonalChatRoomState extends State<PresonalChatRoom> {
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
            child: Center(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Chats")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("chat")
                      .doc(widget.userId)
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                                    child: snapShot.data!.docs[index]["sender"]
                                        ? Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
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
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: width * 0.6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: TextFormField(
                                        controller: message,
                                        onEditingComplete: () {
                                          FirebaseFirestore.instance
                                              .collection("Chats")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .collection("chat")
                                              .doc(widget.userId)
                                              .collection("chats")
                                              .doc(DateTime.now().toString())
                                              .set({
                                            "Message": message.text,
                                            "sender": false
                                          }).then((value) =>
                                                  {message.text = ""});
                                        },
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(bottom: 20),
                                          // prefix: IconButton(
                                          //     onPressed: () {},
                                          //     icon: Icon(
                                          //       Icons.emoji_emotions,
                                          //       color: Color(0xff262626),
                                          //     )),

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
                                  IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection("Chats")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("chat")
                                            .doc(widget.userId)
                                            .collection("chats")
                                            .doc(DateTime.now().toString())
                                            .set({
                                          "Message": message.text,
                                          "sender": false
                                        }).then((value) {
                                          message.text = "";
                                        });
                                      },
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                            ),
                          ))
                        ],
                      ),
                    );
                  }),
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
