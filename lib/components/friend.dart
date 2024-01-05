import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Friend extends StatelessWidget {
  final String imagePath;
  final String name;
  final String title;
  final bool isActive;
  final bool isMuted;
  const Friend(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.title,
      required this.isActive,
      required this.isMuted});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF363638),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    isActive
                        ? Stack(children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21.0),
                                border: Border.all(
                                  color: const Color(0xFFDBFF00),
                                  width: 2.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
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
                                  height: 15,
                                  width: 15,
                                ))
                          ])
                        : Container(
                            width: 48,
                            height: 48,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFAEAEB2)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            isMuted
                                ? SvgPicture.asset(
                                    "images/icon_alarm.svg",
                                    width: 16,
                                    height: 16,
                                  )
                                : SizedBox(
                                    height: 0,
                                  )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Image.asset(
                  "images/dots.png",
                  // color: Colors.white,
                  height: 24,
                  width: 24,
                )
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Color(0xFF242426),
          )
        ],
      ),
    );
  }
}
