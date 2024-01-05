import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/profile_notice.dart';

class ProfileNotice extends StatefulWidget {
  const ProfileNotice({Key? key});

  @override
  State<ProfileNotice> createState() => _ProfileNoticeState();
}

class _ProfileNoticeState extends State<ProfileNotice> {
  void showNoticeBottomSheet(
    BuildContext context,
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
              padding: EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Color(0xFF363638)),
              child: Column(
                children: [
                  // One item
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "공지",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Flexible(
                              child: Text(
                                "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "업데이트 : 2023년 11월 10일 15:32",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFAEAEB2)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFF444446),
                          )
                        ],
                      ),
                    ),
                  )
                  // End of one item
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
      appBar: CustomAppBar(text: "공지사항"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showNoticeBottomSheet(context);
              },
              child: ProfileNoticeItem(
                notification: "공지",
                title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                description:
                    "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                date: "2023년 11월 10일",
                isThereImage: true,
                imageURL: "images/notice_image_one.png",
              ),
            ),
            GestureDetector(
              onTap: () {
                showNoticeBottomSheet(context);
              },
              child: ProfileNoticeItem(
                notification: "공지",
                title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                description:
                    "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                date: "2023년 11월 10일",
                isThereImage: false,
              ),
            ),
            GestureDetector(
                onTap: () {
                  showNoticeBottomSheet(context);
                },
                child: ProfileNoticeItem(
                  notification: "공지",
                  title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                  description:
                      "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                  date: "2023년 11월 10일",
                  isThereImage: true,
                  imageURL: "images/notice_image_two.png",
                )),
            GestureDetector(
                onTap: () {
                  showNoticeBottomSheet(context);
                },
                child: ProfileNoticeItem(
                  notification: "공지",
                  title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                  description:
                      "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                  date: "2023년 11월 10일",
                  isThereImage: true,
                  imageURL: "images/notice_image_one.png",
                )),
            GestureDetector(
                onTap: () {
                  showNoticeBottomSheet(context);
                },
                child: ProfileNoticeItem(
                  notification: "공지",
                  title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                  description:
                      "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                  date: "2023년 11월 10일",
                  isThereImage: false,
                )),
            GestureDetector(
                onTap: () {
                  showNoticeBottomSheet(context);
                },
                child: ProfileNoticeItem(
                  notification: "공지",
                  title: "2024년 최고의 화제작이 NETFLIX 라운지에서 공개됩니다.",
                  description:
                      "욕망이 괴물이 되는 세상. 그린홈을 떠나 새로운 터전에서 살아남기 위해 각자의 사투를 벌이는 현수와 그린홈의 생존자들, 그리고 또 다른 존재의 등장과 알 수 없는 미스터리한 현상들까지. 새로운 욕망과 사건, 사투를 그린 넷플릭스 시리즈",
                  date: "2023년 11월 10일",
                  isThereImage: true,
                  imageURL: "images/notice_image_one.png",
                )),
          ],
        ),
      ),
    );
  }
}
