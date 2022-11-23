import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_database/db/functoins/db_functions.dart';
import 'package:hive_database/model/data_model.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditScreen extends StatelessWidget {
  StudentModel data;
  int? index2;

  EditScreen({Key? key, required this.data, required this.index2})
      : super(key: key);

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final mobNoController = TextEditingController();

  String imageToString = '';
  String newImage = '';

  pickImage(context) async {
    // ignore: deprecated_member_use
    final imageFromFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(imageFromFile!.path).readAsBytesSync();
    imageToString = base64Encode(bytes);
    Provider.of<SampleProvider>(context, listen: false)
        .updateImage(imageToString);
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameController.text = data.name;
      ageController.text = data.age;
      mobNoController.text = data.mobNo;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update Detials',
          style: TextStyle(fontFamily: 'Hello'),
        ),
        backgroundColor: Colors.blue.shade400,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Form(
                  key: _formkey,
                  child: ListView(
                    children: [
                      Consumer<SampleProvider>(
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            pickImage(context);
                          },
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(
                              const Base64Decoder().convert(
                                  value.updatedImage.isEmpty
                                      ? data.image
                                      : value.updatedImage),
                            ),
                            backgroundColor: Colors.black,
                            radius: 70,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            label: Text(
                              'Name ',
                              style: TextStyle(color: Colors.black),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'EnterName';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            label: Text(
                              'Age',
                              style: TextStyle(color: Colors.black),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'EnterName';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: mobNoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          label: Text(
                            'MobNo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'EnterName';
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
                            if (_formkey.currentState!.validate()) {
                              updateButtonClicked(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HomeScreen())));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                  'UPDATE SUCCESFUL',
                                  style: TextStyle(color: Colors.black),
                                ),

                                backgroundColor: Colors.white,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(10),
                                // duration: Duration(seconds: 10),
                              ));
                            }
                          },
                          child: const Text('  Update  ')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  updateButtonClicked(BuildContext context) async {
    final nameList = nameController.text.trim();
    final ageList = ageController.text.trim();
    final mobNoList = mobNoController.text.trim();
    if (imageToString.isEmpty) {
      final updateList = StudentModel(
          name: nameList, age: ageList, mobNo: mobNoList, image: data.image);
      await updateData(updateList, index2, context);
    } else if (imageToString.isNotEmpty) {
      final updateList = StudentModel(
          name: nameList, age: ageList, mobNo: mobNoList, image: imageToString);
      await updateData(updateList, index2, context);
    }
    // final updateList = StudentModel(
    //     name: nameList, age: ageList, mobNo: mobNoList, image: imageToString);
    // await updateData(updateList, index2);
  }
}
