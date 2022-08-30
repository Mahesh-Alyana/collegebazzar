import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResults extends StatefulWidget {
  SearchResults({
    Key? key,
    required this.collection,
    required this.searchWord,
  }) : super(key: key);
  String collection;
  String searchWord;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
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
            SizedBox(
              width: width * 0.97,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 218,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sort(Featured)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textSize * 0.015,
                              fontFamily: "Barlow",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                            size: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textSize * 0.02,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(widget.collection == "All"
                        ? "items"
                        : widget.collection)
                    .where("name", isGreaterThanOrEqualTo: widget.searchWord)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: height * 0.23 * 4,
                      width: width * 0.8,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                height: height * 0.2,
                                width: width * 0.6,
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
                                      snapshot.data!.docs[index]["images"][0],
                                      height: height * 0.15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: width * 0.6,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ["name"],
                                                    style: TextStyle(
                                                      color: Color(0xffecebeb),
                                                      fontSize: textSize * 0.03,
                                                      fontFamily: "Barlow",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Icon(
                                                      Icons
                                                          .favorite_border_rounded,
                                                      color: Colors.white,
                                                      size: textSize * 0.05,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ["price"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: textSize * 0.025,
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ["postedDate"],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: textSize * 0.02,
                                                fontFamily: "Barlow",
                                                fontWeight: FontWeight.w600,
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
                          })),
                    ),
                  );
                }),
            Align(
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
            )
          ],
        ),
      ),
    );
  }
}
