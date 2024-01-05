import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPopUp {
  static void showPopupText(
      BuildContext context, String text, double marginBottom, double fontSize) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return Align(
          alignment: Alignment.bottomCenter,
          child: Expanded(
            child: Container(
              height: 72,
              width: MediaQuery.of(context).size.width - 50,
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 0),
              margin: EdgeInsets.only(bottom: marginBottom),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/popup_emoji.png",
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            text,
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
