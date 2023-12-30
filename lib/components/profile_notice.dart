import 'package:flutter/material.dart';

class ProfileNoticeItem extends StatelessWidget {
  final String notification;
  final String title;
  final String description;
  final String date;
  final bool isThereImage;
  final String? imageURL;

  const ProfileNoticeItem(
      {super.key,
      required this.notification,
      required this.title,
      required this.description,
      required this.date,
      required this.isThereImage,
      this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF242426)))),
      height: 160,
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/small_gap_icon.png",
                      width: 19,
                      height: 19,
                    ),
                    SizedBox(width: 8),
                    Text(
                      notification,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFAEAEB2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          isThereImage
              ? Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      imageURL!,
                      width: 105,
                      height: 128,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
