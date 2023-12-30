import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/setting_item.dart';
import 'package:flutter_app_gap/components/setting_item_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingHome extends StatefulWidget {
  const SettingHome({super.key});

  @override
  State<SettingHome> createState() => _SettingHomeState();
}

class _SettingHomeState extends State<SettingHome> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: CustomAppBar(text: "설 정"),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  // A Title
                  CustomHeader(text: "안내"),
                  Column(
                    children: [
                      // Items
                      // Items
                      CustomSettingText(text: "공지사항"),
                      CustomSettingText(text: "자주 묻는 질문"),
                      CustomSettingText(text: "고객센터"),
                      CustomSettingText(text: "서비스 개선 제안하기"),
                      CustomSettingText(text: "입점 및 제휴 문의"),
                    ],
                  ),

                  // ########### //
                  CustomHeader(text: "안내"),
                  Column(
                    children: [
                      // Items
                      // Items
                      CustomSettingText(text: "History"),
                      CustomSettingText(text: "작성중인 갭"),
                      CustomSettingText(text: "차단 사용자 관리"),
                      CustomSettingText(text: "즐겨찾기 라운지"),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFF7C7C80))),
                            color: Color.fromARGB(255, 64, 64, 71),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "공지사항",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Container(
                                width: 26,
                                height: 16,
                                child: Switch(
                                  value: switchValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      switchValue = newValue;
                                    });
                                  },
                                  activeTrackColor: Colors.yellow,
                                  activeColor: Colors.black,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),

                  CustomHeader(text: "안내"),
                  Column(
                    children: [
                      // Items
                      // Items
                      CustomSettingText(text: "공지사항"),
                      CustomSettingText(text: "자주 묻는 질문"),
                      CustomSettingText(text: "고객센터"),
                      CustomSettingText(text: "서비스 개선 제안하기"),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFF7C7C80))),
                            color: Color.fromARGB(255, 64, 64, 71),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "공지사항",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 40),
                                child: Text(
                                  "버전 : 10.11 (111111)",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFAEAEB2)),
                                ),
                              ),
                              Image.asset(
                                "images/small_to_right_icon.png",
                                width: 16,
                                height: 16,
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          )),
          Container(
            padding: EdgeInsets.only(top: 4, bottom: 16, left: 0, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SvgPicture.asset("images/lounge_icon.svg"),
                    Text(
                      "라운지",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFDBFF00)),
                    )
                  ],
                ),
                Image.asset("images/gap_icon.png", width: 50, height: 51),
                Column(
                  children: [
                    SvgPicture.asset("images/search_icon.svg"),
                    Text(
                      "라운지",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFDBFF00)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
