import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchDataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore ref = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await ref.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String string) async {
    return FirebaseFirestore.instance
        .collection("items")
        .where("title", isGreaterThanOrEqualTo: string)
        .get();
  }
}
