import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  String role;
  String date;
  String hour;
  String status;
  bool isImage;
  String message;

  Conversation(
    this.role,
    this.message,
    this.date,
    this.hour,
    this.isImage,
    this.status,
  );
}

class _ChatRoomState extends State<ChatRoom> {
  List<UserData> users = [
    UserData("대화명", "images/profile_image.jpg",
        ["images/brand_1.png", "images/supreme.jpg", "images/brand_09.jpg"])
  ];

  List<Conversation> conversations = [
    Conversation(
        "sender", "안녕하세요~", "2016-12-25", "오전 11:24", false, "success"),
    Conversation("receiver", "안녕하세요*^^* 🤟🏻", "2016-12-25", "오전 11:50", false,
        "success"),
    Conversation("sender", "별다방님 다음달 고아웃 가실건가요?", "2016-12-25", "오전 11:55",
        false, "success"),
    Conversation(
        "sender", "전 갈려구요 👩🏼‍🌾", "2016-12-25", "오전 12:00", false, "success"),
    Conversation("receiver", "저도 갈건데 제가 내일 연락 드릴께요. 짐 머 좀 하고 있어서요 ^^",
        "2016-12-25", "오전 12:06", false, "success"),
    Conversation("receiver", "어제 죄송했어요. 고아웃 담달 가시게요?", "2016-12-26", "오전 12:10",
        false, "success"),
    Conversation("sender", "넵!!", "2016-12-26", "오전 04:15", false, "failed"),
  ];

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
  late bool _isInputEmpty;

  final _focusNode = FocusNode();

  RadioGroupController optionController = RadioGroupController();
  final GlobalKey<RadioGroupState> radioGroupKey1 =
      GlobalKey<RadioGroupState>();
  bool disabled = true;

  final GlobalKey commentsHeaderKey = GlobalKey();

  double commentsHeaderHeight = 0;

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _reportController = TextEditingController();
    _isInputEmpty = true;
    showForm = false;
    if (selectedIndex == 5) {
      showForm = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Sets initial size of comments bottom sheet. Thanks to it users always see just a header of the bottom sheet at the beginning.
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

  // final MediaQueryData mediaQueryData = MediaQuery.of(context);
  // final double heightOfDevice = mediaQueryData.size.height;
  // final double initialChildSize = (commentsHeaderHeight +
  //         mediaQueryData.viewPadding.bottom +
  //         mediaQueryData.viewPadding.top) /
  //     heightOfDevice;

  void showBottomSheet2(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.95),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.2,
          maxChildSize: 0.75,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    height: showForm
                        ? MediaQuery.of(context).size.height * 0.95
                        : MediaQuery.of(context).size.height * 0.65,
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
                                      selectedIndex = index;
                                      if (selectedIndex == 5) {
                                        showForm = true;
                                        print(options[5].toString());
                                      } else {
                                        showForm = false;
                                      }
                                    });
                                  },
                                  leading: SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: SvgPicture.asset(
                                      isSelected
                                          ? 'images/radio_button_selected.svg'
                                          : 'images/radio_button_unselected.svg',
                                      // Optional: Set a color for the SVG image
                                    ),
                                  ),
                                  title: Text(
                                    options[index],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
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
                                Container(
                                  height: 176,
                                  child: TextField(
                                    controller: _reportController,
                                    cursorColor: Colors.white,
                                    minLines: 10,

                                    maxLength: 500,
                                    maxLines: null, // Allows multiple lines
                                    textInputAction: TextInputAction
                                        .newline, // Enables newline input
                                    decoration: InputDecoration(
                                      hintText: '신고 내용을 입력해 주세요.',
                                      hintStyle: const TextStyle(
                                          color: Color(0xFFAEAEB2)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide(
                                            color: Color(0xFF7C7C80)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24),
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
                                            fontSize: 12, color: Colors.white),
                                      );
                                    },

                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),

                                    onChanged: (value) {},
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
                                        "images/import_image.svg"))
                              ]),
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
                                // margin: margin,
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
              child: Image.asset("images/back_arrow.png")),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () {
                  showBottomSheet2(context);
                },
                child: Image.asset("images/three_dots.png")),
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
                                  // width: 40,
                                  // height: 40,
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
                            // height: 900,

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
                                                  text: conversation.message),
                                              textDirection: TextDirection.ltr,
                                              maxLines:
                                                  1, // Ensure single-line measurement
                                            )..layout(
                                                maxWidth: constraints.maxWidth);

                                            final messageWidth =
                                                textPainter.width +
                                                    40; // Adjust for padding

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
                                                        // minWidth:  messageWidth ,
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.5),
                                                    // width: messageWidth,
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.yellow),
                                                      child: Text(
                                                        conversation.message,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    )),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    if (conversation.role == "receiver")

                                      //if (conversation.role == "sender")
                                      Align(
                                        alignment: FractionalOffset.centerLeft,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final textPainter = TextPainter(
                                              text: TextSpan(
                                                  text: conversation.message),
                                              textDirection: TextDirection.ltr,
                                              maxLines:
                                                  1, // Ensure single-line measurement
                                            )..layout(
                                                maxWidth: constraints.maxWidth);

                                            final messageWidth =
                                                textPainter.width +
                                                    40; // Adjust for padding

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
                                                              // width: 40,
                                                              // height: 40,
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
                                                            constraints:
                                                                BoxConstraints(
                                                                    //     minWidth: messageWidth,

                                                                    //
                                                                    maxWidth: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        1.5),
                                                            // width: messageWidth,
                                                            child: Container(
                                                              padding: EdgeInsets
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
                                                                  color: Color(
                                                                      0xFF545456)),
                                                              child: Text(
                                                                conversation
                                                                    .message,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white),
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

                  //  Input box
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  "images/from_camera.png",
                  width: 32,
                  height: 32,
                  color: Color(0xFFAEAEB2),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    focusNode: _focusNode,
                    autofocus: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: '메시지를 남겨주세요',
                      hintStyle: const TextStyle(color: Color(0xFFAEAEB2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Color(0xFF545456)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Color(0xFF545456)),
                      ),
                      suffixIcon: Image.asset("images/send_message.png",
                          height: 24,
                          width: 24,
                          color: _isInputEmpty
                              ? Color(0xFFAEAEB2)
                              : Color(0xFFDBFF00)),
                      filled: true,
                      fillColor: const Color(0xFF444446),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    maxLines: null, // Allows multiple lines
                    textInputAction:
                        TextInputAction.newline, // Enables newline input
                    onChanged: (value) {
                      _checkIfInputIsEmpty(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
