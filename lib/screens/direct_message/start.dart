import 'package:flutter/material.dart';
import 'package:flutter_app_gap/components/cetnered_button.dart';

class MessagePageEntrance extends StatefulWidget {
  const MessagePageEntrance({Key? key}) : super(key: key);

  @override
  State<MessagePageEntrance> createState() => _MessagePageEntranceState();
}

class UserData {
  String name;
  String imagePath;
  List<String> brands;

  UserData(this.name, this.imagePath, this.brands);
}

class _MessagePageEntranceState extends State<MessagePageEntrance> {
  late TextEditingController _nameController;
  late bool _isNameExist;
  late bool _inputIsEmpty;
  late bool _showProfile;
  late bool _isProfileSelected;
  late bool _isButtonNotYellow;

  late bool _isKeyboardOpen;

  List<UserData> users = [
    UserData("대화명", "images/profile_image.jpg",
        ["images/brand_1.png", "images/supreme.jpg", "images/brand_09.jpg"])
  ];

  FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _inputIsEmpty = true;
    _isNameExist = false;
    _showProfile = false;
    _isProfileSelected = false;
    _isButtonNotYellow = true;

    _isKeyboardOpen = true;

    _textFieldFocusNode.addListener(_onTextFieldFocusChange);
  }

  void _onTextFieldFocusChange() {
    if (_textFieldFocusNode.hasFocus) {
      // TextField is in focus
      _isKeyboardOpen = true;
    } else {
      // TextField lost focus
      _isKeyboardOpen = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }

  void _checkNameExist() {
    String searchingName = _nameController.text;
    if (searchingName == "gap") {
      // It is the condition where the inserted name is correct and there exist a user with this name
      setState(() {
        _isNameExist = true;
        _isButtonNotYellow = true;
        _inputIsEmpty = false;
      });

      if (searchingName == "gap") {
        setState(() {
          _showProfile = true;
        });
      }
    } else {
      if (searchingName != "") {
        setState(() {
          _isNameExist = false;
          _showProfile = false;
          _isButtonNotYellow = false;
          _inputIsEmpty = false;
        });
        // Perform actions for correct input
      }
    }

    if (searchingName == "") {
      setState(() {
        _inputIsEmpty = true;
        _isButtonNotYellow = true;
        _showProfile = false;
      });
    }
  }

  void showBottomSheet2(
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
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                padding: const EdgeInsets.all(20),
                // height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                    color: Color(0xFF545456)),
                child: Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: _isKeyboardOpen
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 36),
                                Expanded(
                                  child: Text(
                                    "새로운 다이렉트 메시지",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8, left: 8, bottom: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "To : ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                _isProfileSelected
                                    ? Container(
                                        height: 32,
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(left: 8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0099FF),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.asset(
                                                  users[0].imagePath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              "말랑한 우동",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Expanded(
                                        child: SizedBox(
                                          height: 25,
                                          child: TextFormField(
                                            controller: _nameController,
                                            focusNode: _textFieldFocusNode,
                                            autofocus: true,
                                            cursorColor: Colors.white,
                                            autocorrect: false,

                                            decoration: const InputDecoration(
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                            ),

                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                            // textAlign: TextAlign.center,
                                            onChanged: (value) {
                                              setState(() {
                                                // set current index!
                                                _checkNameExist();
                                              });
                                            },
                                            onTap: () {},
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (!_inputIsEmpty && !_isNameExist) {
                                return const Text(
                                  // "No users found.",
                                  "검색된 사용자가 없습니다.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                // Here you return the user profile if the user is found
                                // or return the "search by nickname"
                                if (_showProfile && !_isProfileSelected) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isProfileSelected = true;
                                      });
                                    },
                                    child: Container(
                                      height: 51,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(children: [
                                            Container(
                                              width: 48,
                                              height: 49,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color: Color(0xFFDBFF00),
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                child: Image.asset(
                                                  users[0].imagePath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Image.asset(
                                                    "images/profile_emoji.png"))
                                          ]),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                child: Text(
                                                  users[0].name,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    child: Image.asset(
                                                      users[0].brands[0],
                                                      width: 37.333,
                                                      height: 16,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    child: Image.asset(
                                                      users[0].brands[1],
                                                      width: 37.333,
                                                      height: 16,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    child: Image.asset(
                                                      users[0].brands[2],
                                                      width: 37.333,
                                                      height: 16,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return _isProfileSelected
                                      ? const SizedBox(
                                          height: 1,
                                        )
                                      : const Text(
                                          // "search by nickname",
                                          "대화명으로 검색해 주세요",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        );
                                }
                              }
                            },
                          ),
                        ],
                      ),

                      if (_isKeyboardOpen) const SizedBox(height: 200),
                      // The button

                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: _isProfileSelected
                                ? MaterialStateProperty.all<Color>(
                                    const Color(0xFFDBFF00))
                                : MaterialStateProperty.all<Color>(
                                    const Color(0xFF7C7C80)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Container(
                            // margin: margin,
                            height: 36,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/send_message.png",
                                  width: 24,
                                  height: 24,
                                  color: _isProfileSelected
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  child: Text(
                                    "메시지 보내기",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: _isProfileSelected
                                            ? Colors.black
                                            : Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
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
      backgroundColor: const Color(0xFF363638),
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
          padding: EdgeInsets.only(left: 18),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset("images/back_arrow.png")),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset("images/start_message.png")),
          ),
        ],
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "대화 내역이 없습니다.\n각 라운지에서 활발히 활동하고 있는\n갭(회원)들과 임낵을 쌓아보세요.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "🤩",
                  style: TextStyle(fontSize: 34),
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomCenteredButton(
                    onPressed: () {
                      showBottomSheet2(context);
                      setState(() {
                        _isProfileSelected = false;
                      });
                    },
                    color: Color(0xFFDBFF00),
                    imagePath: "images/send_message.png",
                    buttonText: "메시지 보내기",
                    textColor: Colors.black,
                    height: 36),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
