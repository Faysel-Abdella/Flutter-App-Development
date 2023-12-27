import 'package:flutter/material.dart';

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

  late TextEditingController _chatController;
  late bool _isInputEmpty;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _isInputEmpty = true;
  }

  @override
  void dispose() {
    _chatController.dispose();
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
                  Navigator.of(context).pop();
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
                                  crossAxisAlignment:
                                      conversation.role == "sender"
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                  children: [
                                    if (isNewDate)
                                      Text(conversation
                                          .date), // Show the date if it's a new date
                                    IntrinsicWidth(
                                      // width: 100,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        color: Colors.yellow,
                                        margin: const EdgeInsets.all(8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                conversation.role == "sender"
                                                    ? CrossAxisAlignment.end
                                                    : CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                conversation.message,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: conversation
                                                            .role ==
                                                        "sender"
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    conversation.hour,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
