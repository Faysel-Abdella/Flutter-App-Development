import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DropAndSearchBar extends StatelessWidget {
  const DropAndSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "최신순",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SvgPicture.asset("images/icon_drop.svg")
                ],
              ),
              SvgPicture.asset(
                "images/search_icon.svg",
                width: 24,
                height: 24,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
