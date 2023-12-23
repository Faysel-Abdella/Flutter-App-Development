import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_gap/components/iconed_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF242426),
              Color(0xFF001F00),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 129),
                child: Text(
                  "빠르고 간편하게 위갭 서비스를 이용해 보세요",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  CustomIconedButton(
                    onPressed: () {},
                    color: const Color(0xFFFAE100),
                    imagePath: "images/talk_symbol.png",
                    buttonText: "카카오로 시작하기",
                    textColor: Colors.black,
                    height: 36,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomIconedButton(
                    onPressed: () {},
                    color: const Color(0xFF5ACB15),
                    imagePath: "images/n_symbol.png",
                    buttonText: "네이버로 시작하기",
                    textColor: const Color(0xFF242426),
                    height: 36,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomIconedButton(
                    onPressed: () {},
                    color: const Color(0xFF363638),
                    imagePath: "images/apple_symbol.png",
                    buttonText: "Apple로 시작하기",
                    textColor: Colors.white,
                    height: 36,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomIconedButton(
                    onPressed: () {},
                    color: Colors.white,
                    imagePath: "images/google_symbol.png",
                    buttonText: "구글로 시작하기",
                    textColor: Colors.black,
                    height: 36,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 120),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              text: '가입을 진행할 경우, ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFAEAEB2),
                              ),
                              children: [
                                TextSpan(
                                  text: '이용약관',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: ' 및 \n',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFAEAEB2),
                                  ),
                                ),
                                TextSpan(
                                  text: '개인정보 처리방침',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                TextSpan(
                                  text: '에 동의하는 것으로 간주됩니다.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFAEAEB2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
