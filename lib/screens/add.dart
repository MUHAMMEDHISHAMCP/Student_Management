// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_database/db/functoins/db_functions.dart';
import 'package:hive_database/model/data_model.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);


  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _idNoController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String imageToString = '';
  String newImage = '';

  pickImage( context) async {
    final imageFromFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(imageFromFile!.path).readAsBytesSync();
    imageToString = base64Encode(bytes);
    
 Provider.of<SampleProvider>(context,listen: false).changeImage(imageToString);
 
     }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
     Provider.of<SampleProvider>(context,listen: false).newImage = '';
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              if (Provider.of<SampleProvider>(context, listen: false)
                      .currentIndex ==
                  1) {
                Provider.of<SampleProvider>(context, listen: false).currentIndex =
                    0;

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => HomeScreen())));
              }
              imageToString='';
            },
            icon: const Icon(Icons.clear)),
        backgroundColor: Colors.blue,
        title: const Text('Add Student'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Consumer<SampleProvider>(
                    builder: (context, value, child) => 
                     GestureDetector(
                      onTap: () {
                        pickImage(context);
                      },
                      child: 
                         CircleAvatar(
                          backgroundImage:
                              MemoryImage(const Base64Decoder().convert(value.newImage)),
                          backgroundColor: Colors.grey.shade500,
                          radius: 60,
                          child: value.newImage.isEmpty
                              ? const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.black,
                                )
                              : const SizedBox(),
                        ),
                      
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        label: Text('Name')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        label: Text('Batch')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Batch';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _idNoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        label: Text('MobNo')),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter MobNo';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate() &&
                            imageToString.isNotEmpty) {
                          if (Provider.of<SampleProvider>(context, listen: false)
                                  .currentIndex ==
                              1) {
                            Provider.of<SampleProvider>(context, listen: false)
                                .currentIndex = 0;

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomeScreen())));
                          }
                        } else if (newImage.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please Add Image'),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                            duration: Duration(seconds: 10),
                          ));
                        }
                        addStudentClicked(context);
                        
                      },
                      child: const Text('+ Add Student'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addStudentClicked(BuildContext context) {
    final nameList = _nameController.text.trim();
    final ageList = _ageController.text.trim();
    final mobNoList = _idNoController.text.trim();

    if (nameList.isEmpty ||
        ageList.isEmpty ||
        mobNoList.isEmpty ||
        imageToString.isEmpty) {
      return;
    } else {
      final students = StudentModel(
          name: nameList, age: ageList, mobNo: mobNoList, image:imageToString);
      addStudent(students,context);
      
    }
  }
}
