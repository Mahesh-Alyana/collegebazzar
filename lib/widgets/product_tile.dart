import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../screens/user/product_view.dart';

class ProductTile extends StatefulWidget {
  ProductTile({Key? key, required this.id, required this.collection})
      : super(key: key);

  String id;
  String collection;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var textSize = height < width ? height : width;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(
                widget.collection == "All" ? "items" : widget.collection)
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          return Container(
            height: height * 0.3,
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
                          snapshot.data!['name'],
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
                        child: FloatingActionButton(
                          backgroundColor: Colors.transparent,
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("wishList")
                                .add({
                              "id": snapshot.data!.id,
                            }).then((value) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Added to your wishlist"),
                              ));
                            });
                          },
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            size: textSize * 0.05,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Image.network(
                  snapshot.data!['images'][0],
                  height: width / height < 1.6 ? height * 0.2 : height * 0.3,
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
                              "₹ ${snapshot.data!['price']}",
                              style: TextStyle(
                                color: Color(0xffecebeb),
                                fontSize: textSize * 0.02,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              snapshot.data!['postedDate'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textSize * 0.01,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("cart")
                                .add({
                              "id": snapshot.data!.id,
                            }).then((value) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Added to cart"),
                              ));
                            });
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                              ),
                            ),
                            child: Center(
                                child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
