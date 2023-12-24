import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/button.dart';
import 'package:get/get.dart';

class CellCertifiedPage extends StatefulWidget {
  const CellCertifiedPage({Key? key}) : super(key: key);

  @override
  State<CellCertifiedPage> createState() => _CellCertifiedPageState();
}

class _CellCertifiedPageState extends State<CellCertifiedPage> {
  late TextEditingController _phoneController;
  RxBool _isNumberIncorrect = false.obs;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();

    // Set the focus on the text field when the screen is shown
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _checkPhoneNumber() {
    String phoneNumber = _phoneController.text;
    // Hi Kim's developer for the below use the actual real data
    // 아래의 김안녕님 개발자는 실제 실제 데이터를 사용합니다.
    if (phoneNumber == "0911223344") {
      // It is the condition where the inserted phone number is not correct or already used
      // 입력한 전화번호가 정확하지 않거나 이미 사용된 전화번호인 경우입니다.
      setState(() {
        _isNumberIncorrect.value = true;
      });
    } else {
      setState(() {
        _isNumberIncorrect.value = false;
      });
      if (phoneNumber.length == 10) {
        setState(() {
          _isNumberIncorrect.value = false;
        });
        // Perform actions for correct input
      }
    }
  }

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
                "본인 확인을 위해 휴대폰 번호를 입력해 주세요.",
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
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _phoneController,
                    focusNode: _focusNode,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    cursorColor: Colors.white,
                    // Hi kim, use the maximum length of the country phone number
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: 'Enter your phone',
                        hintStyle: const TextStyle(color: Color(0xFFAEAEB2)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: _isNumberIncorrect.value
                            ? OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              )
                            : (_phoneController.text.length == 10
                                ? OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.yellow),
                                  )
                                : OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                  )),
                        suffixIcon: _isNumberIncorrect.value
                            ? const Icon(Icons.warning, color: Colors.red)
                            : (_phoneController.text.length == 10
                                ? const Icon(Icons.check_circle,
                                    color: Colors.yellow)
                                : null),
                        filled: true,
                        fillColor: _phoneController.text.isNotEmpty
                            ? const Color(0xFF444446)
                            : Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16)),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    // textAlign: TextAlign.center,
                    onChanged: (value) {
                      _checkPhoneNumber();
                    },
                  ),
                  if (_isNumberIncorrect.value)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Number is incorrect',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
