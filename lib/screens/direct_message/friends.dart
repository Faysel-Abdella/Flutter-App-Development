import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/friend.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset("images/back_arrow.png")),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset("images/start_message.svg")),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF363638),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                child: const Column(
                  children: [
                    Friend(
                        imagePath: "images/friend_one.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: true,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_two.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_three.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: false),
                    Friend(
                        imagePath: "images/friend_one.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: true,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_two.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_three.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: false),
                    Friend(
                        imagePath: "images/friend_one.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: true,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_two.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: true),
                    Friend(
                        imagePath: "images/friend_three.png",
                        name: "대화명",
                        title: "최근 활동 1시간 전",
                        isActive: false,
                        isMuted: false),
                  ],
                ),
              ),
            )),
            Container(
              color: const Color(0xFF242426),
              padding:
                  const EdgeInsets.only(top: 6, bottom: 16, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset("images/lounge_icon.svg"),
                      const Text(
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
                      const Text(
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
      ),
    );
  }
}
