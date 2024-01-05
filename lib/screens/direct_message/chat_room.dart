import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_gap/components/show_popup.dart';
import 'package:flutter_app_gap/screens/direct_message/friends.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app_gap/components/button.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class UserData {
  String name;
  String imagePath;
  List<String> brands;

  UserData(this.name, this.imagePath, this.brands);
}

class Conversation {
  int id;
  String role;
  String date;
  String hour;
  String status;
  bool isImage;
  bool isLink;
  String message;

  bool? isReply;
  String? replyTo;
  String? replyText;

  String previewImage;
  String previewTitle;
  String previewText;

  Conversation(
      this.id,
      this.role,
      this.message,
      this.date,
      this.hour,
      this.isImage,
      this.isLink,
      this.status,
      this.isReply,
      this.replyTo,
      this.replyText,
      this.previewImage,
      this.previewTitle,
      this.previewText);
}

class _ChatRoomState extends State<ChatRoom> {
  final FocusNode _focusNode = FocusNode();
  List<UserData> users = [
    UserData("대화명", "images/profile_image.jpg", [
      "images/brand_one.png",
      "images/brand_two.png",
      "images/brand_three.png"
    ])
  ];

  List<Conversation> conversations = [];

  String formatDate(String date) {
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    return '$year년 $month월 $day일 월요일';
  }

  int selectedIndex = -1; // Initially no option is selected
  bool showForm = false;

  List<String> options = [
    "특정인, 특정 집단 비방",
    "폭언, 욕설, 차별, 혐오 발언",
    "광고, 스팸성",
    "음란물 및 성희롱",
    "연애 목적의 대화 시도",
    "기타",
  ];

  late TextEditingController _chatController;
  late TextEditingController _reportController;
  late String replyToText;
  late String latestReplyToText;

  bool _isNotificationTurnOn = false;
  bool _isReasonEmpty = true;
  bool _isEmailEmpty = true;
  bool _isEmailValid = false;

  ScrollController _scrollController = ScrollController();

  String copiedText = '';

  RadioGroupController optionController = RadioGroupController();
  final GlobalKey<RadioGroupState> radioGroupKey1 =
      GlobalKey<RadioGroupState>();
  bool disabled = true;

  final GlobalKey commentsHeaderKey = GlobalKey();

  double commentsHeaderHeight = 0;

