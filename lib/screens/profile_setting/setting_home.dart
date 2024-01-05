import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/components/setting_item.dart';
import 'package:flutter_app_gap/components/setting_item_header.dart';
import 'package:flutter_app_gap/components/show_popup.dart';
import 'package:flutter_app_gap/screens/company_policies/license.dart';
import 'package:flutter_app_gap/screens/company_policies/policies_home.dart';
import 'package:flutter_app_gap/screens/profile_service/profile_service.dart';
import 'package:flutter_app_gap/screens/profile_setting/blocked_users.dart';
import 'package:flutter_app_gap/screens/profile_setting/book_mark.dart';
import 'package:flutter_app_gap/screens/profile_setting/draft.dart';
import 'package:flutter_app_gap/screens/profile_setting/history.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_customer.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_faq.dart';
import 'package:flutter_app_gap/screens/profile_setting/profile_notice.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingHome extends StatefulWidget {
  const SettingHome({super.key});

  @override
  State<SettingHome> createState() => _SettingHomeState();
}

class _SettingHomeState extends State<SettingHome> {
  bool switchValue = true;

  late TextEditingController _emailController;
  late bool _isEmailEmpty = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _isEmailEmpty = true;
  }

  void showProfileRequestBottomSheet(
    BuildContext context,
    String title,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.95),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Color(0xFF363638)),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "취소",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF0099FF)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!_isEmailEmpty) {
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SettingHome(),
                                                ));
                                            CustomPopUp.showPopupText(
                                                context,
                                                " 서비스 개선 제안을 팀갭에 발송했습니다.\n빠른 시일내에 연락드리도록 하겠습니다.",
                                                50,
                                                13);
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          }
                                        },
                                        child: Container(
                                          // padding: EdgeInsets.all(8),
                                          width: 48,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: _isEmailEmpty
                                                ? Color(0xFF7C7C80)
                                                : Color(0xFFDBFF00),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "보내기",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: _isEmailEmpty
                                                        ? Color(0xFFAEAEB2)
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "받는 사람 : ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFAEAEB2)),
                                      ),
                                      Text(
                                        "support@wegab.io",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF0099FF)),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "참조/숨은 참조, 보낸 사람 :",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFAEAEB2)),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 21,
                                          child: TextField(
                                            controller: _emailController,
                                            cursorColor: Color(0xFF0099FF),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 2),
                                              hintText: ' | ',
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF0099FF),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                            onChanged: (value) {
                                              if (value != "") {
                                                setState(() {
                                                  _isEmailEmpty = false;
                                                });
                                              } else {
                                                setState(() {
                                                  _isEmailEmpty = true;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                            text: "제목 : ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFFAEAEB2)),
                                            children: [
                                              TextSpan(
                                                text: "팀캡에 문의/요청/신고 합니다.",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              )
                                            ]),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 21,
                                          child: TextField(
                                            cursorColor: Color(0xFF0099FF),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 0,
                                                  left: 2),
                                              hintText: ' | ',
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF0099FF),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                            onChanged: (value) {},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              )),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "문의 메일일 경우 아래 항목을 삭제하셔도 됩니다.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFAEAEB2)),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text.rich(TextSpan(
                                      text: "대화명 : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: "빛나는_별다",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )
                                      ])),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text.rich(TextSpan(
                                      text: "기기 : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: "iphone 12 pro",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )
                                      ])),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text.rich(TextSpan(
                                      text: "앱 버전 : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: "1.22.0",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )
                                      ])),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text.rich(TextSpan(
                                      text: "OS 버전 : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: "16.6.1",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )
                                      ])),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text.rich(TextSpan(
                                      text: "통신사 : ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                      children: [
                                        TextSpan(
                                          text: "KT",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        )
                                      ])),
                                ],
                              ),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

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
                      CustomSettingText(
                          text: "공지사항",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileNotice(),
                                ));
                          }),
                      CustomSettingText(
                          text: "자주 묻는 질문",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileFAQ(),
                                ));
                          }),
                      CustomSettingText(
                          text: "고객센터",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileCustomerHome(),
                                ));
                          }),
                      CustomSettingText(
                          text: "서비스 개선 제안하기",
                          whenTab: () {
                            showProfileRequestBottomSheet(
                                context, "팀갭에 문의/요청/신고 합니다.");
                          }),
                      CustomSettingText(
                          text: "입점 및 제휴 문의",
                          whenTab: () {
                            showProfileRequestBottomSheet(
                                context, "팀갭에 제휴문의 합니다.");
                          }),
                    ],
                  ),

                  // ########### //
                  CustomHeader(text: "안내"),
                  Column(
                    children: [
                      // Items
                      // Items
                      CustomSettingText(
                          text: "History",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileHistory(),
                                ));
                          }),
                      CustomSettingText(
                          text: "작성중인 갭",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileDraft(),
                                ));
                          }),
                      CustomSettingText(
                          text: "차단 사용자 관리",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlockedUsers(),
                                ));
                          }),
                      CustomSettingText(
                          text: "즐겨찾기 라운지",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserBookMarks(),
                                ));
                          }),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            switchValue = !switchValue;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: double.maxFinite,
                                child: Dialog(
                                  backgroundColor: Colors.black,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "혜택 수신 알림 거부 완료",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "전송자 : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                            children: [
                                              TextSpan(
                                                  text: "위갭",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))
                                            ]),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "수신동의 일자 : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                            children: [
                                              TextSpan(
                                                  text: "YYYY년 MM월 DD일",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))
                                            ]),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            text: "처리내용 : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                            children: [
                                              TextSpan(
                                                  text: "혜택 수신 알림 거부",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        "프로필 > 설정 > 혜택 알림 설정에서 변경할 수 있습니다.",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFDBFF00)),
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: CustomFreeButton(
                                              onTab: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              height: 36,
                                              textColor: Colors.black,
                                              color: Colors.white,
                                              content: "확 인"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xFF7C7C80))),
                              color: Color(0xFF363638),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "혜택 알림 설정",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                Container(
                                  width: 26,
                                  height: 16,
                                  // padding: EdgeInsets.all(40),
                                  child: Transform.scale(
                                    scale: 0.65,
                                    child: Switch(
                                      value: switchValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          switchValue = newValue;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              width: double.maxFinite,
                                              child: Dialog(
                                                backgroundColor: Colors.black,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                      "혜택 수신 알림 거부 완료",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const Divider(
                                                      color: Colors.white,
                                                      thickness: 0.5,
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                          text: "전송자 : ",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                          children: [
                                                            TextSpan(
                                                                text: "위갭",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white))
                                                          ]),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                          text: "수신동의 일자 : ",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "YYYY년 MM월 DD일",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white))
                                                          ]),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                          text: "처리내용 : ",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "혜택 수신 알림 거부",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                        .white))
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                      "프로필 > 설정 > 혜택 알림 설정에서 변경할 수 있습니다.",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFFDBFF00)),
                                                    ),
                                                    const SizedBox(
                                                      height: 24,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: CustomFreeButton(
                                                            onTab: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            height: 36,
                                                            textColor:
                                                                Colors.black,
                                                            color: Colors.white,
                                                            content: "확 인"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      activeTrackColor: Colors.yellow,
                                      activeColor: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      )
                    ],
                  ),

                  CustomHeader(text: "안내"),
                  Column(
                    children: [
                      // Items
                      // Items
                      CustomSettingText(
                          text: "약관 및 정책",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Policies(),
                                ));
                          }),
                      CustomSettingText(
                          text: "오픈소스 라이선스",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Licenses(),
                                ));
                          }),
                      CustomSettingText(
                        text: "로그아웃",
                        whenTab: () {
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
                                            child: Text("로그아웃",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                )),
                                          ),
                                          Center(
                                            child: Text("로그아웃 하시겠습니까?",
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
                                                  width: 0.5,
                                                  color: Colors.black),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 30,
                                                        right: 75,
                                                        top: 11,
                                                        bottom: 11),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            right: BorderSide(
                                                                width: 0.5,
                                                                color: Colors
                                                                    .black))),
                                                    child: Text(
                                                      "취소",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xFF007AFF),
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
                                                        "로그아웃 되었습니다.",
                                                        16,
                                                        16);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 11,
                                                        bottom: 11,
                                                        left: 30,
                                                        right: 20),
                                                    child: Text(
                                                      "로그아웃",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                              0xFF007AFF)),
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
                      ),
                      CustomSettingText(
                          text: "위갭 탈퇴",
                          whenTab: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileService(),
                                ));
                          }),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFF7C7C80))),
                            color: Color(0xFF363638),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "앱 버전 정보",
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
            color: Color(0xFF242426),
            padding: EdgeInsets.only(top: 6, bottom: 16, left: 0, right: 0),
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
