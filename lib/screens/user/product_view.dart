import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/chatroom.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils.dart/filters.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.Collection, required this.id})
      : super(key: key);
  String Collection;
  String id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _length = 10;
  int _index = 0;
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
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(Filter.filterName == "All"
                      ? "items"
                      : "${Filter.filterName}")
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                List images = snapshot.data!["images"];
                return Container(
                  height: height * 0.65,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Container(
                        height: height * 0.2 * 3,
                        width: width * 0.08,
                        child: ListView.builder(
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width * 0.05,
                                  height: height * 0.15,
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
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        _index = index;
                                      });
                                    },
                                    child: Center(
                                        child: Image.network(images[index],
                                            height: height * 0.12)),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        width: width * 0.50,
                        height: height * 0.65,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Positioned(
                                top: height * 0.15,
                                child: Image.network(
                                  images[_index],
                                  height: height * 0.4,
                                  fit: BoxFit.fitHeight,
                                )),
                            Image.asset("assets/images/back.png"),
                            Image.asset(
                              "assets/images/base.png",
                              width: width * 0.3,
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: height * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 0.035,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!["price"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 0.022,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!["postedDate"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 0.015,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.07,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Product Details ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: textSize * 0.022,
                                    fontFamily: "Barlow",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width * 0.3,
                                  child: GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _length == 0
                                            ? _length = 10
                                            : _length = 0;
                                      });
                                    }),
                                    child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Barlow",
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            text: snapshot.data!["description"]
                                                .toString()
                                                .substring(
                                                    0,
                                                    snapshot.data![
                                                                "description"]
                                                            .toString()
                                                            .length -
                                                        _length),
                                            children: [
                                          TextSpan(
                                            text: _length == 0
                                                ? "Read leadd"
                                                : "Read more",
                                            style: TextStyle(
                                              color: Color(0xff28a1e6),
                                              fontSize: 15,
                                              fontFamily: "Barlow",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ])),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width > height
                                      ? width * 0.1
                                      : width * 0.3,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: Color(0xff008535),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: MaterialButton(
                                      onPressed: (() async {
                                        await FirebaseFirestore.instance
                                            .collection("Chats")
                                            .doc(snapshot.data!["userId"])
                                            .collection("chat")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .set({
                                          "id": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "productId": snapshot.data!.id
                                        });
                                        FirebaseFirestore.instance
                                            .collection("Chats")
                                            .doc(snapshot.data!["userId"])
                                            .collection("chat")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("chats")
                                            .doc(DateTime.now().toString())
                                            .set({
                                          "Message": "Hi",
                                          "sender": true
                                        }).then((value) {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatRoom(
                                                          userId: snapshot
                                                              .data!["userId"],
                                                          productId: snapshot
                                                              .data!.id)),
                                              (route) => false);
                                        });
                                      }),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/message.svg"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Message",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: textSize * 0.02,
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
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width * 0.1,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff5d9cc6),
                                              Color(0xff4e5bb3)
                                            ],
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: MaterialButton(
                                          onPressed: (() {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection("cart")
                                                .add({
                                              "id": snapshot.data!.id,
                                            });
                                          }),
                                          child: Center(
                                            child: Text(
                                              "Add to cart",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: textSize * 0.018,
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: width * 0.1,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff5d9cc6),
                                              Color(0xff4e5bb3)
                                            ],
                                          )),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: MaterialButton(
                                          onPressed: (() {
                                            FirebaseFirestore.instance
                                                .collection("users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .collection("wishList")
                                                .add({
                                              "id": snapshot.data!.id,
                                            });
                                          }),
                                          child: Center(
                                            child: Text(
                                              "Add to Wishlist",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: textSize * 0.018,
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
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
    );
  }
}