  File? _image;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(180,
            duration: const Duration(milliseconds: 50), curve: Curves.ease);
      }
    });

    super.initState();
    _chatController = TextEditingController();
    _reportController = TextEditingController();

    replyToText = "";
    latestReplyToText = "";
    _isNotificationTurnOn = false;
    showForm = false;

    _isReasonEmpty = true;
    _isEmailEmpty = true;
    _isEmailValid = true;
    if (selectedIndex == 5) {
      showForm = true;
    }

    conversations = [
      Conversation(1, "sender", "안녕하세요~", "2016-12-25", "오전 11:24", false,
          false, "success", false, "", "", "", "", ""),
      Conversation(2, "receiver", "안녕하세요*^^* 🤟🏻", "2016-12-25", "오전 11:50",
          false, false, "success", false, "", "", "", "", ""),
      Conversation(3, "sender", "별다방님 다음달 고아웃 가실건가요?", "2016-12-25", "오전 11:55",
          false, false, "success", false, "", "", "", "", ""),
      Conversation(4, "sender", "전 갈려구요 👩🏼‍🌾", "2016-12-25", "오전 12:00",
          false, false, "success", false, "", "", "", "", ""),
      Conversation(
          5,
          "receiver",
          "저도 갈건데 제가 내일 연락 드릴께요. 짐 머 좀 하고 있어서요 ^^",
          "2016-12-25",
          "오전 12:06",
          false,
          false,
          "success",
          false,
          "",
          "",
          "",
          "",
          ""),
      Conversation(6, "receiver", "어제 죄송했어요. 고아웃 담달 가시게요?", "2016-12-26",
          "오전 12:10", false, false, "success", false, "", "", "", "", ""),
      Conversation(7, "sender", "넵!!", "2016-12-26", "오전 04:15", false, false,
          "failed", false, "", "", "", "", ""),
      Conversation(8, "sender", "images/image_message.jpeg", "2016-12-26",
          "오전 06:36", true, false, "success", false, "", "", "", "", ""),
      Conversation(
          9,
          "sender",
          "https://blog.naver.com/bhg202",
          "2023-12-29",
          "오전 04:15",
          false,
          true,
          "success",
          false,
          "",
          "",
          "images/image_preview.png",
          "우리의 최종목적은 함께 재밌게 우리의 최종목적은 함께 재밌게 노는 캠핑이란 말이닷! 👏",
          "고아웃 슈퍼하이킹 1회 후기")
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double currentCommentsHeaderHeight =
          commentsHeaderKey.currentContext?.size?.height ?? 0;
      if (currentCommentsHeaderHeight != commentsHeaderHeight) {
        setState(() {
          commentsHeaderHeight = currentCommentsHeaderHeight;
        });
      }
    });
  }

  @override
  void dispose() {
    _reportController.dispose();
    _reportController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _checkIfInputIsEmpty(value) {
    if (value.length == 0 || value == "") {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void _validateEmail(email) {
    if (email.contains('@')) {
      setState(() {
        _isEmailValid = true;
      });
    } else {
      setState(() {
        _isEmailValid = false;
      });
    }
  }

  void showPopupText(BuildContext context, String text, double marginBottom) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 72,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: marginBottom),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/popup_emoji.png",
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          text,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  void showFirstBottomSheet(
    BuildContext context,
    icon1,
    text1,
    icon2,
    text2,
    icon3,
    text3,
    icon4,
    text4,
    btnTxt,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 248,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              color: Color(0xFF545456)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isNotificationTurnOn = !_isNotificationTurnOn;
                  });
                  Navigator.pop(context);
                  String pupopText =
                      _isNotificationTurnOn ? "알림을 ON 합니다." : "알림을 OFF 합니다.";
                  showPopupText(context, pupopText, 100);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      _isNotificationTurnOn
                          ? icon1
                          : "images/notification_turn_off.svg",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text1,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showBottomSheet2(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon2,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                // onTap: () async => await pickSvgPicture(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon3,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text3,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                // onTap: () async => await pickSvgPicture(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon4,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text4,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFF0089)),
                    ),
                  ],
                ),
              ),
              const SizedBox.shrink(),
              CustomFreeButton(
                  height: 36,
                  textColor: const Color(0xFF242426),
                  color: const Color(0xFFDBFF00),
                  content: btnTxt)
            ],
          ),
        );
      },
    );
  }

  void showImageSendBottomSheet(
    BuildContext context,
    text1,
    icon1,
    icon2,
    text2,
    btnTxt,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 170,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              color: Color(0xFF545456)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async => await pickImageFromCamera(),
                child: Row(
                  children: [
                    Image.asset(
                      icon1,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text1,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async => await pickImage(),
                child: Row(
                  children: [
                    Image.asset(
                      icon2,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text2,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox.shrink(),
              CustomFreeButton(
                  height: 36,
                  textColor: const Color(0xFF242426),
                  color: const Color(0xFFDBFF00),
                  content: btnTxt)
            ],
          ),
        );
      },
    );
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
            controller: _scrollController,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        color: Color(0xFF545456)),
                    child: Container(
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "취소",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                "사용자 신고",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 2,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            color: Color(0xFFD0CBC2),
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "‘말랑한 우동’ 사용자를 신고하는\n이유를 알려주세요.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: options.length,
                              itemExtent: 40,
                              itemBuilder: (context, index) {
                                bool isSelected = (index == selectedIndex);
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    setState(() {
                                      isSelected =
                                          !isSelected; // Toggle isSelected state
                                      if (isSelected) {
                                        selectedIndex = index;
                                        if (selectedIndex == 5) {
                                          showForm = true;
                                        } else {
                                          showForm = false;
                                        }
                                      }
                                    });
                                  },
                                  leading: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: SvgPicture.asset(
                                      (index == selectedIndex)
                                          ? 'images/radio_button_selected.svg'
                                          : 'images/radio_button_unselected.svg',
                                    ),
                                  ),
                                  title: Text(
                                    options[index],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  tileColor: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                );
                              },
                            ),
                          ),

                          // The report form

                          if (showForm)
                            Container(
                              child: Column(children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                const Divider(
                                  color: Color(0xFF444446),
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "신고 사유 (필수)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                InkWell(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    _scrollController.jumpTo(200);
                                  },
                                  child: Container(
                                    height: 176,
                                    child: TextField(
                                      controller: _reportController,
                                      cursorColor: Colors.white,
                                      onTap: () {},
                                      minLines: 10,
                                      scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              16 * 4),
                                      maxLength: 500,
                                      maxLines: null, // Allows multiple lines
                                      textInputAction: TextInputAction
                                          .newline, // Enables newline input
                                      decoration: InputDecoration(
                                        hintText: '신고 내용을 입력해 주세요.',
                                        hintStyle: const TextStyle(
                                            color: Color(0xFFAEAEB2)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF7C7C80)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF7C7C80)),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 16,
                                        ),
                                      ),
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return Text(
                                          '$currentLength / $maxLength',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        );
                                      },

                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),

                                      onChanged: (value) {
                                        setState(() {
                                          if (value == "" || value == " ") {
                                            _isReasonEmpty = true;
                                          } else {
                                            _isReasonEmpty = false;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "사진 첨부 (최대 4장)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                        "images/import_image.svg")),
                                const SizedBox(
                                  height: 24,
                                ),
                                TextField(
                                  onTap: () {},
                                  cursorColor: const Color(0xFF0099FF),
                                  decoration: InputDecoration(
                                    hintText: '이메일 입력',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFFAEAEB2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF7C7C80)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF7C7C80)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 16,
                                    ),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == "" || value == " ") {
                                        _isEmailEmpty = true;
                                      } else {
                                        _isEmailEmpty = false;
                                      }
                                    });
                                    if (value != "" && value != " ") {
                                      _validateEmail(value);
                                    } else {
                                      setState(() {
                                        _isEmailValid = true;
                                      });
                                    }
                                  },
                                ),
                              ]),
                            ),
                          const SizedBox(
                            height: 4,
                          ),
                          !_isEmailValid && selectedIndex == 5
                              ? Container(
                                  height: 12,
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "올바른 이메일 형식이 아닙니다.",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFFF0089)),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 12,
                                ),

                          const SizedBox(
                            height: 28,
                          ),

                          // The report button
                          ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                selectedIndex != -1 && selectedIndex != 5 ||
                                        selectedIndex == 5 &&
                                            !_isReasonEmpty &&
                                            !_isEmailEmpty &&
                                            _isEmailValid
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FriendsList(),
                                        ))
                                    : null;

                                FocusManager.instance.primaryFocus?.unfocus();

                                CustomPopUp.showPopupText(
                                    context,
                                    "신고가 완료되었습니다.\n해당 사용자는 확인 후 조치하겠습니다.",
                                    80,
                                    16);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    selectedIndex != -1 && selectedIndex != 5 ||
                                            selectedIndex == 5 &&
                                                !_isReasonEmpty &&
                                                !_isEmailEmpty &&
                                                _isEmailValid
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
                                height: 36,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 8),
                                    Container(
                                      child: Text(
                                        "신고하기",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: selectedIndex != -1
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
                ],
              ),
            ),
          );
        });
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
        toolbarHeight: 76,
        centerTitle: true,
        title: Container(
          margin: const EdgeInsets.only(left: 5),
          height: 51,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  width: 48,
                  height: 49,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFDBFF00),
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Image.asset(
                      users[0].imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset("images/profile_emoji.png"))
              ]),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Text(
                      users[0].name,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          users[0].brands[0],
                          width: 37.333,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.asset(
                          users[0].brands[1],
                          width: 37.333,
                          height: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
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
        leading: Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset("images/back_arrow.svg")),
        ),
        actions: [
          Container(
            child: GestureDetector(
                onTap: () {
                  showFirstBottomSheet(
                      context,
                      "images/notification.svg",
                      "알림끄기",
                      "images/report.svg",
                      "신고하기",
                      "images/hide.svg",
                      "숨기기",
                      "images/exit_from_message.svg",
                      "다이렉트 메시지 나가기",
                      "닫기");
                },
                child: Container(
                    padding: const EdgeInsets.only(
                      right: 26,
                    ),
                    child: Image.asset("images/three_dots.png"))),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 92),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // The top of the message
                          Stack(children: [
                            Container(
                              width: 97,
                              height: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                border: Border.all(
                                  color: const Color(0xFFDBFF00),
                                  width: 2.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(38.0),
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
                                  "images/profile_emoji_large.png",
                                ))
                          ]),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            users[0].name,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  users[0].brands[0],
                                  height: 24,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  users[0].brands[1],
                                  height: 24,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  users[0].brands[2],
                                  height: 24,
                                  width: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          // The body of the chat
                          conversations.length == 0
                              ? const Text(
                                  "새로운\n대화를 시작하세요.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                )
                              : Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: const Divider(
                                    thickness: 1,
                                    color: Color(0xFF444446),
                                  ),
                                ),

                          // ######## The actual chat section  #########
                          SingleChildScrollView(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              shrinkWrap: true,
                              itemCount: conversations.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final conversation = conversations[index];
                                final DateTime currentDateTime =
                                    DateTime.parse(conversation.date);
                                final DateTime? previousDateTime = index > 0
                                    ? DateTime.parse(
                                        conversations[index - 1].date)
                                    : null;

                                // Check if the date is a new date
                                final bool isNewDate =
                                    previousDateTime == null ||
                                        currentDateTime.day !=
                                            previousDateTime.day ||
                                        currentDateTime.month !=
                                            previousDateTime.month ||
                                        currentDateTime.year !=
                                            previousDateTime.year;

                                return Column(
                                  children: [
                                    if (isNewDate)
                                      Center(
                                        child: Container(
                                          height: 32,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.white)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 35),
                                                child: Text(
                                                  formatDate(conversation.date),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (conversation.role == "sender")
                                      Align(
                                        alignment: FractionalOffset.centerRight,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final textPainter = TextPainter(
                                              text: TextSpan(
                                                  text: latestReplyToText),
                                              textDirection: TextDirection.ltr,
                                              maxLines:
                                                  1, // Ensure single-line measurement
                                            )..layout(
                                                maxWidth: constraints.maxWidth);

                                            final messageWidth =
                                                textPainter.width + 40;

                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                if (conversation.status ==
                                                    "failed")
                                                  Container(
                                                    // height: 16,
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8),

                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xFFAEAEB2))),
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: Text(
                                                            "재전송",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                conversation.isLink
                                                    ? const SizedBox(
                                                        height: 0,
                                                      )
                                                    : Text(
                                                        conversation.hour,
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: conversation
                                                              .isLink
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              0
                                                          : MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.6),
                                                  child: conversation.isLink
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 0),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Text(
                                                                        conversation
                                                                            .hour,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w300,
                                                                            color: Colors.white)),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              12,
                                                                          vertical:
                                                                              6),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        color: Colors
                                                                            .yellow,
                                                                      ),
                                                                      child:
                                                                          InkWell(
                                                                        child:
                                                                            Text(
                                                                          conversation
                                                                              .message,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          final RenderBox
                                                                              box =
                                                                              context.findRenderObject() as RenderBox;
                                                                          final Offset
                                                                              position =
                                                                              box.localToGlobal(Offset.zero);
                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            barrierColor:
                                                                                Colors.transparent,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return Container(
                                                                                padding: EdgeInsets.zero,
                                                                                child: Stack(
                                                                                  children: [
                                                                                    Positioned(
                                                                                      top: position.dy, // Set the top position based on the tapped widget's position
                                                                                      right: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(12),
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                // perform copy operation
                                                                                                Navigator.pop(context); // Close the dialog
                                                                                              },
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  SvgPicture.asset("images/copy.svg"),
                                                                                                  const SizedBox(
                                                                                                    width: 8,
                                                                                                  ),
                                                                                                  const Text(
                                                                                                    "복사",
                                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                // Perform delete operation
                                                                                                Navigator.pop(context); // Close the dialog
                                                                                              },
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  SvgPicture.asset("images/delete.svg"),
                                                                                                  const SizedBox(
                                                                                                    width: 8,
                                                                                                  ),
                                                                                                  const Text(
                                                                                                    "삭제",
                                                                                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    width: 262,
                                                                    height: 155,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(8),
                                                                        topRight:
                                                                            Radius.circular(8),
                                                                      ),
                                                                    ),
                                                                    child: Image.asset(
                                                                        conversation
                                                                            .previewImage),
                                                                  ),
                                                                  Container(
                                                                    width: 262,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Color(
                                                                          0xFFFFFFFF),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(8),
                                                                        bottomRight:
                                                                            Radius.circular(8),
                                                                      ),
                                                                    ),
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 9,
                                                                        right:
                                                                            8,
                                                                        bottom:
                                                                            8,
                                                                        left:
                                                                            8),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          conversation
                                                                              .previewTitle,
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              "images/blog_icon.png",
                                                                              height: 16,
                                                                              width: 16,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 4,
                                                                            ),
                                                                            Text(
                                                                              conversation.previewText,
                                                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          padding: conversation
                                                                  .isImage
                                                              ? const EdgeInsets
                                                                  .all(0)
                                                              : const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 6),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              color: Colors
                                                                  .yellow),
                                                          child: conversation
                                                                  .isImage
                                                              ? InkWell(
                                                                  overlayColor:
                                                                      const MaterialStatePropertyAll(
                                                                          Colors
                                                                              .transparent),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.0),
                                                                    child: Image
                                                                        .asset(
                                                                      conversation
                                                                          .message,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    final RenderBox
                                                                        box =
                                                                        context.findRenderObject()
                                                                            as RenderBox;
                                                                    final Offset
                                                                        position =
                                                                        box.localToGlobal(
                                                                            Offset.zero);
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierColor:
                                                                          Colors
                                                                              .transparent,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Container(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Positioned(
                                                                                top: position.dy,
                                                                                left: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(12),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          // perform copy operation
                                                                                          Navigator.pop(context); // Close the dialog
                                                                                        },
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SvgPicture.asset("images/copy.svg"),
                                                                                            const SizedBox(
                                                                                              width: 8,
                                                                                            ),
                                                                                            const Text(
                                                                                              "복사",
                                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          // Perform delete operation
                                                                                          Navigator.pop(context); // Close the dialog
                                                                                        },
                                                                                        child: Row(
                                                                                          children: [
                                                                                            SvgPicture.asset("images/delete.svg"),
                                                                                            const SizedBox(
                                                                                              width: 8,
                                                                                            ),
                                                                                            const Text(
                                                                                              "삭제",
                                                                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                )
                                                              : conversation
                                                                      .isReply!
                                                                  ? InkWell(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            latestReplyToText,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color(0xFFA2BC02)),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                messageWidth - 40,
                                                                            child:
                                                                                const Divider(
                                                                              height: 2,
                                                                              thickness: 1,
                                                                              color: Color(0xFFA2BC02),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            conversation.message,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            context.findRenderObject()
                                                                                as RenderBox;
                                                                        final Offset
                                                                            position =
                                                                            box.localToGlobal(Offset.zero);
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierColor:
                                                                              Colors.transparent,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              padding: EdgeInsets.zero,
                                                                              child: Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    top: position.dy,
                                                                                    right: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // perform copy operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/copy.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "복사",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // Perform delete operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/delete.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "삭제",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    )
                                                                  : InkWell(
                                                                      child:
                                                                          Text(
                                                                        conversation
                                                                            .message,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            context.findRenderObject()
                                                                                as RenderBox;
                                                                        final Offset
                                                                            position =
                                                                            box.localToGlobal(Offset.zero);
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierColor:
                                                                              Colors.transparent,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              padding: EdgeInsets.zero,
                                                                              child: Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    top: position.dy, // Set the top position based on the tapped widget's position
                                                                                    right: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // perform copy operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/copy.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "복사",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // Perform delete operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/delete.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "삭제",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    )),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (conversation.role == "receiver")
                                      Align(
                                        alignment: FractionalOffset.centerLeft,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      child: Stack(children: [
                                                        Container(
                                                          width: 32,
                                                          height: 32,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFFDBFF00),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image.asset(
                                                              users[0]
                                                                  .imagePath,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                            right: 0,
                                                            bottom: 0,
                                                            child: SvgPicture
                                                                .asset(
                                                              "images/profile_emoji_small.svg",
                                                            ))
                                                      ]),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          users[0].name,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        ConstrainedBox(
                                                            constraints: BoxConstraints(
                                                                maxWidth: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.5),
                                                            child: Container(
                                                              padding: conversation
                                                                      .isImage
                                                                  ? const EdgeInsets
                                                                      .all(0)
                                                                  : const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          6),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: const Color(
                                                                      0xFF545456)),
                                                              child: conversation
                                                                      .isImage
                                                                  ? InkWell(
                                                                      overlayColor:
                                                                          const MaterialStatePropertyAll(
                                                                              Colors.transparent),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                        child: Image
                                                                            .asset(
                                                                          conversation
                                                                              .message,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            context.findRenderObject()
                                                                                as RenderBox;
                                                                        final Offset
                                                                            position =
                                                                            box.localToGlobal(Offset.zero);
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierColor:
                                                                              Colors.transparent,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              padding: EdgeInsets.zero,
                                                                              child: Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    top: position.dy, // Set the top position based on the tapped widget's position
                                                                                    left: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // perform copy operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/copy.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "복사",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // Perform delete operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/delete.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "삭제",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    )
                                                                  : InkWell(
                                                                      child:
                                                                          Text(
                                                                        conversation
                                                                            .message,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        final RenderBox
                                                                            box =
                                                                            context.findRenderObject()
                                                                                as RenderBox;
                                                                        final Offset
                                                                            position =
                                                                            box.localToGlobal(Offset.zero);
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierColor:
                                                                              Colors.transparent,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              padding: EdgeInsets.zero,
                                                                              child: Stack(
                                                                                children: [
                                                                                  Positioned(
                                                                                    top: position.dy, // Set the top position based on the tapped widget's position
                                                                                    left: MediaQuery.of(context).size.width - position.dx - box.size.width + 40,
                                                                                    child: Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              setState(() {
                                                                                                replyToText = conversation.message;
                                                                                              });

                                                                                              _focusNode.requestFocus(); // Open the keyboard on the text field
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/reply.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "답글달기",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // perform copy operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/copy.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "복사",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SvgPicture.asset("images/pop_up_divider.svg"),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              // Perform delete operation
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/delete.svg"),
                                                                                                const SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "삭제",
                                                                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFFF0089)),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  conversation.hour,
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF242426),
            margin: const EdgeInsets.only(top: 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  replyToText != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("images/reply.svg"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "말랑한 우동/호스트 에게 답장",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0XFF0099FF)),
                                    ),
                                    Text(
                                      replyToText.length > 25
                                          ? replyToText.substring(0, 27) + "..."
                                          : replyToText,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      replyToText = "";
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "images/close_icon.svg",
                                    width: 24,
                                    height: 24,
                                  )),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  replyToText != ""
                      ? const SizedBox(
                          height: 14,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showImageSendBottomSheet(
                              context,
                              "카메라",
                              "images/from_camera.png",
                              "images/from_gallary.png",
                              "사진 앨범",
                              "닫기");
                        },
                        child: Image.asset(
                          "images/from_camera.png",
                          width: 32,
                          height: 32,
                          color: const Color(0xFFAEAEB2),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          focusNode: _focusNode,
                          autofocus: false,

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: '메시지를 남겨주세요',
                            hintStyle:
                                const TextStyle(color: Color(0xFFAEAEB2)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide:
                                  const BorderSide(color: Color(0xFF545456)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide:
                                  const BorderSide(color: Color(0xFF545456)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // Submit the message
                                if (replyToText != "") {
                                  setState(() {
                                    // conversations.add(Conversation(
                                    //   10,
                                    //   "sender",
                                    //   _chatController.text,
                                    //   "2016-12-28",
                                    //   "오전 11:24",
                                    //   false,
                                    //   false,
                                    //   "success",
                                    //   true,
                                    //   replyToText,
                                    //   _chatController.text,
                                    //   "",
                                    //   "",
                                    //   "",
                                    // ));

                                    _chatController.text = "";
                                    latestReplyToText = replyToText;
                                    replyToText = "";
                                    _focusNode.unfocus();
                                  });
                                  setState(() {
                                    replyToText = "";
                                  });
                                  showPopupText(context, "복사 되었습니다.", 100);
                                } else {
                                  setState(() {
                                    conversations.add(Conversation(
                                        10,
                                        "sender",
                                        _chatController.text,
                                        "2016-12-28",
                                        "오전 12:24",
                                        false,
                                        false,
                                        "success",
                                        false,
                                        "",
                                        "",
                                        "",
                                        //   "",
                                        "",
                                        ""
                                        //
                                        ));

                                    _chatController.text = "";
                                    replyToText = "";
                                    _focusNode.unfocus();
                                  });
                                }
                              },
                              child: Image.asset("images/send_message.png",
                                  height: 24,
                                  width: 24,
                                  color: _chatController.text == ""
                                      ? const Color(0xFFAEAEB2)
                                      : const Color(0xFFDBFF00)),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF444446),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                          ),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          maxLines: null, // Allows multiple lines
                          textInputAction:
                              TextInputAction.newline, // Enables newline input
                          onChanged: (value) {
                            _checkIfInputIsEmpty(value);
                          },
                          onSubmitted: (value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
