import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/screens/join/login_process/login.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllowAccessPage extends StatefulWidget {
  const AllowAccessPage({Key? key}) : super(key: key);

  @override
  State<AllowAccessPage> createState() => _AllowAccessPageState();
}

class _AllowAccessPageState extends State<AllowAccessPage> {
  @override
  Widget build(BuildContext context) {
    onTabFun() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }

    return Scaffold(
      backgroundColor: Color(0xFF242426),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
            ),
            child: Column(
              children: [
                // SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 36, right: 36, top: 129),
                  child: Text(
                    "We gab(위갭)은 서비스 이용 시점에 꼭 필요한 권한만 받아요.",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 20),
                  height: 1.5,
                  width: double.infinity,
                  color: const Color(0xFF545456),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "선택 접근 허용",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C7C80),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SvgPicture.asset(
                            'images/file_symbol.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6.5),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "저장",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    height: 1),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "서비스 이용시의 필요한 사진 및 파일 저장",
                                style: TextStyle(
                                    color: Color(0xFFAEAEB2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C7C80),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SvgPicture.asset(
                            'images/camera_symbol.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6.5),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "카메라",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "프로필, 갭 작성 및 다이렉트 메시지등의\n이미지 등록 기능 제공",
                                style: TextStyle(
                                    color: Color(0xFFAEAEB2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C7C80),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SvgPicture.asset(
                            'images/image_symbol.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6.5),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "사진",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "프로필, 갭 작성 및 다이렉트 메시지등의\n이미지 등록 기능 제공",
                                style: TextStyle(
                                    color: Color(0xFFAEAEB2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C7C80),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SvgPicture.asset(
                            'images/notification_symbol.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6.5),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "알림",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "서비스 중요 알림, 갭 답글, 주간 베스트 및\n다이렉트 메시지 알림 기능 제공",
                                style: TextStyle(
                                    color: Color(0xFFAEAEB2),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 20),
                  height: 1.5,
                  width: double.infinity,
                  color: const Color(0xFF545456),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            width: 10,
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(right: 20),
                            child: const Text(
                              '\u2022', // Bullet (dot) character
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              '위 접근 권한은 더 나은 서비스 제공을 위해 사용되며 다른 목적으로 활용되지 않습니다.',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10), // Space between the two texts
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Container(
                            width: 10,
                            alignment: Alignment.center,
                            child: const Text(
                              '\u2022', // Bullet (dot) character
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 7),
                            child: const Text(
                              '대폰 > 설정 > 위갭 > 접근 허용 메뉴에서 설정 변경 가능합니다.',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                CustomFreeButton(
                    onTab: onTabFun,
                    margin: EdgeInsets.only(top: 32),
                    height: 36.0,
                    textColor: Colors.black,
                    color: Color(0xFFDBFF00),
                    content: "다음"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
