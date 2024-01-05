import 'package:flutter/material.dart';
import 'package:flutter_app_gap/screens/company_policies/information.dart';
import 'package:flutter_app_gap/screens/company_policies/license.dart';
import 'package:flutter_app_gap/screens/company_policies/policies_home.dart';
import 'package:flutter_app_gap/screens/company_policies/terms.dart';
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
import 'package:flutter_app_gap/screens/profile_service/profile_service.dart';
import 'package:flutter_app_gap/screens/profile_service/service_check.dart';
import 'package:flutter_app_gap/screens/profile_setting/blocked_users.dart';
import 'package:flutter_app_gap/screens/profile_setting/book_mark.dart';
import 'package:flutter_app_gap/screens/profile_setting/draft.dart';
import 'package:flutter_app_gap/screens/profile_setting/history.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_customer.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_faq.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_notice.dart';
import 'package:flutter_app_gap/screens/profile_setting/setting_home.dart';

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
