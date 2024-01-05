import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/show_popup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Draft extends StatelessWidget {
  final String text;

  const Draft({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Image.asset(
                      "images/brand_three.png",
                      width: 56,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "@나이키",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "#조던",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFDBFF00)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "24분 전",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Builder(builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              contentPadding: EdgeInsets.zero,
                              buttonPadding: EdgeInsets.zero,
                              insetPadding: EdgeInsets.zero,
                              actionsPadding: EdgeInsets.zero,
                              iconPadding: EdgeInsets.zero,
                              titlePadding: EdgeInsets.zero,
                              content: Container(
                                width: 270,
                                height: 136,
                                child: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Center(
                                        child: Text("작성중인 갭 삭제",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            )),
                                      ),
                                      Center(
                                        child: Text("작성중인 갭을 삭제하시겠습니까?",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        width: 270,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.black),
                                        )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Perform delete operation
                                                Navigator.pop(context);
                                                CustomPopUp.showPopupText(
                                                    context,
                                                    "작성중인 갭이 삭제되었습니다.",
                                                    16,
                                                    16);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 11,
                                                    bottom: 11,
                                                    left: 30,
                                                    right: 40),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 0.5,
                                                            color:
                                                                Colors.black))),
                                                child: Text(
                                                  "삭제하기",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xFF007AFF)),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 0,
                                                    right: 60,
                                                    top: 11,
                                                    bottom: 11),
                                                child: Text(
                                                  "취소",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF007AFF),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      "images/icon_delete.svg",
                      width: 16,
                      height: 16,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Divider(
          thickness: 4,
          color: Color(0xFF242426),
        )
      ],
    );
  }
}
