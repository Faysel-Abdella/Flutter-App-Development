import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  final String title;
  final String description;
  final bool isImage;
  final String? imagePath;
  final String likes;
  final String dislikes;
  final String comments;
  final String views;

  const Feed(
      {super.key,
      required this.title,
      required this.description,
      required this.isImage,
      this.imagePath,
      required this.likes,
      required this.dislikes,
      required this.comments,
      required this.views});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Image.asset(
                      "images/brand_three.png",
                      width: 56,
                      height: 24,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "@나이키",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "#조던",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFDBFF00)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "24분 전",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    "images/icon_more.png",
                    width: 16,
                    height: 16,
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        isImage == true
            ? Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Image.asset(imagePath!))
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
        isImage == true
            ? SizedBox(
                height: 0,
              )
            : SizedBox(
                height: 16,
              ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/like.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    likes,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                width: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/dislike.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    dislikes,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                width: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/comments.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    comments,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                width: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "images/view.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    views,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          thickness: 4,
          color: Color(0xFF242426),
        )
      ],
    );
  }
}
