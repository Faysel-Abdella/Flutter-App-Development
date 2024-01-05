import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';

class Licenses extends StatelessWidget {
  const Licenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "오픈소스 라이선스"),
    );
  }
}
