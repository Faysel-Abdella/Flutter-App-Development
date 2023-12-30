import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String imagePath;
  final String buttonText;
  final Color textColor;
  final double height;
  final EdgeInsets margin;

  const CustomIconedButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.imagePath,
    required this.buttonText,
    required this.textColor,
    required this.height,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        child: Container(
          margin: margin,
          height: height,
          width: double.infinity,
          child: Row(
            children: [
              SvgPicture.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ));
  }
}
