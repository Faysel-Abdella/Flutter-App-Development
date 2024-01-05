import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/components/show_popup.dart';
import 'package:flutter_app_gap/screens/profile_setting/setting_home.dart';

class ProfileCustomerHome extends StatefulWidget {
  const ProfileCustomerHome({super.key});

  @override
  State<ProfileCustomerHome> createState() => _ProfileCustomerHomeState();
}

class _ProfileCustomerHomeState extends State<ProfileCustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "고객센터"),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 14),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                "무엇을 도와드릴까요?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "고객센터 운영시간",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "평일 10:00 ~ 17:00 (점심시간 12:00 ~ 13:00)",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFAEAEB2)),
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                child: CustomFreeButton(
                    onTab: () {
                      // showProfileRequestBottomSheet(context);
                    },
                    height: 36,
                    textColor: Color(0xFF242426),
                    color: Color(0xFFFFE500),
                    content: "카카오톡으로 문의하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
