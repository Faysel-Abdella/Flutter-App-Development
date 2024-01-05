import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "개인정보처리방침"),
    );
  }
}
