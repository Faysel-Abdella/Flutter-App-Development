import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/profile_notice.dart';

class ProfileNotice extends StatefulWidget {
  const ProfileNotice({Key? key});

  @override
  State<ProfileNotice> createState() => _ProfileNoticeState();
}

class _ProfileNoticeState extends State<ProfileNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: CustomAppBar(text: "공지사항"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: true,
              imageURL: "images/notice_image_one.png",
            ),
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: false,
            ),
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: true,
              imageURL: "images/notice_image_two.png",
            ),
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: true,
              imageURL: "images/notice_image_three.jpeg",
            ),
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: false,
            ),
            ProfileNoticeItem(
              notification: "공지",
              title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
              description:
                  "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
              date: "2023년 11월 10일",
              isThereImage: true,
              imageURL: "images/notice_image_one.png",
            ),
          ],
        ),
      ),
    );
  }
}
