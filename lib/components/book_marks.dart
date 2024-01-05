import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookMarkets extends StatefulWidget {
  const BookMarkets({Key? key}) : super(key: key);

  @override
  State<BookMarkets> createState() => _BookMarketsState();
}

class Books {
  late String name;
  late String imagePath;
  late String? tag;

  Books(this.imagePath, this.name, {this.tag});
}

class _BookMarketsState extends State<BookMarkets> {
  List<bool> _isSelected = List.generate(10, (index) => false);

  List<Books> books = [
    Books("images/brand_one.png", "@고아웃", tag: "#캠핑"),
    Books("images/brand_two.png", "@고아웃", tag: "#캠핑"),
    Books("images/brand_three.png", "@고아웃", tag: "#캠핑"),
    Books("images/brand_four.png", "@고아웃"),
    Books("images/brand_five.png", "@고아웃"),
    Books("images/brand_six.png", "@고아웃"),
    Books("images/brand_seven.png", "@고아웃", tag: "#캠핑"),
    Books("images/brand_two.png", "@고아웃"),
    Books("images/brand_two.png", "@고아웃"),
    Books("images/brand_six.png", "@고아웃"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 10; i++)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected[i] = !_isSelected[i];
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                books[i].imagePath,
                                width: 54,
                                height: 24,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              books[i].name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            if (books[i].tag != null)
                              Text(
                                books[i].tag!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFDBFF00)),
                              ),
                          ],
                        ),
                        _isSelected[i]
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSelected[i] = !_isSelected[i];
                                  });
                                },
                                child: SvgPicture.asset("images/favorite.svg"),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSelected[i] = !_isSelected[i];
                                  });
                                },
                                child:
                                    SvgPicture.asset("images/un_favorite.svg"),
                              ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 4,
                  color: Colors.black,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
