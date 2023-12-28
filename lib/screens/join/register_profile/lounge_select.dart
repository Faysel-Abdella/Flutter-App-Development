import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandSelect extends StatefulWidget {
  const BrandSelect({super.key});

  @override
  State<BrandSelect> createState() => _BrandSelectState();
}

class _BrandSelectState extends State<BrandSelect> {
  List<bool> _isSelected = List.generate(8, (index) => false);

  final List<String> _imagePaths = [
    'images/brand_1.png',
    'images/brand_2.png',
    'images/brand_3.png',
    'images/brand_4.png',
    'images/brand_5.png',
    'images/brand_6.png',
    'images/brand_7.png',
    'images/brand_8.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF363638),
      appBar: AppBar(
        backgroundColor: const Color(0xFF242426),
        elevation: 0,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          "휴대폰 인증",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 20.5,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
              iconSize: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
          height: MediaQuery.of(context).size.height * .87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("images/next_step.png"),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 18, bottom: 24),
                    child: const Text(
                      "브랜드 라운지를 선택해 주세요.\n라운지는 이동이 자유롭게 가능합니다.",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSelected[i] = !_isSelected[i];
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isSelected[i] = !_isSelected[i];
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      _isSelected[i]
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isSelected[i] =
                                                      !_isSelected[i];
                                                });
                                              },
                                              child: Image.asset(
                                                  "images/radio_button_selected.svg"))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isSelected[i] =
                                                      !_isSelected[i];
                                                });
                                              },
                                              child: Image.asset(
                                                  "images/radio_button_unselected.svg")),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Image.asset(_imagePaths[i])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 4; i < 8; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSelected[i] = !_isSelected[i];
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isSelected[i] = !_isSelected[i];
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      _isSelected[i]
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isSelected[i] =
                                                      !_isSelected[i];
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                  "images/selected.png"))
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isSelected[i] =
                                                      !_isSelected[i];
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                  "images/un_selected.png")),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Image.asset(_imagePaths[i])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                // margin: const EdgeInsets.only(top: 118),
                height: 36,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: _isSelected.any((isSelected) => isSelected)
                        ? MaterialStateProperty.all<Color>(
                            const Color(0xFFDBFF00))
                        : MaterialStateProperty.all<Color>(
                            const Color(0xFFAEAEB2)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Text(
                    "선택완료",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF242426),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
