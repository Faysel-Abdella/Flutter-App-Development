import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/button.dart';

class CustomBottomSheet {
  static void showBottomSheet(
      BuildContext context, text1, icon1, icon2, text2, btnTxt,
      [text3, icon3, pickFromGallery]) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: text3 != null ? 300 : 170,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              color: Color(0xFF545456)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon1,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text1,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Image.asset(
                      icon2,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              text3 != null
                  ? Row(
                      children: [
                        Image.asset(icon3!),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(text3!),
                      ],
                    )
                  : const SizedBox.shrink(),
              CustomFreeButton(
                  height: 36,
                  textColor: Color(0xFF242426),
                  color: Color(0xFFDBFF00),
                  content: btnTxt)
            ],
          ),
        );
      },
    );
  }
}
