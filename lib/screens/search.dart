import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_database/db/functoins/db_functions.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/viewscreen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<SampleProvider>(
        
        builder: (context, value, child)  {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final data = value.newList[index];
                if (query == data.name.toLowerCase() ||
                    query == data.name.toUpperCase()) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                      radius: 35,
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          (MaterialPageRoute(builder: (ctx) {
                            return ViewPage(studentdatas: data, index1: index);
                          })),
                          (route) => false);
                    },
                    title: Text(data.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    trailing: IconButton(
                      onPressed: () {
                        deleteVerification(context, index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
              
              itemCount: value.newList.length,
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Consumer<SampleProvider>(
           builder: (context, value, child)  {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = value.newList[index];
                if (data.name.toLowerCase().contains(query)) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                      radius: 35,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        (MaterialPageRoute(builder: (ctx) {
                          return ViewPage(studentdatas: data, index1: index);
                        })),
                      );
                    },
                    title: Text(
                      data.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteVerification(context, index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
              separatorBuilder: (context, value) {
                return const Divider();
              },
              itemCount:value.newList.length,
            );
          }),
    );
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
                  deleteData(index,context);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }
}
