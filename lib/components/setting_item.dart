import 'package:flutter/material.dart';

class CustomSettingText extends StatelessWidget {
  final String text;

  const CustomSettingText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFF7C7C80))),
          color: Color.fromARGB(255, 64, 64, 71),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "공지사항",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Image.asset(
              "images/small_to_right_icon.png",
              width: 16,
              height: 16,
            )
          ],
        ));
  }
}
