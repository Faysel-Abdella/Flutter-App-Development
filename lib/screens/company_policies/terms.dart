import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "이용약관"),
    );
  }
}
