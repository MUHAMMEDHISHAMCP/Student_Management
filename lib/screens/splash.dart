import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_database/screens/home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);


 // @override
  // void initState() {
  //   Timer(
  //       const Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) =>  HomeScreen())));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((ws){
  Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  HomeScreen())));
 //   });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Center(
          child: ListView(children: [
            const Image(
              image: AssetImage(
                'assets/stnsd.png',
              ),
              width: 200,
              height: 200,
            ),
            Lottie.asset(
              'assets/laoding.json',
              width: 100,
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }
}
