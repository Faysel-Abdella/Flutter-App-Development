import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/screens/join/entrance/allow_access.dart';

class FirstOnBoardPage extends StatelessWidget {
  const FirstOnBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onTabFun() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllowAccessPage(),
          ));
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 7, 1),
      body: SafeArea(
        child: Container(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Image.asset(
                    'images/onboard.png',
                    width: constraints.maxWidth,
                    height: constraints.maxWidth / 1.1,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 28),
                          const Text(
                            "위젯을 이렇게 사용하세요.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "서비스 이용 과정에서 불편했던 부분을 기재해주시면 서비스 개선에 참고하도록 하겠습니다.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Image.asset('images/icon_slide2.png'),
                          const Spacer(),
                          const SizedBox(height: 16),
                          CustomFreeButton(
                            onTab: onTabFun,
                            height: 36.0,
                            color: Color(0xFFDBFF00),
                            content: "다음",
                            textColor: Color(0xFF242426),
                            margin: EdgeInsets.symmetric(vertical: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
