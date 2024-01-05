import 'package:flutter/material.dart';

class CustomSettingText extends StatelessWidget {
  final String text;
  final VoidCallback? whenTab;

  const CustomSettingText({
    Key? key,
    required this.text,
    this.whenTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whenTab,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Color(0xFF7C7C80))),
          color: Color(0xFF363638),
        ),
        child: GestureDetector(
          onTap: whenTab,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Image.asset(
                "images/small_to_right_icon.png",
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
