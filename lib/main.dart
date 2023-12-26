import 'package:flutter/material.dart';
import 'package:flutter_app_gap/screens/direct_message/chat_room.dart';
import 'package:flutter_app_gap/screens/direct_message/start.dart';
import 'package:flutter_app_gap/screens/join/entrance/allow_access.dart';
import 'package:flutter_app_gap/screens/join/entrance/first_onboard.dart';
import 'package:flutter_app_gap/screens/join/entrance/splash.dart';
import 'package:flutter_app_gap/screens/join/login_process/cell_certified.dart';
import 'package:flutter_app_gap/screens/join/login_process/login.dart';
import 'package:flutter_app_gap/screens/join/login_process/otp_certified_page.dart';
import 'package:flutter_app_gap/screens/join/register_profile/lounge_select.dart';
import 'package:flutter_app_gap/screens/join/register_profile/name_register.dart';

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
      home: const ChatRoom(),
    );
  }
}
