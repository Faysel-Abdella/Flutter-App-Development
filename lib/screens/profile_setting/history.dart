import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/drop_and_search.dart';
import 'package:flutter_app_gap/components/feed.dart';
import 'package:flutter_app_gap/components/no_history.dart';

class ProfileHistory extends StatefulWidget {
  const ProfileHistory({super.key});

  @override
  State<ProfileHistory> createState() => _ProfileHistoryState();
}

class _ProfileHistoryState extends State<ProfileHistory> {
  bool hasHistory = false;

  @override
  void initState() {
    super.initState();
    hasHistory = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF363638),
        appBar: const CustomAppBar(text: "History"),
        body: !hasHistory
            ? const NoHistory()
            : const Column(
                children: [
                  DropAndSearchBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Feed(
                              title:
                                  "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱ ㄱ",
                              description:
                                  "올해 중간에 비가와서 쬐끔 힘들었지만 비 온뒤에 날씨가 끝내줘서 밤에 별들을 볼수 있어 너무 좋아음. 장비를 너무 쓸데없이 많이 가져가서 올해는 좀 정리를 해가야겠다.",
                              isImage: false,
                              likes: "145",
                              dislikes: "12",
                              comments: "34",
                              views: "3232"),
                          Feed(
                              title:
                                  "올해 고아웃 캠핑 너무 좋았어요~ 행사도 다양하고 사람들도 많이 만나고 내년도 좋은 추억 만들고 싶네요~ 예약 ㄱ ㄱ",
                              description: "",
                              isImage: true,
                              imagePath: "images/feed_image.png",
                              likes: "222",
                              dislikes: "3",
                              comments: "315",
                              views: "9232")
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
