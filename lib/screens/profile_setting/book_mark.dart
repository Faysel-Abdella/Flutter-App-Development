import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/book_marks.dart';

class UserBookMarks extends StatefulWidget {
  const UserBookMarks({super.key});

  @override
  State<UserBookMarks> createState() => UserBookMarksState();
}

class UserBookMarksState extends State<UserBookMarks> {
  bool isBookMarkExist = true;

  @override
  void initState() {
    super.initState();
    isBookMarkExist = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "즐겨찾기 라운지"),
      body: isBookMarkExist
          ? BookMarkets()
          : Column(
              children: [
                SizedBox(
                  height: 180,
                ),
                Center(
                  child: Text("즐겨찾기한 라운지가 없습니다.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              ],
            ),
    );
  }
}
