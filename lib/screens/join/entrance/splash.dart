import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_gap/screens/join/entrance/first_onboard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const FirstOnBoardPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 7, 1),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Image at the center
          Positioned.fill(
            child: Image.asset(
              'images/splash_symbol.png',
              // fit: BoxFit.contain,
              width: 75.76,
              height: 75.76,
            ),
          ),
          // Text at the center bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 28.0),
              child: const Text(
                "버전정보 v. 1.0.1",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
