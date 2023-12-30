import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_app_gap/components/button.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

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
      this.replyText);
}

class _MyHomePageState extends State<ChatRoom> {
  Map<String, PreviewData> datas = {};

  List<String> get urls => const [
        'github.com/flyerhq',
        'https://u24.gov.ua',
        'https://twitter.com/SpaceX/status/1564975288655630338',
      ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.centerLeft,
          child: Container(
            key: ValueKey(urls[index]),
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Color(0xfff7f7f8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: LinkPreview(
                enableAnimation: true,
                onPreviewDataFetched: (data) {
                  setState(() {
                    datas = {
                      ...datas,
                      urls[index]: data,
                    };
                  });
                },
                previewData: datas[urls[index]],
                text: urls[index],
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatRoomState extends State<ChatRoom> {
  final FocusNode _focusNode = FocusNode();
  List<UserData> users = [
    UserData("대화명", "images/profile_image.jpg",
        ["images/brand_one.svg", "images/supreme.jpg", "images/brand_09.jpg"])
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

  ScrollController _scrollController = ScrollController();
  late bool _isInputEmpty;
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

  _onLayoutDone(_) {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(180,
            duration: Duration(milliseconds: 50), curve: Curves.ease);
      }
    });

    super.initState();
    _chatController = TextEditingController();
    _reportController = TextEditingController();
    _isInputEmpty = true;
    replyToText = "";
    latestReplyToText = "";
    _isNotificationTurnOn = false;
    showForm = false;
    if (selectedIndex == 5) {
      showForm = true;
    }

    conversations = [
      Conversation(1, "sender", "안녕하세요~", "2016-12-25", "오전 11:24", false,
          false, "success", false, "", ""),
      Conversation(2, "receiver", "안녕하세요*^^* 🤟🏻", "2016-12-25", "오전 11:50",
          false, false, "success", false, "", ""),
      Conversation(3, "sender", "별다방님 다음달 고아웃 가실건가요?", "2016-12-25", "오전 11:55",
          false, false, "success", false, "", ""),
      Conversation(4, "sender", "전 갈려구요 👩🏼‍🌾", "2016-12-25", "오전 12:00",
          false, false, "success", false, "", ""),
      Conversation(5, "receiver", "저도 갈건데 제가 내일 연락 드릴께요. 짐 머 좀 하고 있어서요 ^^",
          "2016-12-25", "오전 12:06", false, false, "success", false, "", ""),
      Conversation(6, "receiver", "어제 죄송했어요. 고아웃 담달 가시게요?", "2016-12-26",
          "오전 12:10", false, false, "success", false, "", ""),
      Conversation(7, "sender", "넵!!", "2016-12-26", "오전 04:15", false, false,
          "failed", false, "", ""),
      Conversation(8, "sender", "images/image_message.jpeg", "2016-12-26",
          "오전 06:36", true, false, "success", false, "", ""),
      Conversation(
          9,
          "sender",
          "https://github.com/Faysel-Abdella/Codeforces-Solutions",
          "2016-12-26",
          "오전 06:50",
          false,
          true,
          "success",
          false,
          "",
          ""),
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
      setState(() {
        _isInputEmpty = true;
      });
    } else {
      setState(() {
        _isInputEmpty = false;
      });
    }
  }

  void showPopupText(BuildContext context, String text, double marginBottom) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Close the dialog after 2 seconds
        });

        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 72,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.only(bottom: marginBottom),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/popup_emoji.png",
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          text,
                          style: TextStyle(
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
          padding: EdgeInsets.all(20),
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
                  textColor: Color(0xFF242426),
                  color: Color(0xFFDBFF00),
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
          padding: EdgeInsets.all(20),
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
                  textColor: Color(0xFF242426),
                  color: Color(0xFFDBFF00),
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
      //useRootNavigator: true,
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
                    //height: ,
                    // height: showForm
                    //   // MediaQuery.of(context).size.height * 0.95
                    //     : MediaQuery.of(context).size.height * 0.65,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25)),
                        color: Color(0xFF545456)),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
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
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            color: Color(0xFFD0CBC2),
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "‘말랑한 우동’ 사용자를 신고하는\n이유를 알려주세요.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SingleChildScrollView(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                          _scrollController.jumpTo(400);
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
                                    style: TextStyle(
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
                                SizedBox(
                                  height: 24,
                                ),
                                Divider(
                                  color: Color(0xFF444446),
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Align(
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
                                SizedBox(
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
                                      onTap: () {
                                        // _scrollController.jumpTo(400);
                                      },
                                      minLines: 10,
                                      scrollPadding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              16 * 4),
                                      maxLength: 500,
                                      //   focusNode: _focusNode,
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
                                          borderSide: BorderSide(
                                              color: Color(0xFF7C7C80)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide(
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
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        );
                                      },

                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),

                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "사진 첨부 (최대 4장)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                        "images/import_image.svg")),
                                SizedBox(
                                  height: 24,
                                ),
                                TextField(
                                  onTap: () {
                                    // _scrollController.jumpTo(20000);
                                  },
                                  // controller: _reportController,
                                  cursorColor: Color(0xFF0099FF),
                                  decoration: InputDecoration(
                                    hintText: '이메일 입력',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFFAEAEB2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFF7C7C80)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          BorderSide(color: Color(0xFF7C7C80)),
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
                                  onChanged: (value) {},
                                ),
                              ]),
                            ),
                          SizedBox(
                            height: 41,
                          ),

