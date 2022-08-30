import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/product_view.dart';
import 'package:collegebazzar/screens/user/stocks.dart';
import 'package:collegebazzar/screens/user/uploadForm.dart';
import 'package:collegebazzar/utils.dart/filters.dart';
import 'package:collegebazzar/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/carasol.dart';
import '../../widgets/nav_bar.dart';
import '../../widgets/product_types.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(Filter.filterName);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: NavBar(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: width * 0.6,
                      child: ListView.builder(
                          itemCount: Filter.filters.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: (() {
                                  for (int i = 0;
                                      i < Filter.filters.length;
                                      i++) {
                                    setState(() {
                                      Filter.filters[i][1] = false;
                                    });
                                  }
                                  setState(() {
                                    Filter.filters[index][1] = true;
                                    Filter.filterName =
                                        Filter.filters[index][0];
                                    // print(Filter.filterName);
                                  });
                                }),
                                child: Container(
                                  height: 60,
                                  decoration: Filter.filters[index][1]
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff5d9cc6),
                                              Color(0xff4e5bb3)
                                            ],
                                          ))
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x4d000000),
                                              blurRadius: 12,
                                              offset: Offset(4, 4),
                                            ),
                                          ],
                                          color: Color(0xff262626),
                                        ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 6),
                                      child: Text(
                                        Filter.filters[index][0],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textSize * 0.016,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width * 0.2,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                          onPressed: (() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadFormScreen()),
                                (route) => true);
                          }),
                          child: Center(
                            child: Text(
                              "SELL AN ITEMS",
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
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                          onPressed: (() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StockRoom()),
                                (route) => true);
                          }),
                          child: Center(
                            child: Text(
                              "Stock",
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
              ),
              Filter.filterName == "All" ? Carasol() : const SizedBox(),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection(Filter.filterName == "All"
                          ? "items"
                          : "${Filter.filterName}")
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(snapshot.data!.docs.length);
                    return snapshot.hasError
                        ? CircularProgressIndicator()
                        : snapshot.data!.docs.length == 0
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
                                      "Sorry.....!\nNo Items in Stock",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xffacacac),
                                          fontWeight: FontWeight.w600,
                                          fontSize: textSize * 0.025),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.35 * 3,
                                  width: width * 0.95,
                                  child: GridView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 50,
                                              mainAxisSpacing: 50),
                                      itemBuilder: ((context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductScreen(
                                                          Collection:
                                                              Filter.filterName,
                                                          id: snapshot.data!
                                                              .docs[index].id,
                                                        )),
                                                (route) => true);
                                          },
                                          child: ProductTile(
                                              collection: Filter.filterName,
                                              id: snapshot
                                                  .data!.docs[index].id),
                                        );
                                      })),
                                ),
                              );
                  }),
              SizedBox(
                height: height * 0.02,
              ),
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
      ),
    );
  }
}
