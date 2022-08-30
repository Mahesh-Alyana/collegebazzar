import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/personal_chat_room.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("Chats")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("chat")
                      .snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.hasError) {
                      print(snapShot.error);
                    }
                    return snapShot.hasError
                        ? Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.nearby_error_rounded,
                                  color: Color(0xffacacac),
                                  size: width * 0.2,
                                ),
                                Text(
                                  "No Chats",
                                  style: TextStyle(
                                      color: Color(0xffacacac),
                                      fontWeight: FontWeight.w600,
                                      fontSize: textSize * 0.025),
                                ),
                              ],
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height:
                                  height * 0.23 * snapShot.data!.docs.length,
                              width: width * 0.8,
                              child: ListView.builder(
                                  itemCount: snapShot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    return StreamBuilder<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(snapShot.data!.docs[index].id)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xff262626),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 10,
                                                      )
                                                    ]),
                                                width: width * 0.8,
                                                height: height * 0.2,
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PresonalChatRoom(
                                                                          userId: snapShot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id,
                                                                        )),
                                                            (route) => false);
                                                  },
                                                  child: Center(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: CircleAvatar(
                                                            minRadius:
                                                                textSize * 0.1,
                                                            child: Image.asset(
                                                                "assets/images/profile.jpg"),
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data![
                                                              "userName"],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                textSize * 0.02,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        });
                                  })),
                            ),
                          );
                  }),
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
