import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/button.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({super.key});

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
              "히스토리가 없습니다.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "갭을 작성하여 자신만의 히스토리를 만드세요.",
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
