import 'package:flutter/material.dart';

class CustomFreeButton extends StatefulWidget {
  final double height;
  final Color color;
  final Color textColor;
  final onTab;
  final String content;
  final EdgeInsets margin;

  const CustomFreeButton({
    Key? key,
    this.onTab,
    required this.height,
    required this.textColor,
    required this.color,
    required this.content,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<CustomFreeButton> createState() => _CustomFreeButtonState();
}

class _CustomFreeButtonState extends State<CustomFreeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        onPressed: () {
          widget.onTab!();
          // Handle button press
        },
        child: Text(
          widget.content,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
