import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/button.dart';

class NoDraft extends StatelessWidget {
  const NoDraft({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "작성중인 갭이 없습니다.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 24,
            ),
            CustomFreeButton(
                height: 36,
                textColor: Colors.black,
                color: Color(0xFFDBFF00),
                content: "+ 갭 작성")
          ],
        ),
      ),
    );
  }
}
