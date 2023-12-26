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

class _ChatRoomState extends State<ChatRoom> {
  List<UserData> users = [
    UserData("대화명", "images/profile_image.jpg",
        ["images/brand_1.png", "images/supreme.jpg", "images/brand_09.jpg"])
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 92),
                  child: Column(
                    children: [
                      // The top of the message
                      Stack(children: [
                        Container(
                          width: 97,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(
                              color: Color(0xFFDBFF00),
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
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        users[0].name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Row(
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              users[0].brands[1],
                              height: 24,
                              width: 56,
                              fit: BoxFit.cover,
                            ),
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

                      // The body of the chat
                      Text(
                        "새로운\n대화를 시작하세요.",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  )),
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
      ),
    );
  }
}