                          // The report button
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: selectedIndex != -1 &&
                                            selectedIndex != 5 ||
                                        selectedIndex == 5 &&
                                            _reportController.text.isNotEmpty
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
          margin: EdgeInsets.only(left: 5),
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
                      color: Color(0xFFDBFF00),
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
          padding: EdgeInsets.only(left: 16),
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
                    padding: EdgeInsets.only(
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
                      margin: EdgeInsets.only(top: 92),
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
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shrinkWrap: true,
                              itemCount: conversations.length,
                              physics: NeverScrollableScrollPhysics(),
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
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
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
                                                  style: TextStyle(
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
                                                    padding: EdgeInsets.all(4),
                                                    margin: EdgeInsets.only(
                                                        right: 8),

                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xFFAEAEB2))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
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
                                                Text(
                                                  conversation.hour,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.6),
                                                  child: Container(
                                                      padding: conversation
                                                              .isImage
                                                          ? EdgeInsets.all(0)
                                                          : EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.yellow),
                                                      child: conversation.isLink
                                                          ? null // Here preview the link
                                                          : conversation.isImage
                                                              ? InkWell(
                                                                  overlayColor:
                                                                      MaterialStatePropertyAll(
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
                                                                          // width: 200,
                                                                          // height: 200,
                                                                          child:
                                                                              Stack(
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
                                                                                            SizedBox(
                                                                                              width: 8,
                                                                                            ),
                                                                                            Text(
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
                                                                                            SizedBox(
                                                                                              width: 8,
                                                                                            ),
                                                                                            Text(
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
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Color(0xFFA2BC02)),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                messageWidth - 40,
                                                                            child:
                                                                                Divider(
                                                                              height: 2,
                                                                              thickness: 1,
                                                                              color: Color(0xFFA2BC02),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            conversation.message,
                                                                            style: TextStyle(
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
                                                                              // width: 200,
                                                                              // height: 200,
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                            TextStyle(
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
                                                                              // width: 200,
                                                                              // height: 200,
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                    SizedBox(
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
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          users[0].name,
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
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
                                                                  ? EdgeInsets
                                                                      .all(0)
                                                                  : EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          6),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: Color(
                                                                      0xFF545456)),
                                                              child: conversation
                                                                      .isImage
                                                                  ? InkWell(
                                                                      overlayColor:
                                                                          MaterialStatePropertyAll(
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
                                                                              // width: 200,
                                                                              // height: 200,
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                            TextStyle(
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
                                                                              // width: 200,
                                                                              // height: 200,
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
                                                                                              // Store the message in a temporary variable
                                                                                              setState(() {
                                                                                                replyToText = conversation.message;
                                                                                              });

                                                                                              _focusNode.requestFocus(); // Open the keyboard on the text field
                                                                                              Navigator.pop(context); // Close the dialog
                                                                                            },
                                                                                            child: Row(
                                                                                              children: [
                                                                                                SvgPicture.asset("images/reply.svg"),
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                                                                SizedBox(
                                                                                                  width: 8,
                                                                                                ),
                                                                                                Text(
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
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  conversation.hour,
                                                  style: TextStyle(
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
                                    SizedBox(
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
            color: Color(0xFF242426),
            margin: EdgeInsets.only(top: 20),
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
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
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
                                      style: TextStyle(
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
                      : SizedBox(
                          height: 0,
                        ),
                  replyToText != ""
                      ? SizedBox(
                          height: 14,
                        )
                      : SizedBox(
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
                          color: Color(0xFFAEAEB2),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _chatController,
                          focusNode: _focusNode,

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: '메시지를 남겨주세요',
                            hintStyle:
                                const TextStyle(color: Color(0xFFAEAEB2)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Color(0xFF545456)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Color(0xFF545456)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // Submit the message
                                if (replyToText != "") {
                                  setState(() {
                                    conversations.add(Conversation(
                                        10,
                                        "sender",
                                        _chatController.text,
                                        "2016-12-28",
                                        "오전 11:24",
                                        false,
                                        false,
                                        "success",
                                        true,
                                        replyToText,
                                        _chatController.text));

                                    _chatController.text = "";
                                    latestReplyToText = replyToText;
                                    replyToText = "";
                                    _focusNode.unfocus();

                                    // navigateToBottom();
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
                                        ""));

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
                                      ? Color(0xFFAEAEB2)
                                      : Color(0xFFDBFF00)),
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
                            print(replyToText);
                          },
                          onSubmitted: (value) {
                            // _checkIfInputIsEmpty(value);
                          },
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
