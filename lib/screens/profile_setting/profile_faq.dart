import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileFAQ extends StatefulWidget {
  const ProfileFAQ({super.key});

  @override
  State<ProfileFAQ> createState() => _ProfileFAQState();
}

class Faq {
  String label;
  String text;
  Faq(
    this.label,
    this.text,
  );
}

class _ProfileFAQState extends State<ProfileFAQ> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  List<Faq> faqs = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _isFocused = false;
    faqs = [
      Faq("A", "질문"),
      Faq("B", "코딩 실력을 어떻게 향상시킬 수 있나요?"),
      Faq("C", "질문"),
      Faq("D", "코딩 실력을 어떻게 향상시킬 수 있나요?"),
      Faq("E",
          "모범 사례를 사용하여 의미론적 노드 코드를 작성하는 방법은 무엇입니까? 이것을 수행하는 가장 좋은 방법은 무엇입니까?"),
      Faq("F", "코딩 실력을 어떻게 향상시킬 수 있나요?"),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
  }

  void _handleFocusChange() {
    print("Focus: ${_focusNode.hasFocus.toString()}");
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void showFaQBottomSheet(
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
                                  "자주 묻는 질문",
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
                            height: 6,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Flexible(
                                child: Text(
                                  "위갭 (WeGab)은 어떻게 이용하나요?",
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
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
                            height: 14,
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
      backgroundColor: Color(0xFF363638),
      appBar: CustomAppBar(text: "자주 묻는 질문"),
      body: Container(
        child: Column(
          children: [
            // Searching bar
            Container(
              padding:
                  EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 16),
              color: Color(0xFF242426),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF444446),
                      ),
                      child: FocusScope(
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {
                              _isFocused = hasFocus;
                              print(_isFocused.toString());
                            });
                          },
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            cursorColor: Colors.white,
                            onTap: () {},
                            decoration: InputDecoration(
                              hintText: '검색어 입력',
                              hintStyle: const TextStyle(
                                  color: Color(0xFFAEAEB2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xFF545456)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: Color(0xFF7545456)),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "images/search_icon.svg",
                                  color: Colors.white,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 2,
                                // horizontal: 16,
                              ),
                            ),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  _isFocused
                      ? Container(
                          margin: EdgeInsets.only(left: 8),
                          child: GestureDetector(
                            onTap: () {
                              _focusNode.unfocus();
                            },
                            child: Text(
                              "취소",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),

            // Items
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showFaQBottomSheet(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xFF7C7C80)))),
                      child: Row(
                        children: [
                          Text(
                            faqs[index].label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Flexible(
                            child: Text(
                              faqs[index].text,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
