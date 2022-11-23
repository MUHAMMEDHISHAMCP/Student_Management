import 'package:flutter/material.dart';

import 'package:hive_database/model/data_model.dart';

class SampleProvider with ChangeNotifier {
  int _currentIndex = 0;
  get currentIndex => _currentIndex;

  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }

  String newImage = '';
  String updatedImage = '';
  List<StudentModel> newList = [];

  changeImage(String image) {
    newImage = image;
    updatedImage = image;
    notifyListeners();
  }

  updateImage(String image) {
    updatedImage = image;
    notifyListeners();
  }

  getStudentDatas({required value}) {
    newList.clear();
    newList.addAll(value);
    notifyListeners();
  }


}
