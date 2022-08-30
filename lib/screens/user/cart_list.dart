import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
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
                      .collection("cart")
                      .snapshots(),
                  builder: (context, snapShot) {
                    return snapShot.hasError
                        ? CircularProgressIndicator()
                        : snapShot.data!.docs.length == 0
                            ? Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.nearby_error_rounded,
                                        color: Color(0xffacacac),
                                        size: width * 0.2,
                                      ),
                                    ),
                                    Text(
                                      "No Items in your Cart",
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
                                  height: height *
                                      0.23 *
                                      snapShot.data!.docs.length,
                                  width: width * 0.8,
                                  child: ListView.builder(
                                      itemCount: snapShot.data!.docs.length,
                                      itemBuilder: ((context, index) {
                                        return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection("items")
                                                .doc(snapShot.data!.docs[index]
                                                    ["id"])
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Container(
                                                  height: height * 0.2,
                                                  width: width * 0.6,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0x4d000000),
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
                                                        snapshot.data!['images']
                                                            [0],
                                                        height: height * 0.15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                width:
                                                                    width * 0.6,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      snapshot.data![
                                                                          'name'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xffecebeb),
                                                                        fontSize:
                                                                            textSize *
                                                                                0.03,
                                                                        fontFamily:
                                                                            "Barlow",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10.0),
                                                                      child:
                                                                          FloatingActionButton(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        onPressed:
                                                                            (() {
                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection("users")
                                                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                                                              .collection("cart")
                                                                              .doc(snapShot.data!.docs[index].id)
                                                                              .delete()
                                                                              .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text("Deleted"),
                                                                                  )));
                                                                        }),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .delete_forever_outlined,
                                                                          color:
                                                                              Colors.red,
                                                                          size: textSize *
                                                                              0.05,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  height * 0.01,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                snapshot.data![
                                                                    'price'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      textSize *
                                                                          0.025,
                                                                  fontFamily:
                                                                      "Barlow",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                snapshot.data![
                                                                    'postedDate'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      textSize *
                                                                          0.02,
                                                                  fontFamily:
                                                                      "Barlow",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
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
