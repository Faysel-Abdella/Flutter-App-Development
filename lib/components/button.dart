import 'package:flutter/material.dart';

class CustomFreeButton extends StatelessWidget {
  final double height;
  final Color color;
  final Color textColor;
  final String content;
  final EdgeInsets margin;

  const CustomFreeButton({
    Key? key,
    required this.height,
    required this.textColor,
    required this.color,
    required this.content,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        onPressed: () {
          // Handle button press
        },
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
