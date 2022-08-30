import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/personal_chat_room.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
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
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("Bookings")
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
                                  "No Bookings",
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
                                    return Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff262626),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
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
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Image.network(
                                                      snapShot.data!.docs[index]
                                                          ["images"][0],
                                                      height: height * 0.15,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapShot.data!
                                                                  .docs[index]
                                                              ["name"],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                textSize * 0.02,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapShot.data!
                                                                .docs[index]
                                                            ["price"],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              textSize * 0.015,
                                                        ),
                                                      ),
                                                      // Text(
                                                      //   snapShot.data!
                                                      //               .docs[index]
                                                      //           ["payment"]
                                                      //       ? "Payed"
                                                      //       : "Have to pay",
                                                      //   style: TextStyle(
                                                      //     color: Colors.white,
                                                      //     fontSize:
                                                      //         textSize * 0.015,
                                                      //   ),
                                                      // ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
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
