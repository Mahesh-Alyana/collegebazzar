import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/home_screen.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Scaffold(
      backgroundColor: Color(0xff262626),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("postedItems")
                    .snapshots(),
                builder: (context, snapShot) {
                  print(snapShot.data!.docs.length);
                  return snapShot.data!.docs.length == 0
                      ? Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.nearby_error_rounded,
                                color: Color(0xffacacac),
                                size: width * 0.2,
                              ),
                              Text(
                                "No Items to be approved",
                                style: TextStyle(
                                    color: Color(0xffacacac),
                                    fontWeight: FontWeight.w600,
                                    fontSize: textSize * 0.025),
                              ),
                            ],
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: height * 0.23 * 4,
                            width: width * 0.8,
                            child: ListView.builder(
                                itemCount: snapShot.data!.docs.length,
                                itemBuilder: ((context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      height: height * 0.2,
                                      width: width * 0.55,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x4d000000),
                                            blurRadius: 12,
                                            offset: Offset(4, 4),
                                          ),
                                        ],
                                        color: Color(0xff262626),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.05,
                                          ),
                                          Image.network(
                                            snapShot.data!.docs[index]
                                                .get("images")[0],
                                            height: height * 0.15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: width * 0.4,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapShot
                                                              .data!.docs[index]
                                                              .get("name"),
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffecebeb),
                                                            fontSize:
                                                                textSize * 0.03,
                                                            fontFamily:
                                                                "Barlow",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "₹${snapShot.data!.docs[index].get("price")}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: textSize *
                                                                0.025,
                                                            fontFamily:
                                                                "Barlow",
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          snapShot
                                                              .data!.docs[index]
                                                              .get(
                                                                  "postedDate"),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                textSize * 0.02,
                                                            fontFamily:
                                                                "Barlow",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: width * 0.25,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: width * 0.12,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            color: Color(
                                                                0xff000586),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.call,
                                                                color: Colors
                                                                    .white,
                                                                size: 30,
                                                              ),
                                                              Text(
                                                                "Contact",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      textSize *
                                                                          0.015,
                                                                  fontFamily:
                                                                      "Barlow",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            width: width * 0.12,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              color: Color(
                                                                  0xff008636),
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                    barrierDismissible:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    });
                                                                var data = snapShot
                                                                        .data!
                                                                        .docs[
                                                                    index];
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "items")
                                                                    .add({
                                                                  "images": data[
                                                                      'images'],
                                                                  "name": data[
                                                                      "name"],
                                                                  "description":
                                                                      data[
                                                                          "description"],
                                                                  "price": data[
                                                                      "price"],
                                                                  "approved":
                                                                      true,
                                                                  "userId": data[
                                                                      "userId"],
                                                                  "type": data[
                                                                      "type"],
                                                                  "postedDate":
                                                                      data[
                                                                          "postedDate"],
                                                                }).then((value) {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          data[
                                                                              "type"])
                                                                      .add({
                                                                    "images": data[
                                                                        'images'],
                                                                    "name": data[
                                                                        "name"],
                                                                    "description":
                                                                        data[
                                                                            "description"],
                                                                    "price": data[
                                                                        "price"],
                                                                    "approved":
                                                                        true,
                                                                    "userId": data[
                                                                        "userId"],
                                                                    "type": data[
                                                                        "type"],
                                                                    "postedDate":
                                                                        data[
                                                                            "postedDate"],
                                                                  }).then((value) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "users")
                                                                        .doc(snapShot.data!.docs[index]
                                                                            [
                                                                            "userId"])
                                                                        .collection(
                                                                            "stock")
                                                                        .add({
                                                                      "images":
                                                                          data[
                                                                              'images'],
                                                                      "name": data[
                                                                          "name"],
                                                                      "description":
                                                                          data[
                                                                              "description"],
                                                                      "price": data[
                                                                          "price"],
                                                                      "approved":
                                                                          true,
                                                                      "userId":
                                                                          data[
                                                                              "userId"],
                                                                      "type": data[
                                                                          "type"],
                                                                      "postedDate":
                                                                          data[
                                                                              "postedDate"],
                                                                    }).then((value) {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "postedItems")
                                                                          .doc(snapShot
                                                                              .data!
                                                                              .docs[index]
                                                                              .id)
                                                                          .delete();
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text("Accepted"),
                                                                      ));
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pushAndRemoveUntil(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  HomeScreen()),
                                                                          (route) =>
                                                                              false);
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .check_circle,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 30,
                                                                    ),
                                                                    Text(
                                                                      "Accept",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            textSize *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Barlow",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: width * 0.12,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              color: Color(
                                                                  0xff860000),
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                    barrierDismissible:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "postedItems")
                                                                    .doc(snapShot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .id)
                                                                    .delete()
                                                                    .then(
                                                                        (value) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    content: Text(
                                                                        "Rejected"),
                                                                  ));
                                                                  Navigator.pop(
                                                                      context);
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              HomeScreen()),
                                                                      (route) =>
                                                                          false);
                                                                });
                                                              },
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 30,
                                                                    ),
                                                                    Text(
                                                                      "Reject",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            textSize *
                                                                                0.015,
                                                                        fontFamily:
                                                                            "Barlow",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
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
                                })),
                          ),
                        );
                }),
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
