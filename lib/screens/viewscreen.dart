// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_database/model/data_model.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/editscreen.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatelessWidget {
  StudentModel studentdatas;
  int? index1;

  ViewPage({
    Key? key,
    required this.studentdatas,
    required this.index1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: const Text(
          'Student Detials',
          style: TextStyle(fontFamily: 'WelcomeFont'),
        ),
        centerTitle: true,
        actions: [
          Consumer<SampleProvider>(
            builder: (context, value, child) => IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditScreen(
                                data: studentdatas,
                                index2: index1,
                              ))));
                  value.updatedImage = '';
                },
                icon: const Icon(Icons.edit)),
          )
        ],
      ),
      body: Center(
        child: Card(
          elevation: 20,
          shadowColor: Colors.black,
          child: Container(
            height: 500,
            width: 300,
            decoration: BoxDecoration(color: Colors.blue.shade400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: MemoryImage(
                      const Base64Decoder().convert(studentdatas.image)),
                  backgroundColor: Colors.black,
                  radius: 70,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Name :  ${studentdatas.name}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Batch :  ${studentdatas.age}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'MobNo :  ${studentdatas.mobNo}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
