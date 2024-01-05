import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/show_popup.dart';

class OneBlockedUser extends StatelessWidget {
  final String imagePath;
  final String name;
  final bool isActive;

  const OneBlockedUser(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isActive
                      ? Stack(children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                              border: Border.all(
                                color: const Color(0xFFDBFF00),
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                "images/small_active_badge.png",
                                height: 10,
                                width: 10,
                              ))
                        ])
                      : Container(
                          width: 32,
                          height: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ],
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
                                    child: Text("사용자 차단해제",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                        )),
                                  ),
                                  Center(
                                    child: Text("해당 사용자의 차단을 해제하시겠습니까?",
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
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 30,
                                                right: 65,
                                                top: 11,
                                                bottom: 11),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 0.5,
                                                        color: Colors.black))),
                                            child: Text(
                                              "취소",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF007AFF),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Perform delete operation
                                            Navigator.pop(context);
                                            CustomPopUp.showPopupText(
                                                context,
                                                "슝카_8282님을 차단해제 하였습니다.",
                                                16,
                                                16);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 11,
                                                bottom: 11,
                                                left: 30,
                                                right: 40),
                                            child: Text(
                                              "차단해제",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF007AFF)),
                                            ),
                                          ),
                                        ),
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
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFFFF0089)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    "차단해제",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Color(0xFF242426),
        )
      ],
    );
  }
}
