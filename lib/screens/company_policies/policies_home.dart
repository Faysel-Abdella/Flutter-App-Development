import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/setting_item.dart';
import 'package:flutter_app_gap/screens/company_policies/information.dart';
import 'package:flutter_app_gap/screens/company_policies/terms.dart';

class Policies extends StatefulWidget {
  const Policies({super.key});

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "약관 및 정책"),
      body: Column(children: [
        CustomSettingText(
            text: "이용약관",
            whenTab: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Terms(),
                  ));
            }),
        CustomSettingText(
            text: "개인정보처리방침",
            whenTab: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Policy(),
                  ));
            })
      ]),
    );
  }
}
