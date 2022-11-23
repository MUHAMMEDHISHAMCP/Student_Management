import 'package:flutter/material.dart';
import 'package:hive_database/provider/add_provider.dart';
import 'package:hive_database/screens/add.dart';
import 'package:hive_database/screens/mainscreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // int selectedIndex = 0;
  final screens = [
    const MainSreen(),
     AddScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SampleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: (Colors.black),
          unselectedItemColor: (Colors.white),
          backgroundColor: Colors.blue.shade400,
          iconSize: 30,
          currentIndex: provider.currentIndex,
          onTap: (newIndex) {
             provider.currentIndex = newIndex;
             provider.newImage ='';
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.blueAccent,
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
              backgroundColor: Colors.black,
            )
          ]),

    );
  }
}
