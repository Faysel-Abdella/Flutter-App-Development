import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCenteredButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String imagePath;
  final String buttonText;
  final Color textColor;
  final double height;
  final EdgeInsets margin;

  const CustomCenteredButton({
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Container(
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ));
  }
}
