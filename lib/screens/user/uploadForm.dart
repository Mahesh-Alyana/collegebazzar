import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegebazzar/screens/user/home_screen.dart';
import 'package:collegebazzar/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadFormScreen extends StatefulWidget {
  const UploadFormScreen({Key? key}) : super(key: key);

  @override
  State<UploadFormScreen> createState() => _UploadFormScreenState();
}

class _UploadFormScreenState extends State<UploadFormScreen> {
  List images = [];
  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    addImage(File(pickedFile!.path));
  }

  // void _cropImage(String filePath) async {
  //   CroppedFile? croppedImage =
  //       await ImageCropper().cropImage(sourcePath: filePath);
  //   if (croppedImage != null) {
  //     print("adding File to list");
  //     addImage(File(croppedImage.path));
  //   }
  // }

  void addImage(File? imageFile) async {
    print("adding file to DB");
    final ref = FirebaseStorage.instance
        .ref()
        .child("userImages")
        .child(DateTime.now().toString());
    await ref.putFile(imageFile!);
    String imageUrl = await ref.getDownloadURL();
    images.add(imageUrl);
  }

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  String? itemType;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height * 0.65,
              width: width,
              child: Column(
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                  Form(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SizedBox(
                      //   width: width * 0.05,
                      // ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  prefixIcon: Icon(Icons.add_card,
                                      color: Color(0xffacacac)),
                                  hintText: "Item Name",
                                  hintStyle: TextStyle(
                                    color: const Color(0xffacacac),
                                    fontWeight: FontWeight.w500,
                                    fontSize: textSize * 0.015,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                controller: price,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  prefixIcon: Icon(
                                    Icons.currency_rupee,
                                    color: Color(0xffacacac),
                                  ),
                                  hintText: "Price",
                                  hintStyle: TextStyle(
                                    color: const Color(0xffacacac),
                                    fontWeight: FontWeight.w500,
                                    fontSize: textSize * 0.015,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: Color(0xff262626),
                                    elevation: 1,
                                    underline: SizedBox(),
                                    hint: Text(
                                      "Product type",
                                      style: TextStyle(
                                          color: Color(
                                        0xffacacac,
                                      )),
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    value: itemType,
                                    items: <String>[
                                      'Electronics',
                                      'Goodies',
                                      'Vehicles',
                                      'Books',
                                      "Lab Equipments",
                                      "Utensils",
                                      "Clothes"
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        itemType = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: width * 0.35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                maxLines: 10,
                                controller: description,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: "Description",
                                  hintStyle: TextStyle(
                                    color: const Color(0xffacacac),
                                    fontWeight: FontWeight.w500,
                                    fontSize: textSize * 0.015,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Images",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                // _getFromGallery();
                                setState(() {
                                  images.add("assets/images/product.png");
                                });
                              }),
                              child: Container(
                                width: width * 0.3,
                                height: height * 0.22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff5c5c5c),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        size: width * 0.05,
                                        color: Color(0xffacacac),
                                      ),
                                      Text(
                                        "Select to upload Images",
                                        style: TextStyle(
                                          color: Color(0xffacacac),
                                          fontSize: 17,
                                          fontFamily: "Barlow",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.15,
                              width: width * 0.1 * images.length,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: width * 0.05,
                                        height: height * 0.15,
                                        decoration: BoxDecoration(
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
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      images.remove(
                                                          images[index]);
                                                    });
                                                  },
                                                  child: Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            // Image.asset("${images[index]}",
                                            //     height: height * 0.1),
                                            Image.asset(
                                              images[index],
                                              height: height * 0.1,
                                            )
                                          ],
                                        )),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width * 0.3,
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
                            FirebaseFirestore.instance
                                .collection("postedItems")
                                .add({
                              "images": images,
                              "name": name.text,
                              "description": description.text,
                              "price": price.text,
                              "approved": false,
                              "userId": FirebaseAuth.instance.currentUser!.uid,
                              "type": itemType,
                              "postedDate":
                                  "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
                            }).then((value) {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("stock")
                                  .add({
                                "images": images,
                                "name": name.text,
                                "description": description.text,
                                "price": price.text,
                                "approved": false,
                                "userId":
                                    FirebaseAuth.instance.currentUser!.uid,
                                "type": itemType,
                                "postedDate":
                                    "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (route) => false);
                            });
                          }),
                          child: Center(
                            child: Text(
                              "Submit",
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
                ],
              ),
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
