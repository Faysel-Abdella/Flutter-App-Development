import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/cetnered_button.dart';

class MessagePageEntrance extends StatefulWidget {
  const MessagePageEntrance({super.key});

  @override
  State<MessagePageEntrance> createState() => _MessagePageEntranceState();
}

class _MessagePageEntranceState extends State<MessagePageEntrance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: AppBar(
        backgroundColor: const Color(0xFF242426),
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          "다이렉트 메시지",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 20.5,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset("images/back_arrow.png")),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset("images/start_message.png")),
          ),
        ],
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "대화 내역이 없습니다.\n각 라운지에서 활발히 활동하고 있는\n갭(회원)들과 임낵을 쌓아보세요.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "🤩",
                  style: TextStyle(fontSize: 34),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomCenteredButton(
                    onPressed: () {},
                    color: Color(0xFFDBFF00),
                    imagePath: "images/send_message.png",
                    buttonText: "메시지 보내기",
                    textColor: Colors.black,
                    height: 36),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
