import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String text;

  const CustomHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xFF242426))),
        color: Color(0xFF444446),
      ),
      padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    ));
  }
}
