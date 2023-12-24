import 'package:flutter/material.dart';
import 'package:flutter_app_gap/screens/intrance/allow_access.dart';
import 'package:flutter_app_gap/screens/intrance/first_onboard.dart';
import 'package:flutter_app_gap/screens/intrance/splash.dart';
import 'package:flutter_app_gap/screens/login_process/cell_certified.dart';
import 'package:flutter_app_gap/screens/login_process/login.dart';
import 'package:flutter_app_gap/screens/login_process/otp_certified_page.dart';
import 'package:flutter_app_gap/screens/register_profile/lounge_select.dart';
import 'package:flutter_app_gap/screens/register_profile/name_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
