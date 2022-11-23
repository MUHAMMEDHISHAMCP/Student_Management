import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_database/db/functoins/db_functions.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/search.dart';
import 'package:hive_database/screens/viewscreen.dart';
import 'package:provider/provider.dart';

class MainSreen extends StatelessWidget {
  const MainSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents(context);
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Students List',
              style: TextStyle(fontFamily: 'WelcomeFont'),
            ),
            backgroundColor: Colors.blue.shade400,
            actions: [
              IconButton(
                  iconSize: 30,
                  onPressed: () {
                    showSearch(context: context, delegate: SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
            ]),
        body: Consumer<SampleProvider>(
          builder: (context, value, child) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = value.newList[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ViewPage(
                                    studentdatas: data,
                                    index1: index,
                                  ))));
                    },
                    title: Text(data.name.toUpperCase()),
                    subtitle: const Text('Show more details'),
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                      backgroundColor: Colors.black,
                      radius: 30,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          deleteVerification(context, index);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
              itemCount: value.newList.length,
            );
          },
        ));
  }

  deleteVerification(BuildContext context, int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert !!'),
            content: const Text('Are you sure to want to delete ??'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  deleteData(index, context);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }
}
