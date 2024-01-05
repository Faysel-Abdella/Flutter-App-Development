import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_app_gap/components/blocked_user.dart';
import 'package:flutter_app_gap/components/blocked_users.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({super.key});

  @override
  State<BlockedUsers> createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  bool isBlockedUserExist = true;

  @override
  void initState() {
    super.initState();
    isBlockedUserExist = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "차단 사용자 관리"),
      body: Column(
        children: [
          SizedBox(
            height: 27.5,
          ),
          Center(
            child: Text("사용자 차단 시, 서로의 갭,댓글,다이렉트 메시지 받기가 불가능합니다.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF0089))),
          ),
          Center(
            child: Text("사용자에게는 차단했다는 정보를 알리지 않습니다.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF0089))),
          ),
          isBlockedUserExist
              ? SizedBox(
                  height: 27,
                )
              : SizedBox(
                  height: 0,
                ),
          isBlockedUserExist
              ? BlockUsersList()
              : Container(
                  padding: EdgeInsets.only(top: 180),
                  child: Center(
                    child: Text(
                      "차단하고 있는 사용자가 없습니다.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),

          // Conditionally show
        ],
      ),
    );
  }
}
