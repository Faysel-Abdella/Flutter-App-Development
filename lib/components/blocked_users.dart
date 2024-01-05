import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/blocked_user.dart';

class BlockUsersList extends StatefulWidget {
  const BlockUsersList({Key? key}) : super(key: key);

  @override
  State<BlockUsersList> createState() => _BlockUsersListState();
}

class BlockedUsersList {
  late String name;
  late String imagePath;
  late bool isActive;

  BlockedUsersList(
    this.imagePath,
    this.isActive,
    this.name,
  );
}

class _BlockUsersListState extends State<BlockUsersList> {
  List<BlockedUsersList> users = [
    BlockedUsersList("images/profile_image.jpg", true, "새콤달콤해"),
    BlockedUsersList("images/notice_image_one.png", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", true, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", true, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", false, "새콤달콤해"),
    BlockedUsersList("images/profile_image.jpg", true, "새콤달콤해"),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context, index) {
          return OneBlockedUser(
            imagePath: users[index].imagePath,
            name: users[index].name,
            isActive: users[index].isActive,
          );
        },
      ),
    );
  }
}
