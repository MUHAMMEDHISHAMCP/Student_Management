// ignore_for_file: invalid_use_of_protected_member

// import 'package:flutter/material.dart';
import 'package:hive_database/model/data_model.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// ValueNotifier<List<StudentModel>> listNotifier = ValueNotifier([]);

addStudent(StudentModel value,context) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
 studentDb.add(value);
 getAllStudents(context);


  // value.id = datas;
  // studentDb.putAt(value.id!, value);
  // listNotifier.value.add(value);

  // ignore: invalid_use_of_visible_for_testing_member
  // listNotifier.notifyListeners();
}

getAllStudents(context) async {
  final studetDb = await Hive.openBox<StudentModel>('student_db');
  // listNotifier.value.clear();
  // listNotifier.value.addAll(studetDb.values);
  // ignore: invalid_use_of_visible_for_testing_member,
  // listNotifier.notifyListeners();

  Provider.of<SampleProvider>(context,listen: false).getStudentDatas(value: studetDb.values);
}

updateData(value, intex,context) async {
  final studetDb = await Hive.openBox<StudentModel>('student_db');
  await studetDb.putAt(intex, value);
  getAllStudents(context);

// ignore: invalid_use_of_visible_for_testing_member
  // listNotifier.notifyListeners();
}

deleteData(int id, context) async {
  final studetDb = await Hive.openBox<StudentModel>('student_db');
  await studetDb.deleteAt(id);
  getAllStudents(context);
}
