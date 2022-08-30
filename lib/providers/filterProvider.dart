import 'package:collegebazzar/utils.dart/filters.dart';
import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  String _profile = "All";

  String get profile {
    return _profile;
  }

  Future<void> getProductList() async {
    _profile = Filter.filterName;
    notifyListeners();
  }
}
