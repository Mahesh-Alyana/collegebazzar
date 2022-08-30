import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/admin/product_approval.dart';
import 'package:collegebazzar/screens/user/cart_list.dart';
import 'package:collegebazzar/screens/user/home_screen.dart';
import 'package:collegebazzar/screens/user/search_results.dart';
import 'package:collegebazzar/screens/user/wishlist_screen.dart';
import 'package:collegebazzar/utils.dart/filters.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../screens/auth/login_screen.dart';
import '../screens/user/bookings.dart';
import '../screens/user/chat_list.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Container(
      width: width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())),
                    (route) => false);
              },
              child: Image.asset(
                "assets/images/logo.png",
                width: width * 0.1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: width * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                onFieldSubmitted: (val) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResults(
                          collection: Filter.filterName,
                          searchWord: searchController.text,
                        ),
                      ),
                      (route) => false);
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Color(0xffACACAC), fontSize: textSize * 0.015),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapShot) {
                  return Row(
                    children: [
                      !snapShot.hasData
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  "assets/images/profile.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : PopupMenuButton<String>(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/images/profile.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Callback that sets the selected popup menu item.

                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                if (snapShot.data!['admin'])
                                  PopupMenuItem<String>(
                                    // value: Menu.itemOne,
                                    child: GestureDetector(
                                        onTap: (() {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminApproval()),
                                              (route) => false);
                                        }),
                                        child: Text('Admin Pannel')),
                                  ),
                                PopupMenuItem<String>(
                                  // value: Menu.itemTwo,
                                  child: TextButton(
                                      onPressed: (() {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatList()),
                                            (route) => true);
                                        ChatList();
                                      }),
                                      child: Text('Chats')),
                                ),
                                PopupMenuItem<String>(
                                  // value: Menu.itemThree,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingsScreen()),
                                            (route) => true);
                                      },
                                      child: Text('Bookings')),
                                ),
                              ],
                            ),
                      snapShot.hasData
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hello,\n${snapShot.data!["userName"]}\n${snapShot.data!["rollNumber"]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize * 0.017,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Hello,",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: textSize * 0.017,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WishList()),
                    (route) => true);
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/fav.png"),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Wishlist",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize * 0.015,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CartList()),
                  (route) => true);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset("assets/images/cart.png"),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textSize * 0.022,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * 0.07,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Color(0xff4c52b0), Color(0xff61b1cc)],
                ),
              ),
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: textSize * 0.017,
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
