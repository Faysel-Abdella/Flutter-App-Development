import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/button.dart';

class ProfileCustomerHome extends StatefulWidget {
  const ProfileCustomerHome({super.key});

  @override
  State<ProfileCustomerHome> createState() => _ProfileCustomerHomeState();
}

class _ProfileCustomerHomeState extends State<ProfileCustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: const CustomAppBar(text: "고객센터"),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text(
                "무엇을 도와드릴까요?",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "고객센터 운영시간",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "평일 10:00 ~ 17:00 (점심시간 12:00 ~ 13:00)",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFAEAEB2)),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                child: CustomFreeButton(
                    onTab: () {
                      // showProfileRequestBottomSheet(context);
                    },
                    height: 36,
                    textColor: const Color(0xFF242426),
                    color: const Color(0xFFFFE500),
                    content: "카카오톡으로 문의하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
