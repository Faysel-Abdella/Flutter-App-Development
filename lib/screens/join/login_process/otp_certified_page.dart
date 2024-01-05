import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter_app_gap/screens/join/register_profile/name_register.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF363638),
        appBar: AppBar(
          backgroundColor: const Color(0xFF242426),
          elevation: 0,
          toolbarHeight: 64,
          centerTitle: true,
          title: const Text(
            "휴대폰 인증",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 20.5,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                iconSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 28),
                const Text(
                  "본인 확인을 위해 휴대폰 본호를 입력해 주세요.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "최초 1회 휴대폰 인증을 진행합니다. 휴대폰 인증 시 수집된 개인정보는 서비스 이외 다른 용도로 사용되지 않습니다.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text(
                          "01026713846",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        // height: 34,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFAEAEB2)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 18.0)),
                          ),
                          child: Container(
                            child: const Text(
                              "번호변경",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF242426),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "코드",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0066FF),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // The OPT input field

                OtpTextField(
                  numberOfFields: 5,
                  borderColor: const Color(0xFF7C7C80),
                  enabledBorderColor: const Color(0xFF7C7C80),
                  focusedBorderColor: Colors.blueAccent,
                  autoFocus: true,

                  borderRadius: BorderRadius.circular(12),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.white,
                  fieldWidth: 50,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    if (verificationCode == "00000" ||
                        verificationCode == "11111") {
                      if (verificationCode == "00000") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.only(top: 5, bottom: 16),
                              backgroundColor: Colors
                                  .black, // Set the background color to black
                              titlePadding: const EdgeInsets.only(top: 6),
                              title: const Text(
                                "인증코드를\n다시 확인해 주세요.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 0.5,
                                  ),
                                  const Text(
                                    "올바르지 않은 인증코드입니다.\n인증코드를 다시 확인바랍니다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: const CustomFreeButton(
                                        height: 36,
                                        textColor: Colors.black,
                                        color: Colors.white,
                                        content: "확 인"),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }

                      //  Check if the code is expired
                      // 코드가 만료되었는지 확인하세요.

                      if (verificationCode == "11111") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              contentPadding:
                                  const EdgeInsets.only(top: 5, bottom: 16),
                              backgroundColor: Colors
                                  .black, // Set the background color to black
                              titlePadding: const EdgeInsets.only(top: 12),

                              title: const Text(
                                "인증코드 제한",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 0.5,
                                  ),
                                  const Text(
                                    "5회 이상의 인증요청으로 인하여\n인증번호 요청이 비활성화\n되었습니다.\n핸드폰번호 확인 및\n1시간 뒤 다시 진행바랍니다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: const CustomFreeButton(
                                        height: 36,
                                        textColor: Colors.black,
                                        color: Colors.white,
                                        content: "확 인"),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      // If the OTP code is correct go to the next screen
                      // OTP 코드가 맞다면 다음 화면으로 이동
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NameRegisterPage(),
                          ));
                    }
                  }, // end onSubmit
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: 36,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF363638)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(color: Color(0xFF7C7C80)),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                    child: const Text(
                      "다시 전송 02:59",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
